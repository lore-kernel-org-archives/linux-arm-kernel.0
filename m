From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Feb 2017 18:56:04 +0100
Subject: [PATCH 5/9] dmaengine: sun6i: support V3s SoC variant
In-Reply-To: <1426971488192481@web6g.yandex.ru>
References: <20170225123029.55939-1-icenowy@aosc.xyz>
 <20170225123029.55939-5-icenowy@aosc.xyz>
 <20170227075021.e7e43o54s23jzfto@lukather>
 <1426971488192481@web6g.yandex.ru>
Message-ID: <20170228175604.kdlmjjcncfljnbfp@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2017 at 06:48:01PM +0800, Icenowy Zheng wrote:
> 
> 
> 27.02.2017, 15:50, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> > On Sat, Feb 25, 2017 at 08:30:25PM +0800, Icenowy Zheng wrote:
> >> ?Allwinner V3s has a DMA engine similar to the ones from A31, but with
> >> ?fewer channels and DRQs.
> >>
> >> ?Add support for it.
> >>
> >> ?As it also needs the special gate bit, make the gate bit generic.
> >
> > That should be part of a separate patch.
> 
> OK.
> 
> >
> >> ?According to BSP source code, SUN8IW6 (A83T) also needs the bit, so it
> >> ?have also been specified gate_needed property.
> >>
> >> ?Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> >> ?---
> >> ??Documentation/devicetree/bindings/dma/sun6i-dma.txt | 1 +
> >> ??drivers/dma/sun6i-dma.c | 17 ++++++++++++++---
> >> ??2 files changed, 15 insertions(+), 3 deletions(-)
> >>
> >> ?diff --git a/Documentation/devicetree/bindings/dma/sun6i-dma.txt b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
> >> ?index 6b267045f522..98fbe1a5c6dd 100644
> >> ?--- a/Documentation/devicetree/bindings/dma/sun6i-dma.txt
> >> ?+++ b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
> >> ?@@ -9,6 +9,7 @@ Required properties:
> >> ????????????????????"allwinner,sun8i-a23-dma"
> >> ????????????????????"allwinner,sun8i-a83t-dma"
> >> ????????????????????"allwinner,sun8i-h3-dma"
> >> ?+ "allwinner,sun8i-v3s-dma"
> >> ??- reg: Should contain the registers base address and length
> >> ??- interrupts: Should contain a reference to the interrupt used by this device
> >> ??- clocks: Should contain a reference to the parent AHB clock
> >> ?diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> >> ?index a2358780ab2c..1f38424c1b14 100644
> >> ?--- a/drivers/dma/sun6i-dma.c
> >> ?+++ b/drivers/dma/sun6i-dma.c
> >> ?@@ -101,6 +101,7 @@ struct sun6i_dma_config {
> >> ??????????u32 nr_max_channels;
> >> ??????????u32 nr_max_requests;
> >> ??????????u32 nr_max_vchans;
> >> ?+ bool gate_needed;
> >> ??};
> >>
> >> ??/*
> >> ?@@ -1009,12 +1010,14 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
> >> ??????????.nr_max_channels = 8,
> >> ??????????.nr_max_requests = 24,
> >> ??????????.nr_max_vchans = 37,
> >> ?+ .gate_needed = true,
> >> ??};
> >>
> >> ??static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
> >> ??????????.nr_max_channels = 8,
> >> ??????????.nr_max_requests = 28,
> >> ??????????.nr_max_vchans = 39,
> >> ?+ .gate_needed = true,
> >> ??};
> >>
> >> ??/*
> >> ?@@ -1028,11 +1031,19 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
> >> ??????????.nr_max_vchans = 34,
> >> ??};
> >>
> >> ?+static struct sun6i_dma_config sun8i_v3s_dma_cfg = {
> >> ?+ .nr_max_channels = 8,
> >> ?+ .nr_max_requests = 23,
> >> ?+ .nr_max_vchans = 24,
> >
> > This one is suspicious. There's just a single endpoint that can be
> > used in both directions?
> 
> nr_max_vchans is the endpoint number. nr_max_requests is the
> maximum DRQ number, for V3s, according to the datasheet, it's
> 23: SPI0_{R,T}X.

There's not a lot of endpoints indeed, but you need 28 vchans (2 *
14).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170228/0a0b8dc9/attachment.sig>
