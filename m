From: joe@perches.com (Joe Perches)
Date: Fri, 08 Jan 2016 11:59:53 -0800
Subject: [PATCH] ata: add AMD Seattle platform driver
In-Reply-To: <1452200002-31590-1-git-send-email-brijesh.singh@amd.com>
References: <1452200002-31590-1-git-send-email-brijesh.singh@amd.com>
Message-ID: <1452283193.4028.84.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-01-07 at 14:53 -0600, Brijesh Singh wrote:
> AMD Seattle SATA controller mostly conforms to AHCI interface with some
> special register to control SGPIO interface. In the case of an AHCI
> controller, the SGPIO feature is ideally implemented using the
> "Enclosure Management" register of the AHCI controller, but those
> registeres are not implemented in the Seattle SoC. Instead SoC
> (Rev B0 onwards) provides a 32-bit SGPIO control register which should
> be programmed to control the activity, locate and fault LEDs.

trivia:

> diff --git a/drivers/ata/ahci_seattle.c b/drivers/ata/ahci_seattle.c
[]
> +static ssize_t seattle_transmit_led_message(struct ata_port *ap, u32 state,
> +					????ssize_t size)
> +{
> +	struct ahci_host_priv *hpriv = ap->host->private_data;
> +	struct ahci_port_priv *pp = ap->private_data;
> +	struct seattle_plat_data *plat_data = hpriv->plat_data;
> +	unsigned long flags;
> +	int pmp;
> +	struct ahci_em_priv *emp;
> +	u32 val;
> +
> +	/* get the slot number from the message */
> +	pmp = (state & EM_MSG_LED_PMP_SLOT) >> 8;
> +	if (pmp < EM_MAX_SLOTS)
> +		emp = &pp->em_priv[pmp];
> +	else
> +		return -EINVAL;

This is generally done using a inverted test that
returns immediately

	if (pmp >= EMP_MAX_SLOTS)
		return -EINVAL;

	emp = &pp->em_priv[pmp];
