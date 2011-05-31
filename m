From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 31 May 2011 22:39:48 +0530
Subject: [RFC PATCH v4] Consolidate SRAM support
In-Reply-To: <1306371777-20431-1-git-send-email-plagnioj@jcrosoft.com>
References: <20110512174546.GB8633@n2100.arm.linux.org.uk>
	<1306371777-20431-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D234457@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Christophe,

On Thu, May 26, 2011 at 06:32:57, Jean-Christophe PLAGNIOL-VILLARD wrote:
> From: Russell King - ARM Linux <linux@arm.linux.org.uk>
> 
> We have two SoCs using SRAM, both with their own allocation systems,
> and both with their own ways of copying functions into the SRAM.
> 
> Let's unify this before we have additional SoCs re-implementing this
> obviously common functionality themselves.
> 
> For this use the generic allocator and the newly introduce
> gen_pool_add_virt and gen_pool_virt_to_phys
> 
> Uio_pruss should probably take the SRAM pool pointer via
> platform data so that it doesn't have to include Davinci specific
> includes.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>

I tested this on DA850 using suspend-to-RAM and audio, it works
well!

>  arch/arm/Kconfig                                   |    2 +
>  arch/arm/mach-davinci/da850.c                      |    2 +-
>  arch/arm/mach-davinci/dm355.c                      |    2 +-
>  arch/arm/mach-davinci/dm365.c                      |    2 +-
>  arch/arm/mach-davinci/dm644x.c                     |    2 +-
>  arch/arm/mach-davinci/dm646x.c                     |    2 +-
>  arch/arm/mach-davinci/include/mach/common.h        |    2 +-
>  arch/arm/mach-davinci/include/mach/sram.h          |   13 +----
>  arch/arm/mach-davinci/pm.c                         |   21 +++----
>  arch/arm/mach-davinci/sram.c                       |   57 +++++--------------

>  arch/arm/plat-mxc/include/mach/iram.h              |   28 ++++++++--
>  .../plat-mxc/{include/mach/iram.h => iram_alloc.c} |   40 ++++++++------

I had trouble applying the plat-mxc stuff on v3.0-rc1.
Can you please check?

I also found some check patch errors. Feel free to merge
the attached patch.

With these, please add my:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar

----8<-------
diff --git a/arch/arm/plat-mxc/include/mach/iram.h b/arch/arm/plat-mxc/include/mach/iram.h
index 8279c47..aae5e35 100644
--- a/arch/arm/plat-mxc/include/mach/iram.h
+++ b/arch/arm/plat-mxc/include/mach/iram.h
@@ -31,7 +31,7 @@ static inline void *iram_alloc(size_t size, phys_addr_t *phys)
 
 	*phys = gen_pool_virt_to_phys(iram_pool, addr);
 
-	return (void*)addr;
+	return (void *) addr;
 }
 
 static inline void iram_free(void *addr, size_t size)
diff --git a/arch/arm/plat-omap/include/plat/sram.h b/arch/arm/plat-omap/include/plat/sram.h
index 52b9b5c..cc99397 100644
--- a/arch/arm/plat-omap/include/plat/sram.h
+++ b/arch/arm/plat-omap/include/plat/sram.h
@@ -27,7 +27,7 @@ extern struct gen_pool *omap_gen_pool;
 	size_t _sz = size;					\
 	void *_sram = gen_pool_alloc(omap_gen_pool, _sz);	\
 	_res = (_sram ? fncpy(_sram, &(funcp), _sz) : NULL);	\
-	if (!_res) 						\
+	if (!_res)						\
 		pr_err("Not enough space in SRAM\n");		\
 	_res;							\
 })
diff --git a/drivers/uio/uio_pruss.c b/drivers/uio/uio_pruss.c
index db486cc..444176e 100644
--- a/drivers/uio/uio_pruss.c
+++ b/drivers/uio/uio_pruss.c
@@ -153,7 +153,7 @@ static int __devinit pruss_probe(struct platform_device *dev)
 		goto out_free;
 	}
 
-	gdev->sram_vaddr = (void*)gen_pool_alloc(davinci_gen_pool, sram_pool_sz);
+	gdev->sram_vaddr = (void *)gen_pool_alloc(davinci_gen_pool, sram_pool_sz);
 	if (!gdev->sram_vaddr) {
 		dev_err(&dev->dev, "Could not allocate SRAM pool\n");
 		goto out_free;
diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index dd305a2..1c383ab 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -239,7 +239,7 @@ static int allocate_sram(struct snd_pcm_substream *substream, unsigned size,
 		return 0;
 
 	ppcm->period_bytes_max = size;
-	iram_virt = (void*)gen_pool_alloc(davinci_gen_pool, size);
+	iram_virt = (void *)gen_pool_alloc(davinci_gen_pool, size);
 	if (!iram_virt)
 		goto exit1;
 	iram_phys = gen_pool_virt_to_phys(davinci_gen_pool,
