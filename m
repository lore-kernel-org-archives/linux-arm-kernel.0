From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 26 Sep 2013 09:48:01 -0300
Subject: [PATCH 2/3] ARM: mxs: crypto: Add Freescale MXS DCP driver
In-Reply-To: <1380194306-5243-2-git-send-email-marex@denx.de>
References: <1380194306-5243-1-git-send-email-marex@denx.de>
 <1380194306-5243-2-git-send-email-marex@denx.de>
Message-ID: <CAOMZO5A4rH_id25ROU_CdiOd79MhtU9J3jtFVyqeeD0R+=EuTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 8:18 AM, Marek Vasut <marex@denx.de> wrote:

> +config CRYPTO_DEV_MXS_DCP
> +       tristate "Support for Freescale MXS DCP"
> +       depends on ARCH_MXS
> +       select CRYPTO_SHA1
> +       select CRYPTO_SHA256
> +       select CRYPTO_CBC
> +       select CRYPTO_ECB
> +       select CRYPTO_AES
> +       select CRYPTO_BLKCIPHER
> +       select CRYPTO_ALGAPI
> +       help
> +         The Freescale i.MX23/i.MX28 has SHA1/SHA256 and AES128 CBC/ECB
> +         co-processor on the die.
> +
> +         To compile this driver as a module, choose M here: the module
> +         will be called atmel-sha.

Actually it will be called 'mxs-dcp'.

> + * There can even be only one instance of the MXS DCP due to the
> + * design of Linux Crypto API.

Is this true? Usually we don't want to create a global struct.

> +
> +/* AES 128 ECB and AES 128 CBC */
> +static struct crypto_alg dcp_aes_algs[] = {
> +       [0] = {

No need for explicitely add this [0]

> +               .cra_name               = "ecb(aes)",
> +               .cra_driver_name        = "ecb-aes-dcp",
> +               .cra_priority           = 400,
> +               .cra_alignmask          = 15,
> +               .cra_flags              = CRYPTO_ALG_TYPE_ABLKCIPHER |
> +                                         CRYPTO_ALG_ASYNC |
> +                                         CRYPTO_ALG_NEED_FALLBACK,
> +               .cra_init               = mxs_dcp_aes_fallback_init,
> +               .cra_exit               = mxs_dcp_aes_fallback_exit,
> +               .cra_blocksize          = AES_BLOCK_SIZE,
> +               .cra_ctxsize            = sizeof(struct dcp_async_ctx),
> +               .cra_type               = &crypto_ablkcipher_type,
> +               .cra_module             = THIS_MODULE,
> +               .cra_u  = {
> +                       .ablkcipher = {
> +                               .min_keysize    = AES_MIN_KEY_SIZE,
> +                               .max_keysize    = AES_MAX_KEY_SIZE,
> +                               .setkey         = mxs_dcp_aes_setkey,
> +                               .encrypt        = mxs_dcp_aes_ecb_encrypt,
> +                               .decrypt        = mxs_dcp_aes_ecb_decrypt
> +                       }
> +               }
> +       },
> +       [1] = {

Same here.

> +static int mxs_dcp_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct dcp *sdcp = NULL;
> +       int i, ret;
> +
> +       struct resource *iores;
> +       int dcp_vmi_irq, dcp_irq;
> +
> +       mutex_lock(&global_mutex);
> +       if (global_sdcp) {
> +               dev_err(dev, "Only one DCP instance allowed!\n");
> +               ret = -ENODEV;
> +               goto err_mutex;
> +       }
> +
> +       iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       dcp_vmi_irq = platform_get_irq(pdev, 0);
> +       dcp_irq = platform_get_irq(pdev, 1);
> +       if (!iores || dcp_vmi_irq < 0 || dcp_irq < 0) {

No need to check for !iores here.

You use it inside devm_ioremap_resource, which already does this checking.


> +       /*
> +        * We do not enable context switching. Give the context buffer a
> +        * pointer to an illegal address so if context switching is
> +        * inadvertantly enabled, the DCP will return an error instead of
> +        * trashing good memory. The DCP DMA cannot access ROM, so any ROM
> +        * address will do.
> +        */
> +       writel(0xffff0000, sdcp->base + MXS_DCP_CONTEXT);

Can you use a define instead of this hardcoded number?

> +static int mxs_dcp_remove(struct platform_device *pdev)
> +{
> +       struct dcp *sdcp;
> +       int i;
> +
> +       sdcp = platform_get_drvdata(pdev);
> +
> +       kthread_stop(sdcp->thread[DCP_CHAN_HASH_SHA]);
> +       kthread_stop(sdcp->thread[DCP_CHAN_CRYPTO]);
> +
> +       platform_set_drvdata(pdev, NULL);
> +
> +       dma_free_coherent(sdcp->dev, sizeof(struct dcp_coherent_block),
> +                         sdcp->coh, sdcp->coh_phys);
> +
> +       if (sdcp->caps & MXS_DCP_CAPABILITY1_SHA256)
> +               crypto_unregister_ahash(&dcp_sha256_alg);
> +
> +       if (sdcp->caps & MXS_DCP_CAPABILITY1_SHA1)
> +               crypto_unregister_ahash(&dcp_sha1_alg);
> +
> +       if (sdcp->caps & MXS_DCP_CAPABILITY1_AES128) {
> +               for (i = ARRAY_SIZE(dcp_aes_algs); i >= 0; i--)
> +                       crypto_unregister_alg(&dcp_aes_algs[i]);
> +       }
> +
> +       mutex_lock(&global_mutex);
> +       global_sdcp = NULL;
> +       mutex_unlock(&global_mutex);


The order of the resources removal does not look correct here.

It should match the order of the error path in probe.

> +
> +       return 0;
> +}
> +
> +static const struct of_device_id mxs_dcp_dt_ids[] = {
> +       {.compatible = "fsl,mxs-dcp", .data = NULL,},

In the other mxs/imx drivers we use:

.compatible = "fsl,<soc>-dcp"

You also need to provide a devicetree documentation for this binding.

> +       { /* sentinel */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, mxs_dcp_dt_ids);
> +
> +static struct platform_driver mxs_dcp_driver = {
> +       .probe  = mxs_dcp_probe,
> +       .remove = mxs_dcp_remove,
> +       .driver = {
> +               .name           = "mxs-dcp",
> +               .owner          = THIS_MODULE,
> +               .of_match_table = mxs_dcp_dt_ids,
> +       },
> +};
> +
> +module_platform_driver(mxs_dcp_driver);
> +
> +MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
> +MODULE_DESCRIPTION("Freescale MXS DCP Driver");
> +MODULE_LICENSE("GPL");


Could also add MODULE_ALIAS.
