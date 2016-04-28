From: horms@verge.net.au (Simon Horman)
Date: Fri, 29 Apr 2016 09:43:45 +1000
Subject: [PATCH] arm64: dts: r8a7795: Increase the size of GIC-400 mapped
 registers
In-Reply-To: <5721A2A5.9010908@de.bosch.com>
References: <1461047395-6532-1-git-send-email-dirk.behme@de.bosch.com>
 <20160427233028.GA5155@verge.net.au>
 <5721A2A5.9010908@de.bosch.com>
Message-ID: <20160428234345.GD18128@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Cc Mark Zyngier, linux-arm-kernel]

Hi Dirk,

On Thu, Apr 28, 2016 at 07:41:57AM +0200, Dirk Behme wrote:
> Hi Simon,
> 
> On 28.04.2016 01:30, Simon Horman wrote:
> >Hi Dirk,
> >
> >I understand that there is an issue here but I'm not yet able
> >to convince myself that this is the correct solution.
> >
> >In revision r0p1 of the CoreLink GIC-400 Generic Interrupt Controller
> >Technical Reference Manual[1] I see in Section 3.2. "GIC-400 register map"
> >that the size of both the CPU interfaces and Virtual CPU interfaces are
> >0x2000 bytes. And assuming that the hardware follows the specification it
> >appears that DT is correctly describing the hardware.
> 
> 
> I think you are missing the details described by ARM in
> 
> http://xenbits.xen.org/gitweb/?p=xen.git;a=commit;h=21550029f709072aacf3b9
> 
> 
> Maybe Julien could help if you have some more doubts?

I guess I am confused.

I see that there is now handling of the case where the region size is
128Kbytes. But I'm still not seeing the bit which describes that the
GIC-400  has a region size of 128Kbytes. Perhaps the later is somehow
implied by the former. Or perhaps I need to check with the hw team.

> Best regards
> 
> Dirk
> 
> 
> >[1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0471b/index.html
> >
> >On Tue, Apr 19, 2016 at 08:29:55AM +0200, Dirk Behme wrote:
> >>From: Pooya Keshavarzi <Pooya.Keshavarzi@de.bosch.com>
> >>
> >>There are some requirements about the GIC-400 memory layout and its
> >>mapping if using 64k aligned base addresses like on r8a7795.
> >>
> >>See e.g.
> >>
> >>http://xenbits.xen.org/gitweb/?p=xen.git;a=commit;h=21550029f709072aacf3b9
> >>
> >>Map the whole memory range instead of only 0x2000. This will fix
> >>the issue that some hypervisors, e.g. Xen, fail to handle the
> >>interrupts correctly.
> >>
> >>Signed-off-by: Pooya Keshavarzi <Pooya.Keshavarzi@de.bosch.com>
> >>Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> >>---
> >>Note: This patch is against renesas-drivers-2016-04-12-v4.6-rc3
> >>
> >>  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >>diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> >>index 8be9424..d880fd4 100644
> >>--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> >>+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> >>@@ -160,9 +160,9 @@
> >>  			#address-cells = <0>;
> >>  			interrupt-controller;
> >>  			reg = <0x0 0xf1010000 0 0x1000>,
> >>-			      <0x0 0xf1020000 0 0x2000>,
> >>+			      <0x0 0xf1020000 0 0x20000>,
> >>  			      <0x0 0xf1040000 0 0x20000>,
> >>-			      <0x0 0xf1060000 0 0x2000>;
> >>+			      <0x0 0xf1060000 0 0x20000>;
> >>  			interrupts = <GIC_PPI 9
> >>  					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> >>  		};
> >>--
> >>2.8.0
> >>
> >
