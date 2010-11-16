From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 16 Nov 2010 00:22:25 -0700
Subject: [PATCH v5 04/12] spi: add ti-ssp spi master driver
In-Reply-To: <1289848334-8695-5-git-send-email-cyril@ti.com>
References: <1289848334-8695-1-git-send-email-cyril@ti.com>
	<1289848334-8695-5-git-send-email-cyril@ti.com>
Message-ID: <20101116072225.GF4074@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 15, 2010 at 02:12:06PM -0500, Cyril Chemparathy wrote:
> This patch adds an SPI master implementation that operates on top of an
> underlying TI-SSP port.
> 
> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
[...]
> +static int __init ti_ssp_spi_init(void)
> +{
> +	return platform_driver_register(&ti_ssp_spi_driver);
> +}
> +subsys_initcall(ti_ssp_spi_init);

After discussions about device init dependencies at plumbers, and
since this is the first SPI device driver I've reviewed since that
dicussion, this driver gets to be the first to implement the proposed
policy.  :-)

Change this to module_initcall().  Many spi and i2c drivers use
module or subsys_initcall to try and influence driver probe order so
that certain regulator chips get registered before the devices that
try to use them.  This approach is insane.

Instead, it is now incumbent on the board support code to ensure that
any device that depends on another device (including i2c or spi
regulators) will defer registration until the prerequisite devices are
bound to drivers.

I don't *think* this change will affect anything in this particular
patch series, but if it does then let me know and I'll help you work out
how to fix it using a bus notifier.

g.
