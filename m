From: axel.lin@gmail.com (Axel Lin)
Date: Fri, 9 Mar 2012 10:59:56 +0800
Subject: [PATCH v10] Regulator: Add Anatop regulator driver
In-Reply-To: <1331200744-5986-1-git-send-email-paul.liu@linaro.org>
References: <1331200744-5986-1-git-send-email-paul.liu@linaro.org>
Message-ID: <CAF+7xWmDUhzuaPXuGRsr2b4ZjCjxgwpv0hpvMrGqNz3gjUeW0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> + ? ? ? if (anatop_reg->control_reg) {
> + ? ? ? ? ? ? ? sel = (uv - anatop_reg->min_voltage) / 25000;

sel = DIV_ROUND_UP(uv - anatop_reg->min_voltage, 25000);

Use DIV_ROUND_UP to avoid the possible truncate of integer division.
This ensures the selected volatge falls within the specified range.


> +static int __devexit anatop_regulator_remove(struct platform_device *pdev)
> +{
> + ? ? ? struct regulator_dev *rdev = platform_get_drvdata(pdev);
> + ? ? ? struct anatop_regulator *sreg = rdev_get_drvdata(rdev);
> + ? ? ? kfree(sreg->name);
> + ? ? ? regulator_unregister(rdev);
Do regulator_unregister before kfree sreg->name.
