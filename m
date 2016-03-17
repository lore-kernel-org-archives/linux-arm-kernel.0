From: loic.pallardy@st.com (Loic PALLARDY)
Date: Thu, 17 Mar 2016 09:05:53 +0000
Subject: [STLinux Kernel] [PATCH v5 7/7] ARM: STiH407: Move over to
 using the 'reserved-memory' API for obtaining DMA memory
In-Reply-To: <20160316201051.GA10042@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1452602781-22424-1-git-send-email-lee.jones@linaro.org>
 <1452602781-22424-8-git-send-email-lee.jones@linaro.org>
 <20160316163508.GA8396@griffinp-ThinkPad-X1-Carbon-2nd>
 <20160316165526.GZ13692@x1>
 <20160316201051.GA10042@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <D0C04901035AEF47BB4C8387F4AA41F5359967@SAFEX1NODE23.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee, Pete,

The coprocessor memory map defined below is for test. Addresses have been arbitrary fixed.
The audio and video firmware you want to use are for product configuration.
For sure memory mapping must be adapted or firmware recompiled.

About coherency between firmware characteristics (linked address, position independent or not, size) and DT definition, you're right, some checks are missing in this version. It shouldn't be possible to load/start a firmware if DT reserved memory is not aligned with firmware resource table and firmware start address.

Lee, I propose to have a short discussion during next ST LT weekly meeting to list missing features and identify ST internal remoteproc patches for upstream.

Regards,
Loic

> -----Original Message-----
> From: Peter Griffin [mailto:peter.griffin at linaro.org]
> Sent: Wednesday, March 16, 2016 9:11 PM
> To: Lee Jones <lee.jones@linaro.org>
> Cc: ohad at wizery.com; devicetree at vger.kernel.org; f.fainelli at gmail.com;
> kernel at stlinux.com; Nathan_Lynch at mentor.com; linux-
> kernel at vger.kernel.org; s-anna at ti.com; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [STLinux Kernel] [PATCH v5 7/7] ARM: STiH407: Move over to
> using the 'reserved-memory' API for obtaining DMA memory
> 
> Hi Lee,
> 
> On Wed, 16 Mar 2016, Lee Jones wrote:
> 
> > On Wed, 16 Mar 2016, Peter Griffin wrote:
> >
> > > Hi Lee,
> > >
> > > On Tue, 12 Jan 2016, Lee Jones wrote:
> > >
> > > > Doing so saves quite a bit of code in the driver.
> > > >
> > > > For more information on the 'reserved-memory' bindings see:
> > > >
> > > >
> > > > Documentation/devicetree/bindings/reserved-memory/reserved-
> memory.
> > > > txt
> > > >
> > > > Suggested-by: Suman Anna <s-anna@ti.com>
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > ---
> > > >  arch/arm/boot/dts/stih407-family.dtsi | 46
> > > > +++++++++++++++++++++++++++++------
> > > >  1 file changed, 38 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/arch/arm/boot/dts/stih407-family.dtsi
> > > > b/arch/arm/boot/dts/stih407-family.dtsi
> > > > index 15c20b6..27b8efc 100644
> > > > --- a/arch/arm/boot/dts/stih407-family.dtsi
> > > > +++ b/arch/arm/boot/dts/stih407-family.dtsi
> > > > @@ -15,6 +15,36 @@
> > > >  	#address-cells = <1>;
> > > >  	#size-cells = <1>;
> > > >
> > > > +	reserved-memory {
> > > > +		#address-cells = <1>;
> > > > +		#size-cells = <1>;
> > > > +		ranges;
> > > > +
> > > > +		gp0_reserved: rproc at 40000000 {
> > > > +			compatible = "shared-dma-pool";
> > > > +			reg = <0x40000000 0x01000000>;
> > > > +			no-map;
> > > > +		};
> > > > +
> > > > +		gp1_reserved: rproc at 41000000 {
> > > > +			compatible = "shared-dma-pool";
> > > > +			reg = <0x41000000 0x01000000>;
> > > > +			no-map;
> > > > +		};
> > > > +
> > > > +		audio_reserved: rproc at 42000000 {
> > > > +			compatible = "shared-dma-pool";
> > > > +			reg = <0x42000000 0x01000000>;
> > > > +			no-map;
> > > > +		};
> > > > +
> > > > +		dmu_reserved: rproc at 43000000 {
> > > > +			compatible = "shared-dma-pool";
> > > > +			reg = <0x43000000 0x01000000>;
> > > > +			no-map;
> > > > +		};
> > >
> > > I don't believe these reserved memory ranges are correct for
> audio_reserved and dmu_reserved.
> > >
> > > For example my vid_firmware-stih407.elf is linked at 0x41c00000 base
> > > address and my audio_firmware-bd-stih407.elf is linked at 0x40c00000.
> > >
> > > So with all the st231 rproc nodes enabled I guess it would still
> > > work. But currently I think st231_gp0 is reserving the memory region
> > > for st231_audio, and st231-gp1 is reserving the memory region for
> st231_dmu.
> >
> > These addresses are taken from internally tested code.
> 
> Yes I did check the internal kernel, it would appear to be wrong there as well.
> One of the joys of mailing list code review I guess :-)
> 
> > I don't have
> > access to the LMI layout documentation (if it even exists) so can't
> > check for myself.
> 
> >  Isn't this just DDR anyway?
> 
> Yes it is DDR
> 
> > So in theory we can
> > configure each devices' slice where ever we feel is appropriate?
> 
> Nope. The st231 audio and video firmwares are provided by ST as binary
> blobs and aren't AFAIK compiled as position independent code. So the
> reserved-memory region needs to match where the firmware has been
> linked to run from.
> 
> > How
> > is memory allocated to the DMU and Audio drivers?  Do you have scripts
> > which link the aforementioned binaries?
> 
> I don't have any scripts, firmware source code or even a st200 toolset.
> 
> >
> > If you think there is an issue, I suggest the best thing to do is ping
> > Ludovic, since he is the author of the original code.
> 
> Ok I will ping Ludovic and point him at this thread.
> 
> I think maybe the internal kernel rproc driver was only used to reserve
> memory, manage clocks, and co-processor reset / power lines, and multicom
> actually loaded the firmware elf file.
> 
> The reason for coming to that conclusion is that if rproc driver was loading the
> firmware I can't see how you would end up with a correctly booted co-
> processor with a reserved-memory node which doesn't match up with
> where the firmware is linked to run from.
> 
> Did you manage to boot audio or video co-pro successfully with the dt nodes
> as they currently are in this patch?
> 
> regards,
> 
> Peter.
> 
> _______________________________________________
> Kernel mailing list
> Kernel at stlinux.com
> http://www.stlinux.com/mailman/listinfo/kernel
