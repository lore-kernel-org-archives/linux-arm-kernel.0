From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 10 Sep 2012 12:14:20 -0700
Subject: [PATCH 05/11] clk: Versatile Express clock generators ("osc")
 driver
In-Reply-To: <1346689531-7212-6-git-send-email-pawel.moll@arm.com>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
 <1346689531-7212-6-git-send-email-pawel.moll@arm.com>
Message-ID: <20120910191420.20289.1923@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Pawel Moll (2012-09-03 09:25:25)
> +static int vexpress_osc_probe(struct vexpress_config_device *vecdev)
> +{
> +       int err;
> +       struct device_node *node = vecdev->dev.of_node;
> +       struct vexpress_osc_info *info = vecdev->dev.platform_data;
> +       struct clk_init_data init;
> +       struct vexpress_osc *osc;
> +       struct clk *clk;
> +       const char * const *dev_ids = NULL;
> +       u32 range[2];
> +
> +       if (vecdev->status & VEXPRESS_CONFIG_DEVICE_PROBED_EARLY)
> +               return 0;
> +
> +       osc = kzalloc(sizeof(*osc), GFP_KERNEL);
> +       if (!osc) {
> +               err = -ENOMEM;
> +               goto error;

Minor nitpick: the error label tries to free osc, which in this case
shouldn't be freed because it is NULL.

<snip>
> +error:
> +       kfree(osc);
> +       return err;

Would be better to have something like:

		error_clk:
			kfree(osc);
		error_osc:
			return err;

Otherwise patch looks good to me.  There are some changes to headers in
this patch, and it is part of a larger series.  How did you want the
common clk patches to get merged?

Regards,
Mike
