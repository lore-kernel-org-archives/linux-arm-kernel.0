From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 6 Feb 2015 19:17:58 +0000
Subject: [PATCHv6 4/5] edac: altera: Add Altera L2 Cache and OCRAM EDAC
 Support
In-Reply-To: <1420772036-3112-5-git-send-email-tthayer@opensource.altera.com>
References: <1420772036-3112-1-git-send-email-tthayer@opensource.altera.com>
 <1420772036-3112-5-git-send-email-tthayer@opensource.altera.com>
Message-ID: <20150206191758.GE10324@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 02:53:55AM +0000, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> Adding L2 Cache and On-Chip RAM EDAC support for the
> Altera SoCs using the EDAC device  model. The SDRAM
> controller is using the Memory Controller model.
> 
> Each type of ECC is individually configurable.
> 
> The SDRAM ECC is a separate Kconfig option because:
> 1) the SDRAM preparation can take almost 2 seconds on boot and some
> customers need a faster boot time.
> 2) the SDRAM has an ECC initialization dependency on the preloader
> which is outside the kernel. It is desirable to be able to turn the
> SDRAM on & off separately.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
> v2: Fix L2 dependency comments.
> 
> v3: Move OCRAM and L2 cache EDAC functions into altera_edac.c
>     instead of separate files.
> 
> v4: Change mask defines to use BIT().
>     Fix comment style to agree with kernel coding style.
>     Better printk description for read != write in trigger.
>     Remove SysFS debugging message.
>     Better dci->mod_name
>     Move gen_pool pointer assignment to end of function.
>     Invert logic to reduce indent in ocram depenency check.
>     Change from dev_err() to edac_printk()
>     Replace magic numbers with defines & comments.
>     Improve error injection test.
>     Change Makefile intermediary name to altr (from alt)
> 
> v5: No change.
> 
> v6: Convert to nested EDAC in device tree. Force L2 cache
>     on for L2Cache ECC & remove L2 cache syscon for checking
>     enable bit. Update year in header.
> ---
>  drivers/edac/Kconfig       |   16 ++
>  drivers/edac/Makefile      |    5 +-
>  drivers/edac/altera_edac.c |  506 +++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 524 insertions(+), 3 deletions(-)

[...]

> +/************************* EDAC Parent Probe *************************/
> +
> +static const struct of_device_id altr_edac_device_of_match[];

Huh? What's this for?

> +static const struct of_device_id altr_edac_of_match[] = {
> +       { .compatible = "altr,edac" },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, altr_edac_of_match);

I know it may seem like a minor thing, but the documentation really
should have come in an earlier patch. It's painful to review a patch
series when you have to randomly just to the end of hte series to see
the documentation.

The name is _very_ generic here. Do we not have a more specific name for
the EDAC block in your SoC?

Is there actually a specific EDAC device, or are you just grouping some
portions of HW blocks into an EDAC device to match what the Linux EDAC
framework wants?

[...]

