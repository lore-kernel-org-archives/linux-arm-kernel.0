From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 14 Nov 2017 13:02:32 +0000
Subject: [PATCH v3 4/4] net: nb8800: Add support for suspend/resume
In-Reply-To: <ae0d528a-d602-f399-9d75-65bf9bbf1264@sigmadesigns.com> (Marc
 Gonzalez's message of "Tue, 14 Nov 2017 13:04:25 +0100")
References: <230165aa-eaf1-6e2b-7ff3-45b3ee4ffc62@sigmadesigns.com>
 <ae0d528a-d602-f399-9d75-65bf9bbf1264@sigmadesigns.com>
Message-ID: <yw1xshdh109j.fsf@mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:

> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

Missing patch description.  Don't bother though.  I won't approve of
this implementation.

Suspend support has to depend on the chip since the EMAC core doesn't
have anything of the kind.

> ---
>  drivers/net/ethernet/aurora/nb8800.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/net/ethernet/aurora/nb8800.c b/drivers/net/ethernet/aurora/nb8800.c
> index b71d8fb80610..9af2423aed03 100644
> --- a/drivers/net/ethernet/aurora/nb8800.c
> +++ b/drivers/net/ethernet/aurora/nb8800.c
> @@ -1437,6 +1437,26 @@ static int nb8800_remove(struct platform_device *pdev)
>  	return 0;
>  }
>
> +static int nb8800_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct net_device *dev = platform_get_drvdata(pdev);
> +
> +	if (netif_running(dev))
> +		return nb8800_stop(dev);
> +
> +	return 0;
> +}
> +
> +static int nb8800_resume(struct platform_device *pdev)
> +{
> +	struct net_device *dev = platform_get_drvdata(pdev);
> +
> +	if (netif_running(dev))
> +		return nb8800_open(dev);
> +
> +	return 0;
> +}
> +
>  static struct platform_driver nb8800_driver = {
>  	.driver = {
>  		.name		= "nb8800",
> @@ -1444,6 +1464,8 @@ static struct platform_driver nb8800_driver = {
>  	},
>  	.probe	= nb8800_probe,
>  	.remove	= nb8800_remove,
> +	.suspend = nb8800_suspend,
> +	.resume = nb8800_resume,
>  };
>
>  module_platform_driver(nb8800_driver);
> -- 
> 2.15.0
>

-- 
M?ns Rullg?rd
