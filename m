From: balbi@ti.com (Felipe Balbi)
Date: Tue, 9 Dec 2014 16:30:14 -0600
Subject: [RFC/PATCH 0/7] arm: omap: move more HWMOD data to DT
In-Reply-To: <1418164072-19087-1-git-send-email-balbi@ti.com>
References: <1418164072-19087-1-git-send-email-balbi@ti.com>
Message-ID: <20141209223014.GE25857@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 09, 2014 at 04:27:45PM -0600, Felipe Balbi wrote:
> Hi,
> 
> here's a more complete series showing the out of debugfs interface.
> 
> So far only AM43xx has been converted and only those HWMODs which
> play well with DT and/or are not common with other OMAPs/AM33xx.
> 
> I plan to work on AM33xx tomorrow, but this RFC shows what we can
> achieve WRT HWMOD static data reduction.
> 
> As you can see, with AM43xx, data reduction is quite minimal, since
> it reuses so much from AM33xx, but well, had to start somewhere.
> 
> All patches were boot tested with AM437x SK on top of:
> 
> commit 1ca7c606de868d172afb4eb65e04e290dbdb51ff
> Author: Stephen Rothwell <sfr@canb.auug.org.au>
> Date:   Thu Dec 4 19:49:10 2014 +1100
> 
>     Add linux-next specific files for 20141204
>     
>     Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> cheers
> 
> Felipe Balbi (7):
>   arm: omap: hwmod: add debugfs interface
>   arm: omap: devicetree: add new properties for OMAP devices
>   arm: omap: hwmod: drop 'const' qualifier from omap_hwmod_class name
>   arm: omap: device: add support for generating sysconfig data from DT
>   arm: omap: hwmod: allow for registration of class-less hwmods
>   arm: boot: dts: am4372: add sysconfig data to all HWMODs
>   arm: omap: hwmod: 43xx: remove sysc and class data
> 
>  .../devicetree/bindings/arm/omap/omap.txt          |   7 +
>  arch/arm/boot/dts/am4372.dtsi                      | 251 +++++++++++++++++++
>  arch/arm/mach-omap2/Makefile                       |   2 +-
>  arch/arm/mach-omap2/omap_device.c                  | 117 +++++++++
>  arch/arm/mach-omap2/omap_hwmod.c                   |  30 ++-
>  arch/arm/mach-omap2/omap_hwmod.h                   |  11 +-
>  arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |  61 -----
>  arch/arm/mach-omap2/omap_hwmod_debugfs.c           | 269 +++++++++++++++++++++
>  8 files changed, 673 insertions(+), 75 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/omap_hwmod_debugfs.c

btw, after removing all class and sysconfig static definitions, we get:

$ git diff --stat
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  44 --
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |  70 --
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |  42 --
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c | 188 ------
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 370 +----------
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |  78 ---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         | 399 ------------
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |  37 --
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         | 713 ---------------------
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         | 469 --------------
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          | 488 +-------------
 .../mach-omap2/omap_hwmod_common_ipblock_data.c    |  30 +-
 12 files changed, 5 insertions(+), 2923 deletions(-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141209/44b5f62b/attachment.sig>
