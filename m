From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 1 Jun 2015 09:22:00 +0100
Subject: [PATCH 4/4] mfd: 88pm800: allocate pdata->rtc if not allocated
 earlier
In-Reply-To: <1432937962-4537-5-git-send-email-vaibhav.hiremath@linaro.org>
References: <1432937962-4537-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1432937962-4537-5-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <20150601082200.GC3329@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 30 May 2015, Vaibhav Hiremath wrote:

> RTC in pmic 88PM800 can run even the core is powered off, and user
> can set alarm in RTC. When the alarm is timed out, the PMIC will power up
> the core, and the whole system will boot up. And during PMIC driver probe,
> it will read some register to find out whether this boot is caused by RTC
> timeout or not, and pass on this information to the RTC driver.
> 
> So we need rtc platform data to be existed in PMIC driver to pass this
> information.
> 
> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> ---
>  drivers/mfd/88pm800.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
> index 8ea4467..34546a1 100644
> --- a/drivers/mfd/88pm800.c
> +++ b/drivers/mfd/88pm800.c
> @@ -586,6 +586,25 @@ static int pm800_probe(struct i2c_client *client,
>  			return ret;
>  	}
>  
> +	/*
> +	 * RTC in pmic can run even the core is powered off, and user can set
> +	 * alarm in RTC. When the alarm is time out, the PMIC will power up
> +	 * the core, and the whole system will boot up. When PMIC driver is
> +	 * probed, it will read out some register to find out whether this
> +	 * boot is caused by RTC timeout or not, and it need pass this
> +	 * information to RTC driver.
> +	 * So we need rtc platform data to be existed to pass this information.
> +	 */
> +	if (!pdata->rtc) {
> +		pdata->rtc = devm_kzalloc(&client->dev,
> +					  sizeof(*(pdata->rtc)), GFP_KERNEL);
> +		if (!pdata->rtc) {
> +			dev_err(&client->dev,
> +					"failed to allocate memory for rtc\n");
> +			return -ENOMEM;
> +		}
> +	}
> +

Where is this memory first used?

>  	ret = pm80x_init(client);
>  	if (ret) {
>  		dev_err(&client->dev, "pm800_init fail\n");

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
