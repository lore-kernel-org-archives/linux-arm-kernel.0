From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 25 Apr 2014 10:24:37 +0100
Subject: arm64: default dma_ops is set to coherent_dma_ops results into
 DMA FAILURE
In-Reply-To: <CAPw-ZTmkQv0nhn94yo30P8qpB-i0YagbWizgnOMx9N-5rWVCaQ@mail.gmail.com>
References: <CAPw-ZTmkQv0nhn94yo30P8qpB-i0YagbWizgnOMx9N-5rWVCaQ@mail.gmail.com>
Message-ID: <20140425092437.GE13648@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 25, 2014 at 06:43:45AM +0100, Loc Ho wrote:
> > > This is regarding the default dma_ops that we populate for arm64.
> > >
> > > PROBLEM:
> > > Currently in arch/arm64/mm/dma-mapping.c we set dma_ops =
> > > &coherent_swiotlb_dma_ops.
> > >
> > > The problem with this is, lets say that there is a dma device which
> > > has not populated its dev->archdata.dma_ops, then this dma device will
> > > get the coherent dma_ops in which we dont do any cache maintainance.
> > >
> > > So, if the dma driver do kmalloc, make some changes to the buffer and
> > > after dma_map_single gives it to the dma for the transfer, due to no
> > > cache maintenance performed, result will be DMA transfer failed.
> > >
> > >
> > >
> > > Earlier noncoherent ops code was not present at all for arm64, so may
> > > be we were setting default ops to coherent ops. But now that we have
> > > noncoherent ops in place shall we make the default dma_ops to
> > > noncoherent (as what arm also does) ?
> >
> > The problem with changing the default assumption to non-coherent is that
> > existing coherent platforms that rely on the coherent DMA ops being selected
> > without any additional DT properties (e.g. dma-coherent) will break with
> > this change.
> >
> > This puts us into a nasty situation where we have the opposite policy from
> > arch/arm/ regarding default DMA ops, rendering device-trees potentially
> > incompatible between the two architectures.
> >
> > I'd be inclined to align the two, but it will break any users relying on the
> > current behaviour (I believe this includes Applied with their X-gene SoC).
> 
> APM X-Gene SoC SMP system is fully coherent. It is preferred no cache
> maintenance operations as it is an over head. Currently, only the SATA
> driver is in 3.15-rc2 that is DMA master. If it is switched to
> non-coherent, this just adds cache maintenance over head which doesn't
> affect the system besides flushing over head.

The intention is not to make performance worse for this device but
rather add the following to the DT file:

diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index 93f4b2dd9248..f8c40a66e65d 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -307,6 +307,7 @@
 			      <0x0 0x1f21e000 0x0 0x1000>,
 			      <0x0 0x1f217000 0x0 0x1000>;
 			interrupts = <0x0 0x86 0x4>;
+			dma-coherent;
 			status = "disabled";
 			clocks = <&sata01clk 0>;
 			phys = <&phy1 0>;
@@ -321,6 +322,7 @@
 			      <0x0 0x1f22e000 0x0 0x1000>,
 			      <0x0 0x1f227000 0x0 0x1000>;
 			interrupts = <0x0 0x87 0x4>;
+			dma-coherent;
 			status = "ok";
 			clocks = <&sata23clk 0>;
 			phys = <&phy2 0>;
@@ -334,6 +336,7 @@
 			      <0x0 0x1f23d000 0x0 0x1000>,
 			      <0x0 0x1f23e000 0x0 0x1000>;
 			interrupts = <0x0 0x88 0x4>;
+			dma-coherent;
 			status = "ok";
 			clocks = <&sata45clk 0>;
 			phys = <&phy3 0>;

Since we don't have any stable release with your driver yet, it makes
sense to make such change as soon as possible.

-- 
Catalin