> +ssize_t altr_edac_device_trig(struct edac_device_ctl_info *edac_dci,
> +                             const char *buffer, size_t count)
> +{
> +       u32 *ptemp, i, error_mask;
> +       int result = 0;
> +       unsigned long flags;
> +       struct altr_edac_device_dev *drvdata = edac_dci->pvt_info;
> +       const struct edac_device_prv_data *priv = drvdata->data;
> +       void *generic_ptr = edac_dci->dev;

Huh? What's hidden behind this "generic_ptr"?

> +
> +       if (!priv->alloc_mem)
> +               return -ENOMEM;
> +
> +       /*
> +        * Note that generic_ptr is initialized to the device * but in
> +        * some alloc_functions, this is overridden and returns data.
> +        */
> +       ptemp = priv->alloc_mem(priv->trig_alloc_sz, &generic_ptr);
> +       if (!ptemp) {
> +               edac_printk(KERN_ERR, EDAC_DEVICE,
> +                           "Inject: Buffer Allocation error\n");
> +               return -ENOMEM;
> +       }
> +
> +       if (buffer[0] == ALTR_UE_TRIGGER_CHAR)
> +               error_mask = priv->ue_set_mask;
> +       else
> +               error_mask = priv->ce_set_mask;
> +
> +       edac_printk(KERN_ALERT, EDAC_DEVICE,
> +                   "Trigger Error Mask (0x%X)\n", error_mask);
> +
> +       local_irq_save(flags);
> +       /* write ECC corrupted data out. */
> +       for (i = 0; i < (priv->trig_alloc_sz / sizeof(*ptemp)); i++) {
> +               /* Read data so we're in the correct state */
> +               rmb();
> +               if (ACCESS_ONCE(ptemp[i]))
> +                       result = -1;

Perhaps s/result/err/? You could even have an err_count, which would
give you slightly more useful output.

> +               /* Toggle Error bit (it is latched), leave ECC enabled */
> +               writel(error_mask, drvdata->base);
> +               writel(priv->ecc_enable_mask, drvdata->base);
> +               ptemp[i] = i;
> +       }
> +       /* Ensure it has been written out */
> +       wmb();
> +       local_irq_restore(flags);
> +
> +       if (result)
> +               edac_printk(KERN_ERR, EDAC_DEVICE, "Mem Not Cleared\n");
> +
> +       /* Read out written data. ECC error caused here */
> +       for (i = 0; i < ALTR_TRIGGER_READ_WRD_CNT; i++)
> +               if (ACCESS_ONCE(ptemp[i]) != i)
> +                       edac_printk(KERN_ERR, EDAC_DEVICE,
> +                                   "Read doesn't match written data\n");
> +
> +       if (priv->free_mem)
> +               priv->free_mem(ptemp, priv->trig_alloc_sz, generic_ptr);
> +
> +       return count;
> +}

[...]

> +static void *ocram_alloc_mem(size_t size, void **other)
> +{
> +       struct device_node *np;
> +       struct gen_pool *gp;
> +       void *sram_addr;
> +
> +       np = of_find_compatible_node(NULL, NULL, "altr,ocram-edac");
> +       if (!np)
> +               return NULL;
> +
> +       gp = of_get_named_gen_pool(np, "iram", 0);
> +       if (!gp) {
> +               of_node_put(np);
> +               return NULL;
> +       }
> +       of_node_put(np);
> +
> +       sram_addr = (void *)gen_pool_alloc(gp, size / sizeof(size_t));

I'm still very much confused by this sizeof(size_t) division, but
hopefully your response to my earlier query will answer that.

[...]

> +static void *l2_alloc_mem(size_t size, void **other)
> +{
> +       struct device *dev = *other;
> +       void *ptemp = devm_kzalloc(dev, size, GFP_KERNEL);
> +
> +       if (!ptemp)
> +               return NULL;
> +
> +       /* Make sure everything is written out */
> +       wmb();
> +
> +       /*
> +        * Clean all cache levels up to LoC (includes L2)
> +        * This ensures the corrupted data is written into
> +        * L2 cache for readback test (which causes ECC error).
> +        */
> +       flush_cache_all();

I'm a little confused by this comment (especially w.r.t. the L2 being
before the LoC). Are we attempting to flush everything _to_ the L2, or
beyond/out-of the L2? As far as I can see flush_cache_all will only
achieve the former, and not the latter, as it doesn't seem to perform
any outer cache operations.

Per the architecture, Set/Way maintenance of this form won't always act
as you expect (though I believe that for Cortex-A9 it does).

> +
> +       return ptemp;
> +}
> +
> +static void l2_free_mem(void *p, size_t size, void *other)
> +{
> +       struct device *dev = other;
> +
> +       if (dev && p)
> +               devm_kfree(dev, p);

Is this ever called in that case?

Thanks,
Mark.
