From: sre@debian.org (Sebastian Reichel)
Date: Sat, 7 Mar 2015 22:01:02 +0100
Subject: twl4030_charger: need changes to get probed?
In-Reply-To: <20150306212417.GA24169@amd>
References: <20150224043341.4243.23291.stgit@notabene.brown>
 <20150224043352.4243.11227.stgit@notabene.brown>
 <20150302210926.GP13270@amd>
 <20150305173350.50502b95@notabene.brown>
 <20150306212417.GA24169@amd>
Message-ID: <20150307210102.GL5233@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Mar 06, 2015 at 10:24:17PM +0100, Pavel Machek wrote:
> According to n900 dts, twl4030-bci (aka charger) should be
> included.

its part of twl, but not used on N900 afaik.

> (But it does not seem to do anything useful on n900. I was hoping for
> measurement of input voltage, but .. no.)

check for rx51-battery.

> Any ideas why the patch below is needed?

platform_driver_probe() does not support deferred probing.

Neil, can you take this patch into your series for the next round?

-- Sebastian

> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
> index d35b83e..96bbbe9 100644
> --- a/drivers/power/twl4030_charger.c
> +++ b/drivers/power/twl4030_charger.c
> @@ -714,6 +722,7 @@ static const struct of_device_id twl_bci_of_match[] = {
>  MODULE_DEVICE_TABLE(of, twl_bci_of_match);
>  
>  static struct platform_driver twl4030_bci_driver = {
> +	.probe = twl4030_bci_probe,
>  	.driver	= {
>  		.name	= "twl4030_bci",
>  		.of_match_table = of_match_ptr(twl_bci_of_match),
> @@ -721,7 +730,7 @@ static struct platform_driver twl4030_bci_driver = {
>  	.remove	= __exit_p(twl4030_bci_remove),
>  };
>  
> -module_platform_driver_probe(twl4030_bci_driver, twl4030_bci_probe);
> +module_platform_driver(twl4030_bci_driver);
>  
>  MODULE_AUTHOR("Gra?vydas Ignotas");
>  MODULE_DESCRIPTION("TWL4030 Battery Charger Interface driver");
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150307/fa10e97e/attachment.sig>
