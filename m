From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 22 Jul 2016 09:21:51 -0700
Subject: [PATCH] PM / OPP: optimize dev_pm_opp_set_rate() a bit
In-Reply-To: <1469191370-1285-1-git-send-email-jszhang@marvell.com>
References: <1469191370-1285-1-git-send-email-jszhang@marvell.com>
Message-ID: <20160722162151.GT3122@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22-07-16, 20:42, Jisheng Zhang wrote:
>  static int _set_opp_voltage(struct device *dev, struct regulator *reg,
>  			    unsigned long u_volt, unsigned long u_volt_min,
>  			    unsigned long u_volt_max)
> @@ -586,9 +565,24 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  		return -EINVAL;
>  	}
>  
> -	clk = _get_opp_clk(dev);
> -	if (IS_ERR(clk))
> +	rcu_read_lock();
> +
> +	opp_table = _find_opp_table(dev);
> +	if (IS_ERR(opp_table)) {
> +		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
> +		rcu_read_unlock();
> +		return PTR_ERR(opp_table);
> +	}
> +
> +	clk = opp_table->clk;
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "%s: No clock available for the device\n",
> +			__func__);
> +		rcu_read_unlock();
>  		return PTR_ERR(clk);
> +	}
> +
> +	rcu_read_unlock();

It is not _safe_ to use opp_table pointer after the rcu_read_unlock()
here.

-- 
viresh
