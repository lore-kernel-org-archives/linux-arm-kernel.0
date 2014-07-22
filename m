From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 22 Jul 2014 10:22:09 -0600
Subject: [GIT PULL 2/3] ARM: tegra: move fuse code out of arch/arm
In-Reply-To: <20140722112651.GC2219@arm.com>
References: <1403558626-13422-1-git-send-email-swarren@wwwdotorg.org>
 <1403558626-13422-2-git-send-email-swarren@wwwdotorg.org>
 <20140707004417.GE8469@quad.lixom.net>
 <20140708134359.GA23218@tbergstrom-lnx.Nvidia.com>
 <CAOesGMhoqvqf-dktp-OfUNTPLahPwkyAPiTeDngr4QjH=VfOGA@mail.gmail.com>
 <53C88A4C.3070304@wwwdotorg.org>
 <CAOesGMh+zLV781wzdR5=_Bpzh+XMwJfWL-5XMDP6DwG_Hg80kw@mail.gmail.com>
 <53CD2C58.6060601@wwwdotorg.org> <20140721155451.GF32578@arm.com>
 <53CD4201.5070705@wwwdotorg.org> <20140722112651.GC2219@arm.com>
Message-ID: <53CE8FB1.4060307@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2014 05:26 AM, Catalin Marinas wrote:
> On Mon, Jul 21, 2014 at 05:38:25PM +0100, Stephen Warren wrote:
>> On 07/21/2014 09:54 AM, Catalin Marinas wrote:
>>> On arm64, I really want to get away from any SoC specific early
>>> initcall. One of the main reason is for things like SCU, interconnects,
>>> system cache configurations (even certain clocks) to be enabled in
>>> firmware before Linux starts (it's an education process but that's a way
>>> for example to prevent people sending patches to enable SoC coherency
>>> because they haven't thought about it before upstreaming).
>>>
>>> It would be nice to be able to initialise SoC stuff at device_initcall()
>>> level (and even keep such code as modules in initramfs) but one of the
>>> problems we have is dependency on clocks (and the clock model which
>>> doesn't follow the device/driver model). The of_platform_populate() is
>>> called at arch_initcall_sync (after arch_initcall to still allow some
>>> SoC code, if needed, to run at arch_initcall).
>>
>> The main thing I want to avoid is a ton of separate drivers that all
>> rely on each-other getting resolved by deferred probe. While that might
>> work out, it seems pointless to make the kernel try and probe a bunch of
>> stuff just to have it fail and get repeated, when we know exactly which
>> order everything should get initialized in.
> 
> So of_platform_populate() is called at arch_initcall_sync() level on
> arm64. This allows at least two levels of probing separation before
> (e.g. drivers registered as arch_initcall) and after (device_initcall).
> If you register a driver earlier than arch_initcall_sync (see for
> example vexpress_osc_init), it will get probed when the platform devices
> are populated. Any later device_initcalls will get probed when the
> corresponding drivers are registered. If you need ordering between
> device_initcalls, I would recommend deferred probing.
> 
> The tricky part is if you need more drivers to be initialised at
> arch_initcall_sync() in a specific order.

I believe relying on initcall ordering, even in the case where there are
enough initcall levels to achieve a particular SoC's needs, is
completely and utterly the wrong way to go.

Or at least, that's what the mantra has been for arch/arm for the last
few years. There's been plenty of active work to get away from
initcalls. Why should arch/arm64 be any different? Some consistency of
maintainer viewpoints would be nice.

(Note that I'm talking here about lots of separate initcalls that only
work in the right order due to manually assigning them initcall levels
that happen to work in the right order. Having a single initcall
function that explicitly calls all other initialization functions in the
right order is entirely different)

Disadvantages of using initcalls are:

* Not enough levels, so it's not generic/scalable.

* If you need to re-order things, you need to change the initcall level
of a bunch of stuff before/after it. This isn't scalable.

* It's hard to track them all down. Admittedly grep works, but that's a
lot more painful than just reading a function that calls other functions
explicitly.

* Each initcall has to determine if it's running on the correct HW or
not, rather than doing it once in a single top-level initcall, or in a
hook that only gets called at the right time.

...
>> Another issue is that we have SoCs which only differ in the CPU.
> 
> Do you mean ARMv7 vs ARMv8 CPUs?

Yes.
