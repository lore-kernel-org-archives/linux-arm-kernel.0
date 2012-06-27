From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 27 Jun 2012 15:24:35 -0600 (MDT)
Subject: [PATCH v2 1/2] arm: omap3: am35x: Add Davinci EMAC/MDIO hwmod
 support
In-Reply-To: <1337105642-22711-2-git-send-email-mgreer@animalcreek.com>
References: <1337105642-22711-1-git-send-email-mgreer@animalcreek.com>
 <1337105642-22711-2-git-send-email-mgreer@animalcreek.com>
Message-ID: <alpine.DEB.2.00.1206271520580.27496@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

one comment on this one

On Tue, 15 May 2012, Mark A. Greer wrote:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> Add hwmod support for the EMAC (and MDIO)
> ethernet controller that's on the am35x
> family of SoC's.
> 
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>

> +static struct omap_hwmod_ocp_if am35xx_mdio__l3 = {
> +	.master		= &am35xx_mdio_hwmod,
> +	.slave		= &omap3xxx_l3_main_hwmod,
> +	.clk		= "emac_fck",
> +	.user		= OCP_USER_MPU,
> +};

...

> +/* l4_core -> davinci mdio  */
> +static struct omap_hwmod_ocp_if am35xx_l4_core__mdio = {
> +	.master		= &omap3xxx_l4_core_hwmod,
> +	.slave		= &am35xx_mdio_hwmod,
> +	.clk		= "emac_fck",
> +	.addr		= am35xx_mdio_addrs,
> +	.user		= OCP_USER_MPU,
> +};

...

> +/* l4_core -> davinci emac  */
> +static struct omap_hwmod_ocp_if am35xx_l4_core__emac = {
> +	.master		= &omap3xxx_l4_core_hwmod,
> +	.slave		= &am35xx_emac_hwmod,
> +	.clk		= "emac_ick",
> +	.addr		= am35xx_emac_addrs,
> +	.user		= OCP_USER_MPU,
> +};

As I understand it, these devices are actually directly connected to the 
IPSS.  However, for such a topology to work correctly, we'll probably need 
some changes in the hwmod core.  I had hoped to have this done for 3.6, 
but that's looking pretty unlikely.  So instead, will drop some comments 
in the data to note that this will need to be fixed.


- Paul
