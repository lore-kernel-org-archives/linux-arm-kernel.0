From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 23 Nov 2018 16:18:06 +0100
Subject: [PATCH 1/7] ata: libahci_platform: comply to PHY framework
In-Reply-To: <20181123101556.29888-2-miquel.raynal@bootlin.com>
References: <20181123101556.29888-1-miquel.raynal@bootlin.com>
 <20181123101556.29888-2-miquel.raynal@bootlin.com>
Message-ID: <20181123151806.GC30913@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 11:15:50AM +0100, Miquel Raynal wrote:
> Current implementation of the libahci does not take into account the
> new PHY framework. Correct the situation by adding a call to
> phy_set_mode() before phy_power_on() and by adding calls to
> ahci_platform_enable/disable_phys() at suspend/resume_host() time.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/ata/libahci_platform.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 4b900fc659f7..9f33f72b674b 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -56,6 +56,12 @@ static int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
>  		if (rc)
>  			goto disable_phys;
>  
> +		rc = phy_set_mode(hpriv->phys[i], PHY_MODE_SATA);
> +		if (rc) {
> +			phy_exit(hpriv->phys[i]);
> +			goto disable_phys;
> +		}

Hi Miquel

Russell King wrote a comphy driver for the Armada 3XX family. It only
supports network PHYs. Did you check it does the right thing when
passed PHY_MODE_SATA? This is slightly different to Hans's comment, in
that i expect phy_set_mode() is implemented for the comphy driver, but
it might not understand PHY_MODE_SATA and return an error?

Maybe you should look at rc and keep going if EOPNOTSUPP is returned?

      Andrew
