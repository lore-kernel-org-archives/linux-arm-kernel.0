From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 29 Oct 2014 10:33:54 -0200
Subject: [PATCH] audio: sai: Add Power Management support
In-Reply-To: <1414552896-20797-1-git-send-email-b18965@freescale.com>
References: <1414552896-20797-1-git-send-email-b18965@freescale.com>
Message-ID: <CAOMZO5Ah4H1WDvFOBMhw7RS7XwSNSEet3u_emELFZTGD7rUzyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alison,

Please always add the driver maintainers (Xiubo Li and Nicolin Chen).

On Wed, Oct 29, 2014 at 1:21 AM, Alison Wang <b18965@freescale.com> wrote:

> +#ifdef CONFIG_PM_SLEEP
> +static int fsl_sai_suspend(struct device *dev)
> +{
> +       struct fsl_sai *sai = dev_get_drvdata(dev);
> +
> +       regcache_cache_only(sai->regmap, true);
> +       regcache_mark_dirty(sai->regmap);
> +
> +       return 0;
> +}
> +
> +static int fsl_sai_resume(struct device *dev)
> +{
> +       struct fsl_sai *sai = dev_get_drvdata(dev);
> +
> +       /* Restore all registers */
> +       regcache_cache_only(sai->regmap, false);
> +       regcache_sync(sai->regmap);
> +
> +       return 0;
> +};
> +#endif /* CONFIG_PM_SLEEP */
> +
> +static const struct dev_pm_ops fsl_sai_pm = {
> +       SET_SYSTEM_SLEEP_PM_OPS(fsl_sai_suspend, fsl_sai_resume)

This could be simplified to:
static SIMPLE_DEV_PM_OPS(fsl_sai_pm, fsl_sai_suspend, fsl_sai_resume);

I am also curious as to how you tested it, as I noticed that
suspend/resume is broken on 3.18-rc for mx6sx.

Are you able to do suspend/resume on 3.18-rc on a mx6sx sdb board?
