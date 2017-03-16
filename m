From: tj@kernel.org (Tejun Heo)
Date: Thu, 16 Mar 2017 17:26:54 -0400
Subject: [PATCH] pata_pcmcia: add EBSA110's PCMCIA slot support
In-Reply-To: <3458240.9SL7iGif3L@amdc3058>
References: <CGME20170314175046epcas1p43f98daad14a2bac7f314e7d39e120232@epcas1p4.samsung.com>
 <3458240.9SL7iGif3L@amdc3058>
Message-ID: <20170316212654.GD1480@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Mar 14, 2017 at 06:50:43PM +0100, Bartlomiej Zolnierkiewicz wrote:
> +static struct ata_port_operations pcmcia_ebsa110_port_ops = {
> +	.inherits		= &ata_sff_port_ops,
> +	.sff_dev_select		= pmcmia_ebsa110_dev_select,
                                  ^^^^^^
> +	.sff_set_devctl         = pcmcia_ebsa110_set_devctl,
> +	.sff_check_status	= pcmcia_ebsa110_check_status,
> +	.sff_check_altstatus    = pcmcia_ebsa110_check_altstatus,
> +	.sff_tf_load		= pcmcia_ebsa110_tf_load,
> +	.sff_tf_read		= pcmcia_ebsa110_tf_read,
> +	.sff_exec_command	= pcmcia_ebsa110_exec_command,
> +	.sff_data_xfer		= ata_sff_data_xfer_noirq,
> +	.softreset		= pata_pcmcia_ebsa110_softreset,
> +	.cable_detect		= ata_cable_40wire,
> +	.set_mode		= pcmcia_set_mode,
> +};

Heh, that's a fat driver for a sff device.  I suppose this is mostly
copied from the matching ide driver but it'd be nice to explain why it
needs duplicate most standard functions.  Is it because PCMCIA
assigned address doesn't fall under the usual read/io boundary on the
arch?

Thanks.

-- 
tejun
