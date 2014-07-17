From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 17 Jul 2014 16:59:59 +0200
Subject: [PATCH v2 5/5] i2c: tegra: Remove suspension check
In-Reply-To: <1405608520-5644-5-git-send-email-hechtb@gmail.com>
References: <1405608520-5644-1-git-send-email-hechtb@gmail.com>
 <1405608520-5644-5-git-send-email-hechtb@gmail.com>
Message-ID: <20140717145958.GA32534@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 04:48:40PM +0200, Bastian Hecht wrote:
[...]
>  #ifdef CONFIG_PM_SLEEP
> -static int tegra_i2c_suspend(struct device *dev)
> -{
> -	struct tegra_i2c_dev *i2c_dev = dev_get_drvdata(dev);
> -
> -	i2c_lock_adapter(&i2c_dev->adapter);
> -	i2c_dev->is_suspended = true;
> -	i2c_unlock_adapter(&i2c_dev->adapter);
> -
> -	return 0;
> -}
> -
>  static int tegra_i2c_resume(struct device *dev)
>  {
>  	struct tegra_i2c_dev *i2c_dev = dev_get_drvdata(dev);
> @@ -842,14 +827,12 @@ static int tegra_i2c_resume(struct device *dev)
>  		return ret;
>  	}
>  
> -	i2c_dev->is_suspended = false;
> -
>  	i2c_unlock_adapter(&i2c_dev->adapter);
>  
>  	return 0;
>  }
>  
> -static SIMPLE_DEV_PM_OPS(tegra_i2c_pm, tegra_i2c_suspend, tegra_i2c_resume);
> +static SIMPLE_DEV_PM_OPS(tegra_i2c_pm, tegra_i2c_resume);

Shouldn't this be:

	static SIMPLE_DEV_OPS(tegra_i2c_pm, NULL, tegra_i2c_resume);

instead?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/0c2d9e59/attachment.sig>
