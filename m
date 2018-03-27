From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 27 Mar 2018 19:13:43 +0200
Subject: [net-next PATCH v2 03/10] net: netcp: ethss: make call to
 gbe_sgmii_config() conditional
In-Reply-To: <1522168309-12338-4-git-send-email-m-karicheri2@ti.com>
References: <1522168309-12338-1-git-send-email-m-karicheri2@ti.com>
 <1522168309-12338-4-git-send-email-m-karicheri2@ti.com>
Message-ID: <20180327171343.GN5862@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2018 at 12:31:42PM -0400, Murali Karicheri wrote:
> As a preparatory patch to add support for 2u cpsw hardware found on
> K2G SoC, make call to gbe_sgmii_config() conditional. This is required
> since 2u uses RGMII interface instead of SGMII and to allow for driver
> re-use.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---
>  drivers/net/ethernet/ti/netcp_ethss.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
> index 56dbc0b..1dea891 100644
> --- a/drivers/net/ethernet/ti/netcp_ethss.c
> +++ b/drivers/net/ethernet/ti/netcp_ethss.c
> @@ -2271,7 +2271,8 @@ static int gbe_slave_open(struct gbe_intf *gbe_intf)
>  
>  	void (*hndlr)(struct net_device *) = gbe_adjust_link;
>  
> -	gbe_sgmii_config(priv, slave);
> +	if ((priv->ss_version == GBE_SS_VERSION_14) || IS_SS_ID_NU(priv))
> +		gbe_sgmii_config(priv, slave);

Hi Murali

So you have:

#define IS_SS_ID_NU(d) \
	(GBE_IDENT((d)->ss_version) == GBE_SS_ID_NU)


Does version 14 have a name? Could you add another IS_SS_ID_XX(d)
macro for it? That would make these statements more consistent.

	Andrew
