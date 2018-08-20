From: manu@bidouilliste.com (Emmanuel Vadot)
Date: Mon, 20 Aug 2018 09:42:10 +0200
Subject: [PATCH v3 0/4] allwinner: a64: add SRAM controller / system
 control
In-Reply-To: <20180614153548.9644-1-wens@csie.org>
References: <20180614153548.9644-1-wens@csie.org>
Message-ID: <20180820094210.6d856029d51dad480782a783@bidouilliste.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


 Hello Chen-Yu,

On Thu, 14 Jun 2018 23:35:44 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> Hi,
> 
> This series is the remaining A64 syscon changes from the R40 DWMAC
> series. The series aligns how the A64 system control exports a regmap
> for the sun8i DWMAC driver to access with what we've done for the R40.
> 
> Originally the A64 used the generic syscon for this bit of hardware.
> But this block also contains mapping bits for the onboard SRAM, used
> by various peripherals, and other vendor specific bits we may use in
> the future. It is by no means generic. And we already have a device
> tree binding and driver for the SRAM part.
> 
> The first patch make the SRAM control device export a regmap, exposing
> a single EMAC control register, for the DWMAC driver to consume.
> 
> The second and third patches rename the A64 compatible string to read
> "system control", which is what the block is named in the user manual.
> 
> The last patch fixes up the device node, and also adds the lone mappable
> SRAM block, which is needed by the Display Engine.
> 
> Changes since v2:
> 
>   - changed the compatible string from "*-sram-controller" to
>     "*-system-control"
> 
> 
> ChenYu
> 
> Chen-Yu Tsai (2):
>   dt-bindings: sram: Rename A64 SRAM controller compatible
>   soc: sunxi: sram: Add updated compatible string for A64 system control
> 
> Icenowy Zheng (2):
>   soc: sunxi: export a regmap for EMAC clock reg on A64
>   arm64: dts: allwinner: a64: add SRAM controller device tree node
> 
>  .../devicetree/bindings/sram/sunxi-sram.txt   |  3 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 19 +++++-
>  drivers/soc/sunxi/sunxi_sram.c                | 61 ++++++++++++++++++-
>  3 files changed, 78 insertions(+), 5 deletions(-)
> 
> -- 
> 2.17.1

 I wish to have seen this serie before as it have some inconsistencies.

 In patch 2 you renamed allwinner,sun50i-a64-sram-controller to
allwinner,sun50i-a64-system-control but the former was never used in
the DTS, the compatible used was allwinner,sun50i-a64-system-controller.
 You also say that you've never seen use of it. How can you make that
claim ? There is a lot of downstream users of DTS now (FreeBSD, NetBSD,
OpenBSD and even RiscOS and Haiku iirc), it's not just Linux.
 Also this compatible is currently the one used in the u-boot dts,
which mean that users of the embedded DTB use or can use it (which is
the default for EFI users of U-Boot).

 Cheers,

-- 
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
