From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 21 Jul 2014 10:38:25 -0600
Subject: [GIT PULL 2/3] ARM: tegra: move fuse code out of arch/arm
In-Reply-To: <20140721155451.GF32578@arm.com>
References: <1403558626-13422-1-git-send-email-swarren@wwwdotorg.org>
 <1403558626-13422-2-git-send-email-swarren@wwwdotorg.org>
 <20140707004417.GE8469@quad.lixom.net>
 <20140708134359.GA23218@tbergstrom-lnx.Nvidia.com>
 <CAOesGMhoqvqf-dktp-OfUNTPLahPwkyAPiTeDngr4QjH=VfOGA@mail.gmail.com>
 <53C88A4C.3070304@wwwdotorg.org>
 <CAOesGMh+zLV781wzdR5=_Bpzh+XMwJfWL-5XMDP6DwG_Hg80kw@mail.gmail.com>
 <53CD2C58.6060601@wwwdotorg.org> <20140721155451.GF32578@arm.com>
Message-ID: <53CD4201.5070705@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/21/2014 09:54 AM, Catalin Marinas wrote:
> On Mon, Jul 21, 2014 at 09:06:00AM -0600, Stephen Warren wrote:
>> On 07/17/2014 11:33 PM, Olof Johansson wrote:
>>> On Thu, Jul 17, 2014 at 7:45 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>>> On 07/08/2014 11:47 AM, Olof Johansson wrote:
>>>>> On Tue, Jul 8, 2014 at 6:43 AM, Peter De Schrijver
>>>>> <pdeschrijver@nvidia.com> wrote:
>>>>>> On Mon, Jul 07, 2014 at 02:44:17AM +0200, Olof Johansson wrote:
>>>>>>> On Mon, Jun 23, 2014 at 03:23:45PM -0600, Stephen Warren wrote:
>>>>>>>> This branch moves code related to the Tegra fuses out of arch/arm and
>>>>>>>> into a centralized location which could be shared with ARM64. It also
>>>>>>>> adds support for reading the fuse data through sysfs.
>>>>>>>
>>>>>>> The new/moved misc driver isn't acked by any misc maintainer, so I can't
>>>>>>> take this branch.
>>>>>>>
>>>>>>> I saw no indication from searching the mailing list of that either,
>>>>>>> so it wasn't just a missed acked-by.
>>>>>>>
>>>>>>> I wonder if this code should go under drivers/soc/ instead?
>>>>>>
>>>>>> It's modelled after sunxi_sid.c which lives in drivers/misc/eeprom/.
>>>>>> Originally this driver was also in drivers/misc/eeprom/, but Stephen objected
>>>>>> and therefore it was moved to drivers/misc/fuse. I think that's the right
>>>>>> place still.
>>>>>
>>>>> I disagree, I think this belongs under drivers/soc. Especially since
>>>>> you're adding dependencies on this misc driver from other parts of the
>>>>> kernel / other drivers.
>>>>>
>>>>> I also don't like seeing init calls form platform code down into
>>>>> drivers/misc like you're adding here. Can you please look at doing
>>>>> that as a regular init call setup?
>>>>
>>>> I strongly disagree with using init calls for this kind of thing. There
>>>> are ordering dependencies between the initialization code that can only
>>>> be sanely managed by explicitly calling functions in a particular order;
>>>> there's simply no way to manage this using initcalls. This is exactly
>>>> why the hooks in the ARM machine descriptors exist...
>>>
>>> Right, but there are non on 64-bit, so you need to solve it for there
>>> anyway. And once it's solved there, you might as well keep it common
>>> with 32-bit.
>>
>> My assertion is that we should just do it directly on 64-bit too.
>> There's no reason for arm64 to deviate from what arch/arm does already.
> 
> On arm64, I really want to get away from any SoC specific early
> initcall. One of the main reason is for things like SCU, interconnects,
> system cache configurations (even certain clocks) to be enabled in
> firmware before Linux starts (it's an education process but that's a way
> for example to prevent people sending patches to enable SoC coherency
> because they haven't thought about it before upstreaming).
> 
> It would be nice to be able to initialise SoC stuff at device_initcall()
> level (and even keep such code as modules in initramfs) but one of the
> problems we have is dependency on clocks (and the clock model which
> doesn't follow the device/driver model). The of_platform_populate() is
> called at arch_initcall_sync (after arch_initcall to still allow some
> SoC code, if needed, to run at arch_initcall).

The main thing I want to avoid is a ton of separate drivers that all
rely on each-other getting resolved by deferred probe. While that might
work out, it seems pointless to make the kernel try and probe a bunch of
stuff just to have it fail and get repeated, when we know exactly which
order everything should get initialized in.

Another issue is that we have SoCs which only differ in the CPU. I want
the code to work identically on both SoCs so the CPU has limited affect
on the low-level IO code. If we're going to enforce a "no machine
descriptors" rule on arch/arm64, I think we should do the same thing in
arch/arm for consistency.

> We have a similar issue with arm64 vexpress (well, just on the model)
> where vexpress_sysreg_init() is a core_initcall (should be fine as
> arch_initcall) as it needs to be done before of_platform_populate().
> Pawel on cc should know more of the history here.
> 
> I recall there were also some discussions about a SoC driver model which
> hangs off the top compatible string in the DT (e.g. "arm,vexpress") and
> allow (minimal) code to be run slightly earlier, though still not
> earlier than arch_initcall.

I guess that would work out OK; if we force the driver that binds to a
top-level compatible value of "nvidia,tegraNNN" to probe first, and it
then calls out to all the low-level init code in a sane order, that
would solve the problem. I'm not sure that's any better than having a
machine descriptor with an "init" function though; wrapping all this in
a driver just seems like overhead, but it would work out OK.
