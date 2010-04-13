From: jayakumar.lkml@gmail.com (Jaya Kumar)
Date: Wed, 14 Apr 2010 07:26:00 +0800
Subject: [PATCH v2 08/10] [ARM] tegra: Add framebuffer driver
In-Reply-To: <1271198563-10424-9-git-send-email-konkers@android.com>
References: <1268721431-24434-1-git-send-email-konkers@google.com>
	<1271198563-10424-1-git-send-email-konkers@android.com>
	<1271198563-10424-2-git-send-email-konkers@android.com>
	<1271198563-10424-3-git-send-email-konkers@android.com>
	<1271198563-10424-4-git-send-email-konkers@android.com>
	<1271198563-10424-5-git-send-email-konkers@android.com>
	<1271198563-10424-6-git-send-email-konkers@android.com>
	<1271198563-10424-7-git-send-email-konkers@android.com>
	<1271198563-10424-8-git-send-email-konkers@android.com>
	<1271198563-10424-9-git-send-email-konkers@android.com>
Message-ID: <q2l45a44e481004131626j7f5afbfcsfcf861aa70dab651@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please CC fbdev as well. Thanks.

On Wed, Apr 14, 2010 at 6:42 AM,  <konkers@android.com> wrote:
> +/* palette attary used by the fbcon */
> +u32 pseudo_palette[16];

attary?

> +static int tegra_plat_probe(struct platform_device *pdev)
> +{

> + ? ? ? info = framebuffer_alloc(sizeof(struct tegra_fb_info), &pdev->dev);
> + ? ? ? if (!info) {
> + ? ? ? ? ? ? ? ret = -ENOMEM;
> + ? ? ? ? ? ? ? goto err;
> + ? ? ? }
> +
> + ? ? ? irq = platform_get_irq(pdev, 0);
> + ? ? ? if (irq <= 0) {
> + ? ? ? ? ? ? ? pr_debug("%s: no irq\n", pdev->name);
> + ? ? ? ? ? ? ? ret = -ENOENT;
> + ? ? ? ? ? ? ? goto err_free;
> + ? ? ? }

I see the irq get and the request_irq.

> +
> + ? ? ? if (request_irq(irq, tegra_fb_irq, IRQF_DISABLED,
> + ? ? ? ? ? ? ? ? ? ? ? dev_name(&pdev->dev), info)) {
> + ? ? ? ? ? ? ? pr_debug("%s: request_irq %d failed\n",
> + ? ? ? ? ? ? ? ? ? ? ? pdev->name, irq);
> + ? ? ? ? ? ? ? ret = -EBUSY;
> + ? ? ? ? ? ? ? goto err_clk_disable;
> + ? ? ? }
> +

but when I look at the failout cleanup, I didn't see the irq being
cleaned up. Maybe I missed something, just wanted to check that.

> +err_clk_disable:
> + ? ? ? clk_disable(clk);
> +err_iounmap_fb:
> + ? ? ? iounmap(fb_base);
> +err_release_resource_fb:
> + ? ? ? release_resource(fb_mem);
> +err_iounmap_reg:
> + ? ? ? iounmap(reg_base);
> +err_release_resource_reg:
> + ? ? ? release_resource(reg_mem);
> +err_free:
> + ? ? ? framebuffer_release(info);
> +err:
> + ? ? ? return ret;
> +}
> +
> +static int tegra_plat_remove(struct platform_device *pdev)
> +{
> + ? ? ? struct fb_info *info = platform_get_drvdata(pdev);
> + ? ? ? struct tegra_fb_info *tegra_fb = info->par;
> + ? ? ? unregister_framebuffer(info);
> + ? ? ? clk_disable(tegra_fb->clk);
> + ? ? ? iounmap(info->screen_base);
> + ? ? ? release_resource(tegra_fb->fb_mem);
> + ? ? ? iounmap(tegra_fb->reg_base);
> + ? ? ? release_resource(tegra_fb->reg_mem);
> + ? ? ? framebuffer_release(info);
> + ? ? ? return 0;
> +}
> +

Thanks,
jaya
