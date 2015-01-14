From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Jan 2015 10:51:10 +0000
Subject: [PATCH] ARM: dts: hip04: move bootwrapper to SRAM
In-Reply-To: <54B4F48B.6020206@suse.de>
References: <54B48D5E.6050902@hisilicon.com> <9190510.INCMcmsads@wuerfel>
 <54B4DA7E.2020602@hisilicon.com> <3703587.1qvjMFgdrL@wuerfel>
 <54B4F350.5040007@hisilicon.com> <54B4F48B.6020206@suse.de>
Message-ID: <20150114105109.GB12069@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 10:33:47AM +0000, Alexander Graf wrote:
> 
> 
> On 13.01.15 11:28, Wei Xu wrote:
> > 
> > 
> > On 2015/1/13 17:02, Arnd Bergmann wrote:
> >> On Tuesday 13 January 2015 16:42:38 Wei Xu wrote:
> >>> On 2015/1/13 16:33, Arnd Bergmann wrote:
> >>>> On Tuesday 13 January 2015 11:13:34 Wei Xu wrote:
> >>>>> There is 8MB SRAM in hip04.
> >>>>> Moving the bootwrapper into SRAM could avoid to worry about poking
> >>>>> holes into DRAM memory or allocation algorithms either.
> >>>>>
> >>>>> Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
> >>>>> ---
> >>>>>  arch/arm/boot/dts/hip04.dtsi | 2 +-
> >>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
> >>>>> index 2388145..f0dfac7 100644
> >>>>> --- a/arch/arm/boot/dts/hip04.dtsi
> >>>>> +++ b/arch/arm/boot/dts/hip04.dtsi
> >>>>> @@ -22,7 +22,7 @@
> >>>>>  
> >>>>>         bootwrapper {
> >>>>>         compatible = "hisilicon,hip04-bootwrapper";
> >>>>> -       boot-method = <0x10c00000 0x10000>, <0xe0000100 0x1000>;
> >>>>> +       boot-method = <0xe00f0000 0x10000>, <0xe0000100 0x1000>;
> >>>>>         };
> >>>
> >>> Hi Arnd,
> >>>  
> >>>> Is this backwards compatible with old firmware?
> >>>
> >>> Sorry, it is not backwards compatible.
> >>> Another reason is that it could support opensuse 
> >>> more smoothly.
> >>>
> >>> I have updated the firmware and uploaded it 
> >>> into Linaro Hisilicon git tree last month.
> >>> We will update the wiki on Linaro soon.
> >>>
> >>> Do you think it is OK?
> > 
> > Hi Arnd,
> > 
> >> Generally speaking it's not ok to change firmware interfaces in
> >> an incompatible way. The preferred way to handle this would be
> >> to have the firmware that puts the boot wrapper into a different
> >> place also update this property, if at all possible.
> > 
> > I very agreed with you.
> > 
> > But before we have two kind of firmwares one is boot from SVC supporting
> > PXE/NAND/SATA/GRUB booting and the other is boot from HYP just supporting NAND
> > booting.
> > This time we updated the firmware and made it boot from HYP supporting 
> > PXE/NAND/SATA/GRUB as we hoped(thanks for Alex's supporting!).
> > 
> > Since we have to publish a new firmware I think it is a chance to 
> > update the dts of kernel. How do you think about it?
> 
> The main problem is that on this platform, the device tree doesn't
> necessarily come from UEFI. If you boot using grub for example, you need
> to manually pass in the device tree as a file in your grub
> configuration, because 32bit ARM Linux doesn't have an EFI stub that
> fetches it directly from EFI.

For arm64, upstream GRUB can acquire a DTB from EFI by GUID and pass to
a non EFI stub kernel. Is that not the case for 32-bit ARM?

Thanks,
Mark.
