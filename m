From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 16 Dec 2015 01:01:01 -0800
Subject: [PATCH] ARM64: ZynqMP: DT: Fix GIC's 'reg' property
In-Reply-To: <56702B44.5080201@xilinx.com>
References: <1450110700-14152-1-git-send-email-soren.brinkmann@xilinx.com>
 <20151214164613.GH21356@leverpostej> <566EF5CC.4070000@arm.com>
 <20151215091450.GI3358@xsjsorenbubuntu>
 <56702B44.5080201@xilinx.com>
Message-ID: <20151216090101.GW3358@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-12-15 at 04:01PM +0100, Michal Simek wrote:
> Hi,
> 
> On 15.12.2015 10:14, S?ren Brinkmann wrote:
> > On Mon, 2015-12-14 at 05:01PM +0000, Marc Zyngier wrote:
> >> Mark,
> >>
> >> On 14/12/15 16:46, Mark Rutland wrote:
> >>> On Mon, Dec 14, 2015 at 08:31:40AM -0800, Soren Brinkmann wrote:
> >>>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> >>>> ---
> >>>>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 6 +++---
> >>>>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> >>>> index 857eda5c7217..b5d1facadf16 100644
> >>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> >>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> >>>> @@ -80,10 +80,10 @@
> >>>>  		gic: interrupt-controller at f9010000 {
> >>>>  			compatible = "arm,gic-400", "arm,cortex-a15-gic";
> >>>>  			#interrupt-cells = <3>;
> >>>> -			reg = <0x0 0xf9010000 0x10000>,
> >>>> -			      <0x0 0xf902f000 0x2000>,
> >>>> +			reg = <0x0 0xf9010000 0x1000>,
> >>>> +			      <0x0 0xf9020000 0x20000>,
> >>>>  			      <0x0 0xf9040000 0x20000>,
> >>>> -			      <0x0 0xf906f000 0x2000>;
> >>>> +			      <0x0 0xf9060000 0x20000>;
> >>>
> >>> I'm confused. These sizes don't look right for GIC-400. Is this a custom
> >>> GIC?
> >>
> >> Probably an implementation that obey the SBSA requirement of aliasing
> >> the first 4kB of the CPU interface on a 64kB page, and the second one on
> >> the following 64kB page. See the APM system for an example of such a
> >> thing. I'm more concerned about the GICH region (3rd one), which has no
> >> reason to be bigger than 4kB.
> > 
> > Xilinx didn't publish the memory map yet (at least I didn't see it in the
> > public docs), so, let me give some excerpts:
> > 
> > GICD:
> > GICD_CTLR 	0xF9010000 	32 	rw 	0x00000000 	Distributor Control Register
> > ...
> > GICD_CIDR3 	0xF9010FFC 	32 	ro 	0x000000B1 	Component ID3 Register
> > 
> > GICC:
> > GICC_CTLR 	0xF9020000 	32 	rw 	0x00000000 	CPU Interface Control Register
> > ...
> > GICC_DIR 	0xF9030000 	32 	wo 	x 	Deactivate Interrupt Register
> > 
> > GICH:
> > GICH_HCR 	0xF9040000 	32 	rw 	0x00000000 	Hypervisor Control Register
> > ...
> > GICH_LR3_Alias7 	0xF9050F0C 	32 	rw 	0x00000000 	List Register 3
> > 
> > GICV:
> > GICV_CTLR 	0xF9060000 	32 	rw 	0x00000000 	Virtual Machine Control Register
> > ...
> > GICV_DIR 	0xF9070000 	32 	wo 	x 	VM Deactivate Interrupt Register
> > 
> > 
> > Regarding the GICH area, it looks like it starts at 0xF9040000 and the
> > alias blocks to access the other processor interfaces start at
> > 0xF9050000.
> > 
> >>
> >>> Did this ever work wit hteh old offsets and sizes?
> >>
> >> It probably dies when trying to use EOImode==1.
> > 
> > Without knowing what parts we really exercise, yes, the system comes up
> > fine so far, but I recently found Linux boot hanging on QEMU and it
> > seemed to be related to time not progressing (fast enough).
> > I found a different DT using the values proposed here and that fixed the
> > hang for me.
> 
> We have discussed this here before with Rob
> https://lkml.org/lkml/2015/2/24/371
> 
> Not sure if there is any fix. It is probably just broken QEMU not DTS
> description in mainline.

Do I understand this correctly?: The GIC IP has more configurable
addresses than the DT binding/driver allow. Thus far people have worked
around this by specifying some funky address in DT relying on the IP
aliasing some addresses?

	Thanks,
	S?ren
