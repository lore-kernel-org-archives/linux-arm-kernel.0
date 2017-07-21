From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 21 Jul 2017 14:04:07 +0100
Subject: [PATCH v2 3/4] net: ethernet: nb8800: Fix RGMII TX clock delay
 setup
In-Reply-To: <5a68bec8-0b1d-bcfe-65fb-b10399ec75be@sigmadesigns.com> (Marc
 Gonzalez's message of "Fri, 21 Jul 2017 13:26:30 +0200")
References: <2617d673-ef81-5e7f-4730-ed3aa3f1c2c6@sigmadesigns.com>
 <5a68bec8-0b1d-bcfe-65fb-b10399ec75be@sigmadesigns.com>
Message-ID: <yw1xy3riosag.fsf@mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:

> According to commit e5f3a4a56ce2a707b2fb8ce37e4414dcac89c672
> ("Documentation: devicetree: clarify usage of the RGMII phy-modes")
> there are 4 RGMII modes to handle:
>
> "rgmii" (RX and TX delays are added by the MAC when required)
> "rgmii-id" (RGMII with internal RX and TX delays provided by the PHY,
> 	the MAC should not add the RX or TX delays in this case)
> "rgmii-rxid" (RGMII with internal RX delay provided by the PHY,
> 	the MAC should not add an RX delay in this case)
> "rgmii-txid" (RGMII with internal TX delay provided by the PHY,
> 	the MAC should not add an TX delay in this case)
>
> Add TX delay in the MAC only for rgmii and rgmii-rxid.
>
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
>  drivers/net/ethernet/aurora/nb8800.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/aurora/nb8800.c b/drivers/net/ethernet/aurora/nb8800.c
> index ded041dbafe7..f3ed320eb4ad 100644
> --- a/drivers/net/ethernet/aurora/nb8800.c
> +++ b/drivers/net/ethernet/aurora/nb8800.c
> @@ -1268,11 +1268,13 @@ static int nb8800_tangox_init(struct net_device *dev)
>  		break;
>
>  	case PHY_INTERFACE_MODE_RGMII:
> -		pad_mode = PAD_MODE_RGMII;
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +		pad_mode = PAD_MODE_RGMII | PAD_MODE_GTX_CLK_DELAY;
>  		break;
>
> +	case PHY_INTERFACE_MODE_RGMII_ID:
>  	case PHY_INTERFACE_MODE_RGMII_TXID:
> -		pad_mode = PAD_MODE_RGMII | PAD_MODE_GTX_CLK_DELAY;
> +		pad_mode = PAD_MODE_RGMII;
>  		break;
>
>  	default:

I still don't like this.  Having both the MAC and PHY drivers react to
the phy-connection-type property is bound to cause trouble somewhere.

The only way out of the current mess is to define new properties for
both MAC and PHY that override the existing ones if present.

-- 
M?ns Rullg?rd
