From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 19 May 2015 14:21:01 +0200
Subject: [PATCH] memory: tegra: Expose supported rates via debugfs
In-Reply-To: <1431963330-25708-1-git-send-email-thierry.reding@gmail.com>
References: <1431963330-25708-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <CAAObsKCo7x4qMdPvBb-dNoN=j7Od-eMCxw9BNoSvDR5mUZXGtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 May 2015 at 17:35, Thierry Reding <thierry.reding@gmail.com> wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> In order to ease testing, expose the list of supported EMC frequencies
> via debugfs.

Looks good to me, but if this is for automated testing, why not just
read the timings from the DT? We would be covering more code that way.

Reviewed-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Regards,

Tomeu

> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/memory/tegra/tegra124-emc.c | 42 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
> index 8620355776fe..3dac7be39654 100644
> --- a/drivers/memory/tegra/tegra124-emc.c
> +++ b/drivers/memory/tegra/tegra124-emc.c
> @@ -1027,7 +1027,40 @@ static int emc_debug_rate_set(void *data, u64 rate)
>  DEFINE_SIMPLE_ATTRIBUTE(emc_debug_rate_fops, emc_debug_rate_get,
>                         emc_debug_rate_set, "%lld\n");
>
> -static void emc_debugfs_init(struct device *dev)
> +static int emc_debug_supported_rates_show(struct seq_file *s, void *data)
> +{
> +       struct tegra_emc *emc = s->private;
> +       const char *prefix = "";
> +       unsigned int i;
> +
> +       for (i = 0; i < emc->num_timings; i++) {
> +               struct emc_timing *timing = &emc->timings[i];
> +
> +               seq_printf(s, "%s%lu", prefix, timing->rate);
> +
> +               prefix = " ";
> +       }
> +
> +       seq_puts(s, "\n");
> +
> +       return 0;
> +}
> +
> +static int emc_debug_supported_rates_open(struct inode *inode,
> +                                         struct file *file)
> +{
> +       return single_open(file, emc_debug_supported_rates_show,
> +                          inode->i_private);
> +}
> +
> +static const struct file_operations emc_debug_supported_rates_fops = {
> +       .open = emc_debug_supported_rates_open,
> +       .read = seq_read,
> +       .llseek = seq_lseek,
> +       .release = single_release,
> +};
> +
> +static void emc_debugfs_init(struct device *dev, struct tegra_emc *emc)
>  {
>         struct dentry *root, *file;
>         struct clk *clk;
> @@ -1048,6 +1081,11 @@ static void emc_debugfs_init(struct device *dev)
>                                    &emc_debug_rate_fops);
>         if (!file)
>                 dev_err(dev, "failed to create debugfs entry\n");
> +
> +       file = debugfs_create_file("supported_rates", S_IRUGO, root, emc,
> +                                  &emc_debug_supported_rates_fops);
> +       if (!file)
> +               dev_err(dev, "failed to create debugfs entry\n");
>  }
>
>  static int tegra_emc_probe(struct platform_device *pdev)
> @@ -1119,7 +1157,7 @@ static int tegra_emc_probe(struct platform_device *pdev)
>         platform_set_drvdata(pdev, emc);
>
>         if (IS_ENABLED(CONFIG_DEBUG_FS))
> -               emc_debugfs_init(&pdev->dev);
> +               emc_debugfs_init(&pdev->dev, emc);
>
>         return 0;
>  };
> --
> 2.3.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
