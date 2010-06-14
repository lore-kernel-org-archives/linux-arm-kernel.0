From: jayakumar.lkml@gmail.com (Jaya Kumar)
Date: Tue, 15 Jun 2010 07:59:54 +0800
Subject: [PATCH v3 10/11] [ARM] tegra: Add framebuffer driver
In-Reply-To: <1276549827-2688-11-git-send-email-konkers@android.com>
References: <1271198563-10424-1-git-send-email-konkers@android.com>
	<1276549827-2688-1-git-send-email-konkers@android.com>
	<1276549827-2688-2-git-send-email-konkers@android.com>
	<1276549827-2688-3-git-send-email-konkers@android.com>
	<1276549827-2688-4-git-send-email-konkers@android.com>
	<1276549827-2688-5-git-send-email-konkers@android.com>
	<1276549827-2688-6-git-send-email-konkers@android.com>
	<1276549827-2688-7-git-send-email-konkers@android.com>
	<1276549827-2688-8-git-send-email-konkers@android.com>
	<1276549827-2688-9-git-send-email-konkers@android.com>
	<1276549827-2688-10-git-send-email-konkers@android.com>
	<1276549827-2688-11-git-send-email-konkers@android.com>
Message-ID: <AANLkTikqOrciEnESCC1yGm0UvcxdK942ddrZF4K49TVb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 15, 2010 at 5:10 AM, Erik Gilling <konkers@android.com> wrote:
> diff --git a/drivers/video/tegrafb.c b/drivers/video/tegrafb.c
> new file mode 100644
> index 0000000..47b2d42
> --- /dev/null
> +++ b/drivers/video/tegrafb.c

> +/* palette attary used by the fbcon */
> +u32 pseudo_palette[16];

attary

> +
> +irqreturn_t tegra_fb_irq(int irq, void *ptr)
> +{
> + ? ? ? struct fb_info *info = ptr;
> + ? ? ? struct tegra_fb_info *tegra_fb = info->par;
> +
> + ? ? ? u32 reg = tegra_fb_readl(tegra_fb, DC_CMD_INT_STATUS);
> + ? ? ? tegra_fb_writel(tegra_fb, reg, DC_CMD_INT_STATUS);
> +
> + ? ? ? tegra_fb->wait_condition = 1;
> + ? ? ? wake_up(&tegra_fb->event_wq);
> + ? ? ? return IRQ_HANDLED;
> +}
> +
> +static int tegra_fb_wait_for_event(struct tegra_fb_info *tegra_fb,
> + ? ? ? unsigned long timeout, u32 irq_mask)
> +{
> + ? ? ? u32 reg;
> +
> + ? ? ? tegra_fb->wait_condition = 0;
> +
> + ? ? ? reg = tegra_fb_readl(tegra_fb, DC_CMD_INT_MASK);
> + ? ? ? reg |= irq_mask;
> + ? ? ? tegra_fb_writel(tegra_fb, reg, DC_CMD_INT_MASK);
> +
> + ? ? ? /* Clear any pending interrupt */
> + ? ? ? tegra_fb_writel(tegra_fb, irq_mask, DC_CMD_INT_STATUS);
> +
> + ? ? ? tegra_fb_writel(tegra_fb, irq_mask, DC_CMD_INT_ENABLE);
> +
> + ? ? ? /* Wait for the irq to fire */
> + ? ? ? wait_event_interruptible_timeout(tegra_fb->event_wq,
> + ? ? ? ? ? ? ? tegra_fb->wait_condition, timeout);
> +
> + ? ? ? tegra_fb_writel(tegra_fb, 0, DC_CMD_INT_ENABLE);
> +
> + ? ? ? if (!tegra_fb->wait_condition) {
> + ? ? ? ? ? ? ? pr_warning("%s: wait for vsync timed out\n", __func__);
> + ? ? ? ? ? ? ? return -ETIMEDOUT;
> + ? ? ? }
> + ? ? ? return 0;
> +}

Apologies for the incremental review. The wait_condition code above
looks odd to me. Typically, we just test the return value of
wait_event_interruptible_timeout to see whether it timed out (returns
0 if so). But I guess the above approach works as well.

> +               if (tegra_fb_wait_for_event(tegra_fb, HZ/10, DC_INT_FRAME_END))

I still didn't follow how tegra_fb_activate is using the -ETIMEDOUT
return value from the wait, it seems like it is just ignored. You are
also doing stuff like HZ/10 and you might prefer to use
msecs_to_jiffies.

Thanks,
jaya
