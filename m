From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 15 Nov 2017 15:11:30 +0000
Subject: [PATCH v3 3/4] net: nb8800: Move HW init to ndo_open()
In-Reply-To: <a047ecbd-c8a2-a8c0-7c9d-947b28aa8b9a@sigmadesigns.com> (Marc
 Gonzalez's message of "Wed, 15 Nov 2017 15:58:58 +0100")
References: <230165aa-eaf1-6e2b-7ff3-45b3ee4ffc62@sigmadesigns.com>
 <103bc878-9311-a727-1c21-2070e0a480e5@sigmadesigns.com>
 <yw1xwp2t11ap.fsf@mansr.com>
 <4e22ef54-d823-fc29-fedc-d447fa3d9c88@sigmadesigns.com>
 <yw1xfu9h0xv7.fsf@mansr.com>
 <30042004-4e13-b7e2-b49d-754db54cc5ce@sigmadesigns.com>
 <yw1xbmk4241h.fsf@mansr.com>
 <a047ecbd-c8a2-a8c0-7c9d-947b28aa8b9a@sigmadesigns.com>
Message-ID: <yw1xr2szzie5.fsf@mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:

> On 14/11/2017 17:55, M?ns Rullg?rd wrote:
>
>> Marc Gonzalez wrote:
>> 
>>> I will run iperf3 tests with RX_DESC_COUNT lowered to 2.
>>> Would that produce conclusive results?
>>> Do you have other suggestions?
>> 
>> Leave RX_DESC_COUNT alone but add a delay in the nb8800_poll() loop.
>> That should ensure that queue is drained slowly enough for the buffers
>> to run out.
>
> Using the following patch:
>
> diff --git a/drivers/net/ethernet/aurora/nb8800.c b/drivers/net/ethernet/aurora/nb8800.c
> index 31c3f0f10fbb..646300bb53b6 100644
> --- a/drivers/net/ethernet/aurora/nb8800.c
> +++ b/drivers/net/ethernet/aurora/nb8800.c
> @@ -317,6 +317,7 @@ static int nb8800_poll(struct napi_struct *napi, int budget)
>
>                 len = RX_BYTES_TRANSFERRED(rxd->report);
>
> +               udelay(200);
>                 if (IS_RX_ERROR(rxd->report))
>                         nb8800_rx_error(dev, rxd->report);
>                 else
> @@ -1416,9 +1417,9 @@ static int nb8800_probe(struct platform_device *pdev)
>         netdev_info(dev, "MAC address %pM\n", dev->dev_addr);
>
>         /* Auto-negotiate by default */
> -       priv->pause_aneg = true;
> -       priv->pause_rx = true;
> -       priv->pause_tx = true;
> +       priv->pause_aneg = false;
> +       priv->pause_rx = false;
> +       priv->pause_tx = false;
>
>         priv->ops = match->data;
>         priv->ops->power_down(dev);
> diff --git a/drivers/net/ethernet/aurora/nb8800.h b/drivers/net/ethernet/aurora/nb8800.h
> index 23fefca54804..9b59ea776e4a 100644
> --- a/drivers/net/ethernet/aurora/nb8800.h
> +++ b/drivers/net/ethernet/aurora/nb8800.h
> @@ -7,7 +7,7 @@
>  #include <linux/clk.h>
>  #include <linux/bitops.h>
>
> -#define RX_DESC_COUNT                  256
> +#define RX_DESC_COUNT                  16
>  #define TX_DESC_COUNT                  256
>
>  #define NB8800_DESC_LOW                        4
>
> I saw both tango4 and tango5 wedged... :-(

Well, that's not good.  I'll see if I can replicate it later this week.

-- 
M?ns Rullg?rd
