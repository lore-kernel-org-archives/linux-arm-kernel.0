From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 05 Aug 2015 18:54:00 +0200
Subject: [PATCH v2] ARM: dts: Convert Linkstation Mini to Device Tree
In-Reply-To: <1438027893.15635.41.camel@dolka.fr>
References: <1436885641.7145.9.camel@dolka.fr>	
 <20150718185238.GH17961@lunn.ch> <55B396A1.1090509@free-electrons.com>
 <1438027893.15635.41.camel@dolka.fr>
Message-ID: <55C23FA8.9030504@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benjamin,

On 27/07/2015 22:11, Benjamin Cama wrote:
> Hi Gr?gory,
> 
> Le samedi 25 juillet 2015 ? 16:01 +0200, Gregory CLEMENT a ?crit :
>> On 18/07/2015 20:52, Andrew Lunn wrote:
>>> On Tue, Jul 14, 2015 at 04:54:01PM +0200, Benjamin Cama wrote:
>>>> The name of the file better reflects the manufacturer's device name
>>>> (LS-WSGL) than the original (lsmini), which exists in a kirkwood version
>>>> too.
>>>>
>>>> Signed-off-by: Benjamin Cama <benoar@dolka.fr>
>>>> ---
>>>> Alexey, Thomas,
>>>>
>>>> I need your approval to change the license, as Jason and Andrew
>>>> suggested using dual licensing. Do you agree with it?
>>>>
>>>> The changes since the first version are:
>>>> * the license change;
>>>> * the more precise attribution to Alexey;
>>>> * gpio keys are now named, even if I find them not to be the good ones;
>>>>   at least they fit with the old numbers and the recently submitted
>>>>   LS-WSXL scheme;
>>>> * added "earlyprintk" to the command-line
>>>>
>>>> I did not rename the leds to be like LS-WSXL, as they are a bit
>>>> different. I also did not take time to look at the NOR flash layout to
>>>> separate uboot from the config (that must be all there is in these
>>>> 256KB).
>>>>
>>>> Hope the patch is OK like that. Sorry for the long delay, I spent quite
>>>> some time on the IRQ0 fix, and did not have so much of it lately???
>>>>
>>>>  arch/arm/boot/dts/Makefile           |   3 +-
>>>>  arch/arm/boot/dts/orion5x-lswsgl.dts | 276 ++++++++++++++++++++++++++++++++++
>>>>  arch/arm/mach-orion5x/Kconfig        |   6 +-
>>>>  arch/arm/mach-orion5x/lsmini-setup.c | 280 -----------------------------------
>>>>  4 files changed, 281 insertions(+), 284 deletions(-)
>>>>  create mode 100644 arch/arm/boot/dts/orion5x-lswsgl.dts
>>>>  delete mode 100644 arch/arm/mach-orion5x/lsmini-setup.c
>>>>
>>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>>> index 992736b..bd5ad2f 100644
>>>> --- a/arch/arm/boot/dts/Makefile
>>>> +++ b/arch/arm/boot/dts/Makefile
>>>> @@ -441,7 +441,8 @@ dtb-$(CONFIG_ARCH_ORION5X) += \
>>>>  > > > 	> > > orion5x-lacie-d2-network.dtb \
>>>>  > > > 	> > > orion5x-lacie-ethernet-disk-mini-v2.dtb \
>>>>  > > > 	> > > orion5x-maxtor-shared-storage-2.dtb \
>>>> -> > > 	> > > orion5x-rd88f5182-nas.dtb
>>>> +> > > 	> > > orion5x-rd88f5182-nas.dtb \
>>>> +> > > 	> > > orion5x-lswsgl.dtb
>>>
>>> Hi Benjamin
>>>
>>> Please keep these in alphabetical order.
>>>
>>> Other than that:
>>>
>>> Acked-by: Andrew Lunn <andrew@lunn.ch>
>>
>> With the Acked-by from  Andrew Lunn I am ready to apply your patch.
>> However for the device tree I need the acked-by from Thomas Petazzoni but I
>> am sure he will give it as he already agreed for the armada-*.dts* files.
>>
>> I am not sure we need the formal acked-by from Alexey because the dts is
>> not based on a dts written by him.
> 
> It's just that I took all the devices definition from his .c; to me, it
> counts as derived work, but IANAL.

For me it is still the decription of the hardware not an derivated work.
Andrew what is your opinion on it?

But if we consider it as a derivated work then we need Alexey acked-by soon,
or going back to GPL only license.

> 
>> When you will send the v3 with the alphabetical order fixed and the acked-by
>> from Thomas Petazzoni I will apply it on the mvebu branches.
> 
> Thanks.
> 
>> In this v3, could you also remove  the reference to lsmini-setup.o in
>> arch/arm/mach-orion5x/Makefile ?
> 
> Yes, I spotted that lately.
> 
> Still, I am struggling with some more mistakes: the kernel boot with
> everything included, but for some reason it cannot boot with an initrd.
> At first, I got an ?INITRD: [?] overlaps in-use memory region -
> disabling initrd? that disappeared when removing the memory node from
> the dts. But I cannot reproduce it since, and now I sometimes get told
> that the initrd is corrupt, sometimes it isn't taken into account? my
> way of tweaking my configs and not being strict enough in keeping them
> around leads to a nightmare tracking this problem.
> 
> I now learned that I need CONFIG_ARM_ATAG_DTB_COMPAT to get the
> bootloader command-line and initrd address, but sometimes it mess with
> my setup. I have very weird behavior regarding console output
> (sometimes working, sometimes only with earlyprintk) and options around
> dtb/ATAGS. I am trying to sort this out.

I think we had similar issue on the Mirabox when we use the uImage. How do
you build the uImage, the value of LOADADRR is sensible.

> 
> BTW, during orion5x conversion to DT (for boards that support it),
> tag_fixup_mem32 was lost. It should not be needed as
> arch/arm/boot/compressed/atags_to_fdt.c:atags_to_fdt ditches zero-sized
> memory banks, and mines don't have anything above PAGE_MASK, but maybe
> it happens on some strange boards. I noticed it while looking at my
> overlapping memory regions bug.

Well I would be tempt by saying that if nobody complains about it, then
there is no problem :)

I also wants to warn you that usually we don't take any new code after the
-rc6 which should be release this week-end. After this then the code will
be a candidate for the 4.4 kernel.


Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
