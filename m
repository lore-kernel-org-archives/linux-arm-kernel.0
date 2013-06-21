From: broonie@kernel.org (Mark Brown)
Date: Fri, 21 Jun 2013 15:37:45 +0100
Subject: [PATCH v2 3/3] mfd: max8998: Add support for Device Tree
In-Reply-To: <1371818017-5215-4-git-send-email-t.figa@samsung.com>
References: <1371818017-5215-1-git-send-email-t.figa@samsung.com>
 <1371818017-5215-4-git-send-email-t.figa@samsung.com>
Message-ID: <20130621143745.GV27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 02:33:37PM +0200, Tomasz Figa wrote:

> +	- EN32KHz AP: 32KHz clock output for application processor
> +	- EN32KHz CP: 32KHz clock output for call processor

The clocks should be supported using the clock API not the regulator
API, they shouldn't be present in the DT regulator binding.

> +	if (iodev->dev->of_node) {
> +		ret = max8998_pmic_dt_parse_pdata(iodev, pdata);
> +		if (ret)
> +			return ret;
> +	}
> +

Might be neater to have the check inside the function?

>  		if (IS_ERR(rdev[i])) {
>  			ret = PTR_ERR(rdev[i]);
> -			dev_err(max8998->dev, "regulator init failed\n");
> +			dev_err(max8998->dev, "regulator %s init failed\n",
> +							regulators[index].name);

Print the error code (the original doesn't but since you're changing
it...)?

> index 46f2301..042a873 100644
> --- a/drivers/rtc/rtc-max8998.c
> +++ b/drivers/rtc/rtc-max8998.c
> @@ -253,7 +253,7 @@ static const struct rtc_class_ops max8998_rtc_ops = {
>  static int max8998_rtc_probe(struct platform_device *pdev)
>  {
>  	struct max8998_dev *max8998 = dev_get_drvdata(pdev->dev.parent);
> -	struct max8998_platform_data *pdata = dev_get_platdata(max8998->dev);
> +	struct max8998_platform_data *pdata = max8998->pdata;
>  	struct max8998_rtc_info *info;
>  	int ret;
>  

Probably better to split out this refactoring into a separate patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130621/057d0c5b/attachment.sig>
