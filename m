From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Mon, 29 Aug 2011 16:12:14 +0400
Subject: [PATCH V6 2/5] ahci_plt Add the board_ids and pi refer to
	different features
In-Reply-To: <1314602339-18392-2-git-send-email-richard.zhu@linaro.org>
References: <1314602339-18392-1-git-send-email-richard.zhu@linaro.org>
	<1314602339-18392-2-git-send-email-richard.zhu@linaro.org>
Message-ID: <20110829121214.GA15484@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Aug 29, 2011 at 03:18:55PM +0800, Richard Zhu wrote:
> On imx53 AHCI, soft reset fails with IPMS set when PMP
> is enabled but SATA HDD/ODD is connected to SATA port,
> do soft reset again to port 0.
> So the 'ahci_pmp_retry_srst_ops' is required when imx53
> ahci is present.
> 
> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
> ---
[...]
>  	struct device *dev = &pdev->dev;
>  	struct ahci_platform_data *pdata = dev->platform_data;
> -	struct ata_port_info pi = {
> -		.flags		= AHCI_FLAG_COMMON,
> -		.pio_mask	= ATA_PIO4,
> -		.udma_mask	= ATA_UDMA6,
> -		.port_ops	= &ahci_ops,
> -	};
> +	struct platform_device_id *id_entry = platform_get_device_id(pdev);
> +	struct ata_port_info pi = ahci_port_info[id_entry->driver_data];

Why not pass port info via platform_data? It seems to be platform
specific nowadays, so leave the default as is, but let the platforms
pass their own port info through platform_data.

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
