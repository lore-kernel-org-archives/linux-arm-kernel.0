From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 20 Feb 2013 13:33:48 +0530
Subject: [PATCH 0/4] dw_dmac: introduce generic DMA binding for DT
In-Reply-To: <1360952512-971558-1-git-send-email-arnd@arndb.de>
References: <1360952512-971558-1-git-send-email-arnd@arndb.de>
Message-ID: <20130220080348.GF23302@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 15, 2013 at 07:21:48PM +0100, Arnd Bergmann wrote:
> Hi Vinod,
> 
> As Andy pointed out today, we don't have a good solution for the
> dw_dmac DT binding in linux-next yet. I have posted my series
> once before and then got distracted after getting feedback from
> Viresh, Andy and Russell. I have now updated my earlier patch
> based on the feedback and rebased on your tree without any
> of the arm-soc patches mixed in.
> 
> Unfortunately the patches have never been tested on real hardware 
> so I don't think it's a good idea to use them in v3.9 on the
> spear platform. However, your dma-slave tree still contains Viresh's
> earlier patches, causing a few problems:
> 
> * With those patches, the spear3xx platform currently does not build.
>   (this one would be easy to fix though)
> * There is a conflict between those patches and my spear multiplatform
>   series, which I have not yet queued up for 3.9 because of this,
>   since that would have meant that Stephen Rothwell would have to
>   discard either the arm-soc tree or the dma-slave tree from linux-next.
> * I really don't want the broken binding to appear in 3.9.
> 
> I believe the best way out at this point is this series, which first
> first reverts the patch f9965aa2 "ARM: SPEAr13xx: Pass DW DMAC
> platform data from DT" from your tree and then adds my update.
> 
> This will give us the right DT binding for dw-dmac but no in-tree
> users, which means that nothing should break if I get it slightly
> wrong. Please apply the first two patches from these set, and
> optionally the two patches that based on this convert the pl011
> uart and pl022 spi controller drivers.
Arnd,

Since there is still churn, would it make sense if I just revert the SPEAr13xx
patch (your first patch) and send a pull request to Linus.
Since there are no users and not much testing has been done, I think we can push
these to 3.10 via arm-soc/slave-dma tree.

Gives more testing and usage will go along as well.
Since merge window is open, I would like my pull to go soonish and not churn the
tree much.

--
~Vinod
> 
> I can then decide with Olof whether or not to take the spear multiplatform
> changes that no longer conflict with the dma slave tree as a "late"
> branch into 3.9 or wait until 3.10, but that is something you don't
> need to worry about then. Also the conversion of spear to use
> the new binding (patch 5 of my original series) can go through the 
> arm-soc tree for 3.10 after the ST folks have tested that it works.
> 
> 	Arnd
> 
> Arnd Bergmann (4):
>   Revert "ARM: SPEAr13xx: Pass DW DMAC platform data from DT"
>   dmaengine: dw_dmac: move to generic DMA binding
>   spi: pl022: use generic DMA slave configuration if possible
>   serial: pl011: use generic DMA slave configuration if possible
> 
>  .../devicetree/bindings/arm/primecell.txt          |  19 ++-
>  Documentation/devicetree/bindings/dma/snps-dma.txt |  70 ++++++-----
>  Documentation/devicetree/bindings/serial/pl011.txt |  17 +++
>  .../devicetree/bindings/spi/spi_pl022.txt          |  36 ++++++
>  arch/arm/boot/dts/spear1340.dtsi                   |  19 ---
>  arch/arm/boot/dts/spear13xx.dtsi                   |  38 ------
>  arch/arm/mach-spear13xx/include/mach/spear.h       |   2 +
>  arch/arm/mach-spear13xx/spear1310.c                |   5 +-
>  arch/arm/mach-spear13xx/spear1340.c                |  33 +++--
>  arch/arm/mach-spear13xx/spear13xx.c                |  55 ++++++++-
>  drivers/dma/dw_dmac.c                              | 137 ++++++++++-----------
>  drivers/dma/dw_dmac_regs.h                         |   8 +-
>  drivers/spi/spi-pl022.c                            |  43 ++++++-
>  drivers/tty/serial/amba-pl011.c                    |  62 ++++++----
>  include/linux/dw_dmac.h                            |   5 -
>  15 files changed, 333 insertions(+), 216 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/pl011.txt
> 
> -- 
> 1.8.1.2
> 
