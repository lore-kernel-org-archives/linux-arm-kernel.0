From: horms@verge.net.au (Simon Horman)
Date: Wed, 25 Nov 2015 10:50:51 +0900
Subject: [PATCH v5 0/4] ARM: shmobile: r8a7740/sh73a0 DT Cache Handling
In-Reply-To: <1448286962-16897-1-git-send-email-geert+renesas@glider.be>
References: <1448286962-16897-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20151125015048.GN20596@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 02:55:58PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series add minimal L1 and L2 cache descriptions to DT for
> r8a7740 and sh73a0, and migrates the shmobile DT-based generic r8a7740
> platform from calling l2x0_of_init() to the generic l2c OF
> initialization.
> 
> Note that the conversion to the generic l2c OF initialization is not
> done yet for sh73a0, as this initializes the L2 cache earlier, breaking
> the (fragile) sh73a0 secondary CPU bringup code.
> 
> Also note that this conversion should be done on r8a7778, and r8a7779,
> too.

Based on your work I have prepared a DT patch for the r8a7779.
I don't think that a C patch is necessary, please correct me if I am wrong.

Regarding the r8a7778: My reading of the documentation is that although a
pl310 L2 cache controller is present it is not available for use as there
is no L2 cache memory present. For this reason I do not think any patches
are required for the r8a7798.

> Changes compared to v4 ("[PATCH v4 0/6] ARM: shmobile: r8a7740/sh73a0 DT
> Cache Handling",
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/340636.html):
>   - Drop optional cache-{size,sets,{block,line}-size} properties, as
>     this information is auto-detected (I verified this for both L1 and
>     L2 cache properties),
>   - Merge the L1 patches into the L2 patches, as the only part left from
>     the L1 patches was adding the links from CPU to L2 cache nodes.
> 
> Changes compared to v3 ("[PATCH v3 0/6] ARM: l2c / shmobile: r8a7740 :
> Shared Override",
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/340636.html):
>   - "l2c: Add support for the "arm,shared-override" property" was split
>     off into an independent patch, and is now queued for v4.3 in
>     arm/for-next,
>   - Dropped armadillo legacy migration, as it no longer exists,
>   - Added sh73a0 L1 and L2 DT cache description.
> 
> Changes compared to v2 ("[PATCH v2 0/5] ARM: shmobile: r8a7740/armadillo:
> Migrate to generic l2c OF",
> http://www.spinics.net/lists/devicetree/msg68176.html):
>   - Add DT support for Shared Override,
>   - Setting Shared Override is done only if CMA is not available (as
>     Russell claims it's not needed if CMA is available),
>   - Use 0/~0 in machine_desc.l2c_aux_{val,mask}, as DT now supports
>     "arm,shared-override".
> 
> Changes compared to v1:
>   - Fix interrupt reference in DT,
>   - Describe L2 better in DT,
>   - Keep only {,~}L2C_AUX_CTRL_SHARED_OVERRIDE in
>     machine_desc.l2c_aux_{val,mask}, as there's no DT property for
>     this.
>   - Add L1 cache to DT.
> 
> Dependencies:
>   - This series applies to renesas-devel-20151123-v4.4-rc2,
>   - Patch 3 depends on patch 1,
>   - Patch 4 depends on patch 3.
> 
> Given C code changesets depending on DT changesets in the same branch
> are frowned upon, you may want to postpone patches 3 and 4 to v4.6.
> Of course I'll sleep better if you just apply all 4 of them now ;-)

I have queued up the DT changes for v4.5.
And tentatively queued up the C changes for v4.6.

> I've been running this on r8a7740/armadillo and sh73a0/kzm9g for more
> than a year.
> 
> Thanks for applying!
> 
> Geert Uytterhoeven (4):
>   ARM: shmobile: r8a7740 dtsi: Add L2 cache-controller node
>   ARM: shmobile: sh73a0 dtsi: Add L2 cache-controller node
>   ARM: shmobile: r8a7740: Migrate to generic l2c OF initialization
>   ARM: shmobile: r8a7740: Remove mapping of L2 cache controller
>     registers
> 
>  arch/arm/boot/dts/r8a7740.dtsi         | 13 +++++++++++++
>  arch/arm/boot/dts/sh73a0.dtsi          | 14 ++++++++++++++
>  arch/arm/mach-shmobile/setup-r8a7740.c | 18 ++----------------
>  3 files changed, 29 insertions(+), 16 deletions(-)
> 
> -- 
> 1.9.1
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 
