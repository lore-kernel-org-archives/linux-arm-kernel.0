From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Feb 2012 11:08:36 +0000
Subject: [PATCH] ARM: OMAP2+: gpmc-smsc911x: add required smsc911x
 regulators
In-Reply-To: <1329151422-2146-1-git-send-email-mporter@ti.com>
References: <1329151422-2146-1-git-send-email-mporter@ti.com>
Message-ID: <20120214110836.GE15338@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two more points:

On Mon, Feb 13, 2012 at 11:43:42AM -0500, Matt Porter wrote:
> This fixes smsc911x support on platforms using gpmc_smsc911x_init().
> Commit c7e963f6888816f04d1f5da0e07bec4e0092f227 added the requirement

Always include the commit summary as well here, so:

Commit c7e963f6888816 (net/smsc911x: Add regulator support) added the ...

> @@ -55,6 +94,11 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *board_data)
>  
>  	gpmc_cfg = board_data;
>  
> +	if (platform_device_register(&gpmc_smsc911x_regulator) < 0) {
> +		pr_err("Unable to register smsc911x regulators\n");
> +		return;
> +	}

It's always a good idea to indicate why something failed:

	err = platform_device_register(&gpmc_smsc911x_regulator);
	if (err < 0) {
		pr_err("Unable to register smsc911x regulators: %d\n", err);
		return;
	}

so that people can see not only what failed, but also why it failed.
