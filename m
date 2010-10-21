From: joe@perches.com (Joe Perches)
Date: Thu, 21 Oct 2010 14:19:22 -0700
Subject: [PATCH v3 10/12] backlight: add support for tps6116x controller
In-Reply-To: <1287694873-12904-11-git-send-email-cyril@ti.com>
References: <1287694873-12904-1-git-send-email-cyril@ti.com>
	<1287694873-12904-11-git-send-email-cyril@ti.com>
Message-ID: <1287695962.15567.98.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-10-21 at 17:01 -0400, Cyril Chemparathy wrote:
> diff --git a/drivers/video/backlight/tps6116x.c b/drivers/video/backlight/tps6116x.c

just some trivia:

> @@ -0,0 +1,340 @@
[]
> +struct tps6116x {
> +	struct ti_ssp_device		*handle;
> +	struct device			*dev;
> +	int				gpio, gpio_initialized;
> +	struct mutex			lock;
> +	int				intensity;
> +	int				power;
> +	struct backlight_properties	props;
> +	struct backlight_device		*bl;
> +	int				suspended:1;
> +	struct regulator		*regulator;
> +};

Perhaps several of these should be bool.
gpio_initialized, power, suspended

[]

> +static int __devinit tps6116x_probe(struct platform_device *pdev)
> +{
> +	struct tps6116x *hw;
> +	struct device *dev = &pdev->dev;
> +	struct backlight_properties props;
> +	int error;
> +
> +	hw = kzalloc(sizeof(struct tps6116x), GFP_KERNEL);
> +	if (!hw) {
> +		error = -ENOMEM;
> +		dev_err(dev, "cannot allocate driver data\n");
> +		goto fail0;
> +	}
> +	platform_set_drvdata(pdev, hw);
> +
> +	memset(hw, 0, sizeof(struct tps6116x));

Unnecessary memset.
