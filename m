From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 2 Sep 2010 08:22:49 -0600
Subject: [PATCH v4] spi: add spi_tegra driver
In-Reply-To: <1283379393-14831-1-git-send-email-konkers@android.com>
References: <1282771395-21684-1-git-send-email-konkers@android.com>
	<1283379393-14831-1-git-send-email-konkers@android.com>
Message-ID: <AANLkTimonLa1mUVSHR=QnR48HPtAZ5BW3BsVsg7MWALy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 1, 2010 at 4:16 PM, Erik Gilling <konkers@android.com> wrote:
> v2 changes:
> ?from Thierry Reding:
> ? ?* add "select TEGRA_SYSTEM_DMA" to Kconfig
> ?from Grant Likely:
> ? ?* add oneline description to header
> ? ?* inline references to DRIVER_NAME
> ? ?* inline references to BUSY_TIMEOUT
> ? ?* open coded bytes_per_word()
> ? ?* spi_readl/writel -> spi_tegra_readl/writel
> ? ?* move transfer validation to spi_tegra_transfer
> ? ?* don't request_mem_region iomem as platform bus does that for us
> ? ?* __exit -> __devexit
>
> v3 changes:
> ?from Russell King:
> ? ?* put request_mem_region back int
> ?from Grant Likely:
> ? ?* remove #undef DEBUG
> ? ?* add SLINK_ to register bit defines
> ? ?* remove unused bytes_per_word
> ? ?* make spi_tegra_readl/writel static linine
> ? ?* various refactoring for clarity
> ? ?* mark err if BSY bit is not cleared after 1000 retries
> ? ?* move spinlock to protect setting of RDY bit
> ? ?* subsys_initcall -> module_init
>
> v3 changes:
> ?from Grant Likely:
> ? ?* update spi_tegra to use PTR_ERRless dma API
>
> Signed-off-by: Erik Gilling <konkers@android.com>
> Cc: Thierry Reding <thierry.reding@avionic-design.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Russell King <linux@arm.linux.org.uk>

Hi Erik,

Go ahead and add my Acked-by line and merge this via the tegra tree to
avoid ordering issues.  I also have a few more minor comments below.

g.

> + ? ? ? /* FIXME: should probably control CS manually so that we can be sure
> + ? ? ? ?* it does not go low between transfer and to support delay_usecs
> + ? ? ? ?* correctly.
> + ? ? ? ?*/

Yes, you'll probably want to revisit this.  A lot of SPI hardware
doesn't understand that the actual transfer may be longer that the
data it immediately knows about.  Also, it is common to use GPIOs as
chip selects.

> +static void spi_tegra_cleanup(struct spi_device *spi)
> +{
> + ? ? ? dev_dbg(&spi->dev, "cleanup\n");
> +}

Remove the empty hook

> +static int __init spi_tegra_probe(struct platform_device *pdev)
> +{
> + ? ? ? struct spi_master ? ? ? *master;
> + ? ? ? struct spi_tegra_data ? *tspi;
> + ? ? ? struct resource ? ? ? ? *r;
> + ? ? ? int ret;
> +
> + ? ? ? master = spi_alloc_master(&pdev->dev, sizeof *tspi);
> + ? ? ? if (master == NULL) {
> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "master allocation failed\n");
> + ? ? ? ? ? ? ? return -ENOMEM;
> + ? ? ? }
> +
> + ? ? ? /* the spi->mode bits understood by this driver: */
> + ? ? ? master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
> +
> + ? ? ? if (pdev->id != -1)
> + ? ? ? ? ? ? ? master->bus_num = pdev->id;

even if pdev->id is -1, you probably want to set master->bus_num to is
so that a spi bus number can be dynamically assigned.
