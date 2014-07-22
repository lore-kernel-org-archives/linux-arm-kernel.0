From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 22 Jul 2014 18:04:15 +0100
Subject: [GIT PULL 2/3] ARM: tegra: move fuse code out of arch/arm
In-Reply-To: <53CE8FB1.4060307@wwwdotorg.org>
References: <20140707004417.GE8469@quad.lixom.net>
 <20140708134359.GA23218@tbergstrom-lnx.Nvidia.com>
 <CAOesGMhoqvqf-dktp-OfUNTPLahPwkyAPiTeDngr4QjH=VfOGA@mail.gmail.com>
 <53C88A4C.3070304@wwwdotorg.org>
 <CAOesGMh+zLV781wzdR5=_Bpzh+XMwJfWL-5XMDP6DwG_Hg80kw@mail.gmail.com>
 <53CD2C58.6060601@wwwdotorg.org> <20140721155451.GF32578@arm.com>
 <53CD4201.5070705@wwwdotorg.org> <20140722112651.GC2219@arm.com>
 <53CE8FB1.4060307@wwwdotorg.org>
Message-ID: <20140722170415.GU2219@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 22, 2014 at 05:22:09PM +0100, Stephen Warren wrote:
> On 07/22/2014 05:26 AM, Catalin Marinas wrote:
> > On Mon, Jul 21, 2014 at 05:38:25PM +0100, Stephen Warren wrote:
> >> On 07/21/2014 09:54 AM, Catalin Marinas wrote:
> >>> On arm64, I really want to get away from any SoC specific early
> >>> initcall. One of the main reason is for things like SCU, interconnects,
> >>> system cache configurations (even certain clocks) to be enabled in
> >>> firmware before Linux starts (it's an education process but that's a way
> >>> for example to prevent people sending patches to enable SoC coherency
> >>> because they haven't thought about it before upstreaming).
> >>>
> >>> It would be nice to be able to initialise SoC stuff at device_initcall()
> >>> level (and even keep such code as modules in initramfs) but one of the
> >>> problems we have is dependency on clocks (and the clock model which
> >>> doesn't follow the device/driver model). The of_platform_populate() is
> >>> called at arch_initcall_sync (after arch_initcall to still allow some
> >>> SoC code, if needed, to run at arch_initcall).
> >>
> >> The main thing I want to avoid is a ton of separate drivers that all
> >> rely on each-other getting resolved by deferred probe. While that might
> >> work out, it seems pointless to make the kernel try and probe a bunch of
> >> stuff just to have it fail and get repeated, when we know exactly which
> >> order everything should get initialized in.
> > 
> > So of_platform_populate() is called at arch_initcall_sync() level on
> > arm64. This allows at least two levels of probing separation before
> > (e.g. drivers registered as arch_initcall) and after (device_initcall).
> > If you register a driver earlier than arch_initcall_sync (see for
> > example vexpress_osc_init), it will get probed when the platform devices
> > are populated. Any later device_initcalls will get probed when the
> > corresponding drivers are registered. If you need ordering between
> > device_initcalls, I would recommend deferred probing.
> > 
> > The tricky part is if you need more drivers to be initialised at
> > arch_initcall_sync() in a specific order.
> 
> I believe relying on initcall ordering, even in the case where there are
> enough initcall levels to achieve a particular SoC's needs, is
> completely and utterly the wrong way to go.

I don't like it either and I agree that there may not be enough
initcalls. But I'm ok with using two levels like arch_initcall() for
something like fuse and device_initcall() for the rest. If that's not
enough (I haven't looked in detail at Tegra), with Pawel's patch you can
get a SoC specific probe where you can call the initialisation in the
right order.

Tegra is not the first nor the last platform with such issue. Is there
anything we could do better at the DT or driver registration level
(other than introducing machine_desc)?

-- 
Catalin
