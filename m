From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 1 Aug 2010 01:29:30 -0600
Subject: [PATCH] SPI: moved the PL022 test chip out to the SPI subsystem
	v2
In-Reply-To: <1280045963-10564-1-git-send-email-linus.walleij@stericsson.com>
References: <1280045963-10564-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <AANLkTimD=MTn-=EB1Kt87tz9bSVUq+mbZwoOxDbG5sbr@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 25, 2010 at 2:19 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> This moves the SPI test chip from the U300 architecture to the
> SPI subsystem. This is where the code belongs: we want the
> loopback test chip to be available to all users of PL022.
>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>

Hi Linus, thanks for the quick respin.

Better, but not quite right yet in my opinion.  With the code now
embedded into the driver (which I agree with), there is no need to
create a dummy spi_device any more.  What is this code intended to
test?  The hardware, or the spi subsystem.  If it is to test the
hardware (which I suspect), then just driver the hardware directly
(using the driver's own access functions of course).  You don't need
to register a dummy spi_device for that because it is all driver
internal.

If it goal is to exercise the spi subsystem, then do it from userspace
with the loopback flag set, and add loopback flag support to the
driver.  You don't need to test all the modes of the hardware in this
situation.

g.

> ---
> Changes v1->v2:
> - Moved into the PL022 driver instead of keeping this as a module
> ?so as not to set bad examples for SPI chips
> - Moved test triggers and report to debugfs and create a unique
> ?file there
> - One, bisectable patch only
> - Folded in a bad malloc() check fix mailed during review
> ---
> ?arch/arm/mach-u300/Kconfig ?| ? 12 --
> ?arch/arm/mach-u300/Makefile | ? ?1 -
> ?arch/arm/mach-u300/spi.c ? ?| ? 61 -------
> ?drivers/spi/Kconfig ? ? ? ? | ? 14 ++
> ?drivers/spi/amba-pl022.c ? ?| ?369 ++++++++++++++++++++++++++++++++++++++++++-
> ?5 files changed, 382 insertions(+), 75 deletions(-)
>
> diff --git a/arch/arm/mach-u300/Kconfig b/arch/arm/mach-u300/Kconfig
> index 801b21e..337b9aa 100644
> --- a/arch/arm/mach-u300/Kconfig
> +++ b/arch/arm/mach-u300/Kconfig
> @@ -81,18 +81,6 @@ config MACH_U300_SEMI_IS_SHARED
> ? ? ? ? ? ? ? ?Memory Interface) from both from access and application
> ? ? ? ? ? ? ? ?side.
>
> -config MACH_U300_SPIDUMMY
> - ? ? ? bool "SSP/SPI dummy chip"
> - ? ? ? select SPI
> - ? ? ? select SPI_MASTER
> - ? ? ? select SPI_PL022
> - ? ? ? help
> - ? ? ? ? ? ? ? This creates a small kernel module that creates a dummy
> - ? ? ? ? ? ? ? SPI device to be used for loopback tests. Regularly used
> - ? ? ? ? ? ? ? to test reference designs. If you're not testing SPI,
> - ? ? ? ? ? ? ? you don't need it. Selecting this will activate the
> - ? ? ? ? ? ? ? SPI framework and ARM PL022 support.
> -
> ?comment "All the settings below must match the bootloader's settings"
>
> ?config MACH_U300_ACCESS_MEM_SIZE
> diff --git a/arch/arm/mach-u300/Makefile b/arch/arm/mach-u300/Makefile
> index fab46fe..1f0f4b8 100644
> --- a/arch/arm/mach-u300/Makefile
> +++ b/arch/arm/mach-u300/Makefile
> @@ -10,6 +10,5 @@ obj- ? ? ? ? ?:=
> ?obj-$(CONFIG_ARCH_U300) ? ? ? ? ? ? ? ? ?+= u300.o
> ?obj-$(CONFIG_MMC) ? ? ? ? ? ? ? ? += mmc.o
> ?obj-$(CONFIG_SPI_PL022) ? ? ? ? ? += spi.o
> -obj-$(CONFIG_MACH_U300_SPIDUMMY) ?+= dummyspichip.o
> ?obj-$(CONFIG_I2C_STU300) ? ? ? ? ?+= i2c.o
> ?obj-$(CONFIG_REGULATOR_AB3100) ? ?+= regulator.o
> diff --git a/arch/arm/mach-u300/spi.c b/arch/arm/mach-u300/spi.c
> index f0e887b..0790cce 100644
> --- a/arch/arm/mach-u300/spi.c
> +++ b/arch/arm/mach-u300/spi.c
> @@ -16,68 +16,8 @@
> ?/*
> ?* The following is for the actual devices on the SSP/SPI bus
> ?*/
> -#ifdef CONFIG_MACH_U300_SPIDUMMY
> -static void select_dummy_chip(u32 chipselect)
> -{
> - ? ? ? pr_debug("CORE: %s called with CS=0x%x (%s)\n",
> - ? ? ? ? ? ? ? ?__func__,
> - ? ? ? ? ? ? ? ?chipselect,
> - ? ? ? ? ? ? ? ?chipselect ? "unselect chip" : "select chip");
> - ? ? ? /*
> - ? ? ? ?* Here you would write the chip select value to the GPIO pins if
> - ? ? ? ?* this was a real chip (but this is a loopback dummy).
> - ? ? ? ?*/
> -}
> -
> -struct pl022_config_chip dummy_chip_info = {
> - ? ? ? /* Nominally this is LOOPBACK_DISABLED, but this is our dummy chip! */
> - ? ? ? .lbm = LOOPBACK_ENABLED,
> - ? ? ? /*
> - ? ? ? ?* available POLLING_TRANSFER and INTERRUPT_TRANSFER,
> - ? ? ? ?* DMA_TRANSFER does not work
> - ? ? ? ?*/
> - ? ? ? .com_mode = INTERRUPT_TRANSFER,
> - ? ? ? .iface = SSP_INTERFACE_MOTOROLA_SPI,
> - ? ? ? /* We can only act as master but SSP_SLAVE is possible in theory */
> - ? ? ? .hierarchy = SSP_MASTER,
> - ? ? ? /* 0 = drive TX even as slave, 1 = do not drive TX as slave */
> - ? ? ? .slave_tx_disable = 0,
> - ? ? ? /* LSB first */
> - ? ? ? .endian_tx = SSP_TX_LSB,
> - ? ? ? .endian_rx = SSP_RX_LSB,
> - ? ? ? .data_size = SSP_DATA_BITS_8, /* used to be 12 in some default */
> - ? ? ? .rx_lev_trig = SSP_RX_1_OR_MORE_ELEM,
> - ? ? ? .tx_lev_trig = SSP_TX_1_OR_MORE_EMPTY_LOC,
> - ? ? ? .clk_phase = SSP_CLK_SECOND_EDGE,
> - ? ? ? .clk_pol = SSP_CLK_POL_IDLE_LOW,
> - ? ? ? .ctrl_len = SSP_BITS_12,
> - ? ? ? .wait_state = SSP_MWIRE_WAIT_ZERO,
> - ? ? ? .duplex = SSP_MICROWIRE_CHANNEL_FULL_DUPLEX,
> - ? ? ? /*
> - ? ? ? ?* This is where you insert a call to a function to enable CS
> - ? ? ? ?* (usually GPIO) for a certain chip.
> - ? ? ? ?*/
> - ? ? ? .cs_control = select_dummy_chip,
> -};
> -#endif
>
> ?static struct spi_board_info u300_spi_devices[] = {
> -#ifdef CONFIG_MACH_U300_SPIDUMMY
> - ? ? ? {
> - ? ? ? ? ? ? ? /* A dummy chip used for loopback tests */
> - ? ? ? ? ? ? ? .modalias ? ? ? = "spi-dummy",
> - ? ? ? ? ? ? ? /* Really dummy, pass in additional chip config here */
> - ? ? ? ? ? ? ? .platform_data ?= NULL,
> - ? ? ? ? ? ? ? /* This defines how the controller shall handle the device */
> - ? ? ? ? ? ? ? .controller_data = &dummy_chip_info,
> - ? ? ? ? ? ? ? /* .irq - no external IRQ routed from this device */
> - ? ? ? ? ? ? ? .max_speed_hz ? = 1000000,
> - ? ? ? ? ? ? ? .bus_num ? ? ? ?= 0, /* Only one bus on this chip */
> - ? ? ? ? ? ? ? .chip_select ? ?= 0,
> - ? ? ? ? ? ? ? /* Means SPI_CS_HIGH, change if e.g low CS */
> - ? ? ? ? ? ? ? .mode ? ? ? ? ? = 0,
> - ? ? ? },
> -#endif
> ?};
>
> ?static struct pl022_ssp_controller ssp_platform_data = {
> @@ -94,7 +34,6 @@ static struct pl022_ssp_controller ssp_platform_data = {
> ? ? ? ?.num_chipselect = 3,
> ?};
>
> -
> ?void __init u300_spi_init(struct amba_device *adev)
> ?{
> ? ? ? ?struct pmx *pmx;
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 91c2f4f..8f01be6 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -227,6 +227,20 @@ config SPI_PL022
> ? ? ? ? ?controller. If you have an embedded system with an AMBA(R)
> ? ? ? ? ?bus and a PL022 controller, say Y or M here.
>
> +config SPI_PL022_LOOPTEST
> + ? ? ? bool "PL022 loopback test"
> + ? ? ? depends on SPI_PL022
> + ? ? ? select DEBUG_FS
> + ? ? ? help
> + ? ? ? ? The PL022 supports a loopback mode where the output is
> + ? ? ? ? looped back to the input for testing.
> +
> + ? ? ? ? This creates a small kernel module that creates a dummy
> + ? ? ? ? SPI device on each PL022 SPI bus to be used for loopback
> + ? ? ? ? tests. You find the device in the /sys filesystem, e.g.
> + ? ? ? ? /sys/bus/spi/devices/spi0.0/looptest and the test is run by
> + ? ? ? ? issuing cat <looptest>.
> +
> ?config SPI_PPC4xx
> ? ? ? ?tristate "PPC4xx SPI Controller"
> ? ? ? ?depends on PPC32 && 4xx && SPI_MASTER
> diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
> index f0a1418..68e3943 100644
> --- a/drivers/spi/amba-pl022.c
> +++ b/drivers/spi/amba-pl022.c
> @@ -3,7 +3,7 @@
> ?*
> ?* A driver for the ARM PL022 PrimeCell SSP/SPI bus master.
> ?*
> - * Copyright (C) 2008-2009 ST-Ericsson AB
> + * Copyright (C) 2008-2010 ST-Ericsson AB
> ?* Copyright (C) 2006 STMicroelectronics Pvt. Ltd.
> ?*
> ?* Author: Linus Walleij <linus.walleij@stericsson.com>
> @@ -45,6 +45,8 @@
> ?#include <linux/amba/pl022.h>
> ?#include <linux/io.h>
> ?#include <linux/slab.h>
> +#include <linux/debugfs.h>
> +#include <linux/seq_file.h>
>
> ?/*
> ?* This macro is used to define some register default values.
> @@ -337,6 +339,8 @@ struct vendor_data {
> ?* @virtbase: The virtual memory where the SSP is mapped
> ?* @master: SPI framework hookup
> ?* @master_info: controller-specific data from machine setup
> + * @loopdev: loopback device used for testing
> + * @loopdev_file: dentry holding the debugfs file used for testing
> ?* @regs: SSP controller register's virtual address
> ?* @pump_messages: Work struct for scheduling work to the workqueue
> ?* @lock: spinlock to syncronise access to driver data
> @@ -362,6 +366,7 @@ struct pl022 {
> ? ? ? ?struct clk ? ? ? ? ? ? ? ? ? ? ?*clk;
> ? ? ? ?struct spi_master ? ? ? ? ? ? ? *master;
> ? ? ? ?struct pl022_ssp_controller ? ? *master_info;
> + ? ? ? struct spi_device ? ? ? ? ? ? ? *loopdev;
> ? ? ? ?/* Driver message queue */
> ? ? ? ?struct workqueue_struct ? ? ? ? *workqueue;
> ? ? ? ?struct work_struct ? ? ? ? ? ? ?pump_messages;
> @@ -1722,6 +1727,355 @@ static void pl022_cleanup(struct spi_device *spi)
> ? ? ? ?kfree(chip);
> ?}
>
> +/*
> + * The following code self-registers the PL022 loopback
> + * chip on each PL022 SPI bus if desired.
> + */
> +#ifdef CONFIG_SPI_PL022_LOOPTEST
> +
> +struct pl022_loopback {
> + ? ? ? struct device *dev;
> + ? ? ? struct mutex lock;
> + ? ? ? struct dentry *file;
> +};
> +
> +#define DMA_TEST_SIZE 2048
> +
> +static void pl022_select_loopback_chip(u32 chipselect)
> +{
> + ? ? ? pr_debug("PL022 loopback chip: %s called with CS=0x%x (%s)\n",
> + ? ? ? ? ? ? ? ?__func__,
> + ? ? ? ? ? ? ? ?chipselect,
> + ? ? ? ? ? ? ? ?chipselect ? "unselect chip" : "select chip");
> + ? ? ? /*
> + ? ? ? ?* Here you would write the chip select value to the GPIO pins if
> + ? ? ? ?* this was a real chip (but this is a loopback dummy).
> + ? ? ? ?*/
> +}
> +
> +struct pl022_config_chip pl022_loopback_chip_info = {
> + ? ? ? /* Nominally this is LOOPBACK_DISABLED, but this is our dummy chip! */
> + ? ? ? .lbm = LOOPBACK_ENABLED,
> + ? ? ? .com_mode = INTERRUPT_TRANSFER,
> + ? ? ? .iface = SSP_INTERFACE_MOTOROLA_SPI,
> + ? ? ? .hierarchy = SSP_MASTER,
> + ? ? ? .slave_tx_disable = 0,
> + ? ? ? /* LSB first */
> + ? ? ? .endian_tx = SSP_TX_LSB,
> + ? ? ? .endian_rx = SSP_RX_LSB,
> + ? ? ? .data_size = SSP_DATA_BITS_8,
> + ? ? ? .rx_lev_trig = SSP_RX_1_OR_MORE_ELEM,
> + ? ? ? .tx_lev_trig = SSP_TX_1_OR_MORE_EMPTY_LOC,
> + ? ? ? .clk_phase = SSP_CLK_SECOND_EDGE,
> + ? ? ? .clk_pol = SSP_CLK_POL_IDLE_LOW,
> + ? ? ? .ctrl_len = SSP_BITS_12,
> + ? ? ? .wait_state = SSP_MWIRE_WAIT_ZERO,
> + ? ? ? .duplex = SSP_MICROWIRE_CHANNEL_FULL_DUPLEX,
> + ? ? ? .cs_control = pl022_select_loopback_chip,
> +};
> +
> +static struct spi_board_info pl022_loopback_device = {
> + ? ? ? /* A dummy chip used for loopback tests */
> + ? ? ? .modalias ? ? ? = "pl022-loop",
> + ? ? ? /* Really dummy, pass in additional chip config here */
> + ? ? ? .platform_data ?= NULL,
> + ? ? ? /* This defines how the controller shall handle the device */
> + ? ? ? .controller_data = &pl022_loopback_chip_info,
> + ? ? ? /* .irq - no external IRQ routed from this device */
> + ? ? ? .max_speed_hz ? = 1000000,
> + ? ? ? .bus_num ? ? ? ?= 0, /* Only one bus on this chip */
> + ? ? ? .chip_select ? ?= 0,
> + ? ? ? /* Means SPI_CS_HIGH, change if e.g low CS */
> + ? ? ? .mode ? ? ? ? ? = 0,
> +};
> +
> +/*
> + * This is where the tests begin. When we issue:
> + * cat /sys/bus/spi/devices/spi0.0/looptest
> + * this will be triggered.
> + */
> +static int pl022_looptest(struct seq_file *s, void *data)
> +{
> + ? ? ? struct spi_device *spi = s->private;
> + ? ? ? struct pl022_loopback *p_loop = dev_get_drvdata(&spi->dev);
> +
> + ? ? ? /*
> + ? ? ? ?* WARNING! Do not dereference the chip-specific data in any normal
> + ? ? ? ?* driver for a chip. It is usually STATIC and shall not be read
> + ? ? ? ?* or written to. Your chip driver should NOT depend on fields in this
> + ? ? ? ?* struct, this is just used here to alter the behaviour of the chip
> + ? ? ? ?* in order to perform tests.
> + ? ? ? ?*/
> + ? ? ? struct pl022_config_chip *chip_info = spi->controller_data;
> + ? ? ? int status;
> + ? ? ? u8 txbuf[14] = {0xDE, 0xAD, 0xBE, 0xEF, 0x2B, 0xAD,
> + ? ? ? ? ? ? ? ? ? ? ? 0xCA, 0xFE, 0xBA, 0xBE, 0xB1, 0x05,
> + ? ? ? ? ? ? ? ? ? ? ? 0xF0, 0x0D};
> + ? ? ? u8 rxbuf[14];
> + ? ? ? u8 *bigtxbuf_virtual = NULL;
> + ? ? ? u8 *bigrxbuf_virtual = NULL;
> +
> + ? ? ? if (mutex_lock_interruptible(&p_loop->lock))
> + ? ? ? ? ? ? ? return -ERESTARTSYS;
> +
> + ? ? ? bigtxbuf_virtual = kmalloc(DMA_TEST_SIZE, GFP_KERNEL);
> + ? ? ? if (bigtxbuf_virtual == NULL) {
> + ? ? ? ? ? ? ? status = -ENOMEM;
> + ? ? ? ? ? ? ? goto out;
> + ? ? ? }
> + ? ? ? bigrxbuf_virtual = kmalloc(DMA_TEST_SIZE, GFP_KERNEL);
> + ? ? ? if (bigrxbuf_virtual == NULL) {
> + ? ? ? ? ? ? ? status = -ENOMEM;
> + ? ? ? ? ? ? ? goto out;
> + ? ? ? }
> +
> + ? ? ? /* Fill TXBUF with some happy pattern */
> + ? ? ? memset(bigtxbuf_virtual, 0xAA, DMA_TEST_SIZE);
> +
> + ? ? ? /*
> + ? ? ? ?* Force chip to 8 bit mode
> + ? ? ? ?* WARNING: NEVER DO THIS IN REAL DRIVER CODE, THIS SHOULD BE STATIC!
> + ? ? ? ?*/
> + ? ? ? chip_info->data_size = SSP_DATA_BITS_8;
> + ? ? ? /* You should NOT DO THIS EITHER */
> + ? ? ? spi->master->setup(spi);
> +
> + ? ? ? /* Now run the tests for 8bit mode */
> + ? ? ? seq_printf(s, "Simple test 1: write 0xAA byte, read back garbage byte "
> + ? ? ? ? ? ? ? "in 8bit mode\n");
> + ? ? ? status = spi_w8r8(spi, 0xAA);
> + ? ? ? if (status < 0)
> + ? ? ? ? ? ? ? seq_printf(s, "Siple test 1: FAILURE: spi_write_then_read "
> + ? ? ? ? ? ? ? ? ? ? ? ? ?"failed with status %d\n", status);
> + ? ? ? else
> + ? ? ? ? ? ? ? seq_printf(s, "Simple test 1: SUCCESS!\n");
> +
> + ? ? ? seq_printf(s, "Simple test 2: write 8 bytes, read back 8 bytes garbage "
> + ? ? ? ? ? ? ? "in 8bit mode (full FIFO)\n");
> + ? ? ? status = spi_write_then_read(spi, &txbuf[0], 8, &rxbuf[0], 8);
> + ? ? ? if (status < 0)
> + ? ? ? ? ? ? ? seq_printf(s, "Simple test 2: FAILURE: spi_write_then_read() "
> + ? ? ? ? ? ? ? ? ? ? ? ? ?"failed with status %d\n", status);
> + ? ? ? else
> + ? ? ? ? ? ? ? seq_printf(s, "Simple test 2: SUCCESS!\n");
> +
> + ? ? ? seq_printf(s, "Simple test 3: write 14 bytes, read back 14 bytes "
> + ? ? ? ? ? ? ? ? ?"garbage in 8bit mode (see if we overflow FIFO)\n");
> + ? ? ? status = spi_write_then_read(spi, &txbuf[0], 14, &rxbuf[0], 14);
> + ? ? ? if (status < 0)
> + ? ? ? ? ? ? ? seq_printf(s, "Simple test 3: FAILURE: failed with status %d "
> + ? ? ? ? ? ? ? ? ? ? ? ? ?"(probably FIFO overrun)\n", status);
> + ? ? ? else
> + ? ? ? ? ? ? ? seq_printf(s, "Simple test 3: SUCCESS!\n");
> +
> + ? ? ? seq_printf(s, "Simple test 4: write 8 bytes with spi_write(), read 8 "
> + ? ? ? ? ? ? ? "bytes garbage with spi_read() in 8bit mode\n");
> + ? ? ? status = spi_write(spi, &txbuf[0], 8);
> + ? ? ? if (status < 0)
> + ? ? ? ? ? ? ? seq_printf(s, "Simple test 4 step 1: FAILURE: spi_write() "
> + ? ? ? ? ? ? ? ? ? ? ? ? ?"failed with status %d\n", status);
> + ? ? ? else
> + ? ? ? ? ? ? ? seq_printf(s, "Simple test 4 step 1: SUCCESS!\n");
> + ? ? ? status = spi_read(spi, &rxbuf[0], 8);
> + ? ? ? if (status < 0)
> + ? ? ? ? ? ? ? seq_printf(s, "Simple test 4 step 2: FAILURE: spi_read() "
> + ? ? ? ? ? ? ? ? ? ? ? ? ?"failed with status %d\n", status);
> + ? ? ? else
> + ? ? ? ? ? ? ? seq_printf(s, "Simple test 4 step 2: SUCCESS!\n");
> +
> + ? ? ? seq_printf(s, "Simple test 5: write 14 bytes with spi_write(), read "
> + ? ? ? ? ? ? ? "14 bytes garbage with spi_read() in 8bit mode\n");
> + ? ? ? status = spi_write(spi, &txbuf[0], 14);
> + ? ? ? if (status < 0)
> + ? ? ? ? ? ? ? seq_printf(s, "Simple test 5 step 1: FAILURE: spi_write() "
> + ? ? ? ? ? ? ? ? ? ? ? ? ?"failed with status %d (probably FIFO overrun)\n",
> + ? ? ? ? ? ? ? ? ? ? ? ? ?status);
> + ? ? ? else
> + ? ? ? ? ? ? ? seq_printf(s, "Simple test 5 step 1: SUCCESS!\n");
> + ? ? ? status = spi_read(spi, &rxbuf[0], 14);
> + ? ? ? if (status < 0)
> + ? ? ? ? ? ? ? seq_printf(s, "Simple test 5 step 2: FAILURE: spi_read() "
> + ? ? ? ? ? ? ? ? ? ? ? ? ?"failed with status %d (probably FIFO overrun)\n",
> + ? ? ? ? ? ? ? ? ? ? ? ? ?status);
> + ? ? ? else
> + ? ? ? ? ? ? ? seq_printf(s, "Simple test 5: SUCCESS!\n");
> +
> + ? ? ? seq_printf(s, "Simple test 6: write %d bytes with spi_write(), "
> + ? ? ? ? ? ? ? "read %d bytes garbage with spi_read() in 8bit mode\n",
> + ? ? ? ? ? ? ? DMA_TEST_SIZE, DMA_TEST_SIZE);
> + ? ? ? status = spi_write(spi, &bigtxbuf_virtual[0], DMA_TEST_SIZE);
> + ? ? ? if (status < 0)
> + ? ? ? ? ? ? ? seq_printf(s, "Simple test 6 step 1: FAILURE: spi_write() "
> + ? ? ? ? ? ? ? ? ? ? ? ? ?"failed with status %d (probably FIFO overrun)\n",
> + ? ? ? ? ? ? ? ? ? ? ? ? ?status);
> + ? ? ? else
> + ? ? ? ? ? ? ? seq_printf(s, "Simple test 6 step 1: SUCCESS!\n");
> + ? ? ? status = spi_read(spi, &bigrxbuf_virtual[0], DMA_TEST_SIZE);
> + ? ? ? if (status < 0)
> + ? ? ? ? ? ? ? seq_printf(s, "Simple test 6 step 2: FAILURE: spi_read() "
> + ? ? ? ? ? ? ? ? ? ? ? ? ?"failed with status %d (probably FIFO overrun)\n",
> + ? ? ? ? ? ? ? ? ? ? ? ? ?status);
> + ? ? ? else
> + ? ? ? ? ? ? ? seq_printf(s, "Simple test 6: SUCCESS!\n");
> +
> +
> + ? ? ? /*
> + ? ? ? ?* Force chip to 16 bit mode
> + ? ? ? ?* WARNING: NEVER DO THIS IN REAL DRIVER CODE, THIS SHOULD BE STATIC!
> + ? ? ? ?*/
> + ? ? ? chip_info->data_size = SSP_DATA_BITS_16;
> + ? ? ? /* You should NOT DO THIS EITHER */
> + ? ? ? spi->master->setup(spi);
> +
> + ? ? ? seq_printf(s, "Simple test 7: write 0xAA byte, read back garbage byte "
> + ? ? ? ? ? ? ? "in 16bit bus mode\n");
> + ? ? ? status = spi_w8r8(spi, 0xAA);
> + ? ? ? if (status == -EIO)
> + ? ? ? ? ? ? ? seq_printf(s, "Simple test 7: SUCCESS! (expected failure with "
> + ? ? ? ? ? ? ? ? ? ? ? "status EIO)\n");
> + ? ? ? else if (status < 0)
> + ? ? ? ? ? ? ? seq_printf(s, "Siple test 7: FAILURE: spi_write_then_read "
> + ? ? ? ? ? ? ? ? ? ? ? ? ?"failed with status %d\n", status);
> + ? ? ? else
> + ? ? ? ? ? ? ? seq_printf(s, "Simple test 7: FAILURE: spi_write_then_read "
> + ? ? ? ? ? ? ? ? ? ? ? ? ?"succeeded but it was expected to fail!\n");
> +
> + ? ? ? seq_printf(s, "Simple test 8: write 8 bytes, read back 8 bytes garbage "
> + ? ? ? ? ? ? ? "in 16bit mode (full FIFO)\n");
> + ? ? ? status = spi_write_then_read(spi, &txbuf[0], 8, &rxbuf[0], 8);
> + ? ? ? if (status < 0)
> + ? ? ? ? ? ? ? seq_printf(s, "Simple test 8: FAILURE: spi_write_then_read() "
> + ? ? ? ? ? ? ? ? ? ? ? ? ?"failed with status %d\n", status);
> + ? ? ? else
> + ? ? ? ? ? ? ? seq_printf(s, "Simple test 8: SUCCESS!\n");
> +
> + ? ? ? seq_printf(s, "Simple test 9: write 14 bytes, read back 14 bytes "
> + ? ? ? ? ? ? ? "garbage in 16bit mode (see if we overflow FIFO)\n");
> + ? ? ? status = spi_write_then_read(spi, &txbuf[0], 14, &rxbuf[0], 14);
> + ? ? ? if (status < 0)
> + ? ? ? ? ? ? ? seq_printf(s, "Simple test 9: FAILURE: failed with status %d "
> + ? ? ? ? ? ? ? ? ? ? ? ? ?"(probably FIFO overrun)\n", status);
> + ? ? ? else
> + ? ? ? ? ? ? ? seq_printf(s, "Simple test 9: SUCCESS!\n");
> +
> + ? ? ? seq_printf(s, "Simple test 10: write %d bytes with spi_write(), "
> + ? ? ? ? ? ? ?"read %d bytes garbage with spi_read() in 16bit mode\n",
> + ? ? ? ? ? ? ?DMA_TEST_SIZE, DMA_TEST_SIZE);
> + ? ? ? status = spi_write(spi, &bigtxbuf_virtual[0], DMA_TEST_SIZE);
> + ? ? ? if (status < 0)
> + ? ? ? ? ? ? ? seq_printf(s, "Simple test 10 step 1: FAILURE: spi_write() "
> + ? ? ? ? ? ? ? ? ? ? ? ? ?"failed with status %d (probably FIFO overrun)\n",
> + ? ? ? ? ? ? ? ? ? ? ? ? ?status);
> + ? ? ? else
> + ? ? ? ? ? ? ? seq_printf(s, "Simple test 10 step 1: SUCCESS!\n");
> +
> + ? ? ? status = spi_read(spi, &bigrxbuf_virtual[0], DMA_TEST_SIZE);
> + ? ? ? if (status < 0)
> + ? ? ? ? ? ? ? seq_printf(s, "Simple test 10 step 2: FAILURE: spi_read() "
> + ? ? ? ? ? ? ? ? ? ? ? ? ?"failed with status %d (probably FIFO overrun)\n",
> + ? ? ? ? ? ? ? ? ? ? ? ? ?status);
> + ? ? ? else
> + ? ? ? ? ? ? ? seq_printf(s, "Simple test 10: SUCCESS!\n");
> +
> + ? ? ? seq_printf(s, "loop test complete\n");
> + out:
> + ? ? ? kfree(bigrxbuf_virtual);
> + ? ? ? kfree(bigtxbuf_virtual);
> + ? ? ? mutex_unlock(&p_loop->lock);
> + ? ? ? return 0;
> +}
> +
> +static int pl022_looptest_open(struct inode *inode, struct file *file)
> +{
> + ? ? ? return single_open(file, pl022_looptest, inode->i_private);
> +}
> +
> +static const struct file_operations pl022_looptest_operations = {
> + ? ? ? .open ? ? ? ? ? = pl022_looptest_open,
> + ? ? ? .read ? ? ? ? ? = seq_read,
> + ? ? ? .llseek ? ? ? ? = seq_lseek,
> + ? ? ? .release ? ? ? ?= single_release,
> + ? ? ? .owner ? ? ? ? ?= THIS_MODULE,
> +};
> +
> +/*
> + * This is called from the PL022 driver to register a loopback
> + * on itself if this module is compiled in.
> + */
> +static struct spi_device * __init
> +pl022_loopback_probe(struct spi_master *master)
> +{
> + ? ? ? struct pl022_loopback *p_loop;
> + ? ? ? struct spi_device *spidev;
> + ? ? ? char *filename;
> + ? ? ? int status;
> +
> + ? ? ? spidev = spi_new_device(master, &pl022_loopback_device);
> + ? ? ? if (!spidev) {
> + ? ? ? ? ? ? ? dev_err(&master->dev,
> + ? ? ? ? ? ? ? ? ? ? ? "could not register loopback test chip\n");
> + ? ? ? ? ? ? ? return ERR_PTR(-ENOMEM);
> + ? ? ? }
> +
> + ? ? ? dev_info(&spidev->dev,
> + ? ? ? ? ? ? ? ?"registered loopback test chip\n");
> +
> + ? ? ? p_loop = kzalloc(sizeof *p_loop, GFP_KERNEL);
> + ? ? ? if (!p_loop) {
> + ? ? ? ? ? ? ? status = -ENOMEM;
> + ? ? ? ? ? ? ? goto out_dev_create_looptest_failed;
> + ? ? ? }
> +
> + ? ? ? dev_set_drvdata(&spidev->dev, p_loop);
> + ? ? ? mutex_init(&p_loop->lock);
> +
> + ? ? ? /* debugfs hook */
> + ? ? ? filename = kasprintf(GFP_KERNEL, "%s-looptest", dev_name(&spidev->dev));
> + ? ? ? if (!filename) {
> + ? ? ? ? ? ? ? status = -ENOMEM;
> + ? ? ? ? ? ? ? goto out_dev_create_looptest_failed;
> + ? ? ? }
> +
> + ? ? ? p_loop->file = debugfs_create_file(filename, S_IFREG | S_IRUGO,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?NULL, spidev,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?&pl022_looptest_operations);
> + ? ? ? kfree(filename);
> +
> + ? ? ? if (!p_loop->file) {
> + ? ? ? ? ? ? ? dev_err(&spidev->dev, "couldn't create debugfs file\n");
> + ? ? ? ? ? ? ? status = -EIO;
> + ? ? ? ? ? ? ? goto out_dev_create_looptest_failed;
> + ? ? ? }
> +
> + ? ? ? return spidev;
> +
> +out_dev_create_looptest_failed:
> + ? ? ? dev_set_drvdata(&spidev->dev, NULL);
> + ? ? ? spi_unregister_device(spidev);
> + ? ? ? kfree(p_loop);
> + ? ? ? return ERR_PTR(status);
> +}
> +
> +static void __exit pl022_loopback_remove(struct spi_device *spi)
> +{
> + ? ? ? struct pl022_loopback *p_loop = dev_get_drvdata(&spi->dev);
> +
> + ? ? ? dev_info(&spi->dev, "removing loopback SPI device\n");
> + ? ? ? debugfs_remove(p_loop->file);
> + ? ? ? dev_set_drvdata(&spi->dev, NULL);
> + ? ? ? spi_unregister_device(spi);
> + ? ? ? kfree(p_loop);
> +}
> +#else
> +inline struct spi_device *pl022_loopback_probe(struct spi_master *master)
> +{
> + ? ? ? return NULL;
> +}
> +
> +inline void pl022_loopback_remove(struct spi_device *spi)
> +{
> +}
> +#endif
>
> ?static int __init
> ?pl022_probe(struct amba_device *adev, struct amba_id *id)
> @@ -1818,8 +2172,18 @@ pl022_probe(struct amba_device *adev, struct amba_id *id)
> ? ? ? ? ? ? ? ?goto err_spi_register;
> ? ? ? ?}
> ? ? ? ?dev_dbg(dev, "probe succeded\n");
> +
> + ? ? ? /* Register a loopback test if desired - PL023 does not have loopback */
> + ? ? ? if (!pl022->vendor->pl023) {
> + ? ? ? ? ? ? ? pl022->loopdev = pl022_loopback_probe(master);
> + ? ? ? ? ? ? ? if (IS_ERR(pl022->loopdev))
> + ? ? ? ? ? ? ? ? ? ? ? goto err_loopback;
> + ? ? ? }
> +
> ? ? ? ?return 0;
>
> + err_loopback:
> + ? ? ? spi_unregister_master(master);
> ?err_spi_register:
> ?err_start_queue:
> ?err_init_queue:
> @@ -1846,6 +2210,9 @@ pl022_remove(struct amba_device *adev)
> ? ? ? ?if (!pl022)
> ? ? ? ? ? ? ? ?return 0;
>
> + ? ? ? /* Remove any loopback */
> + ? ? ? pl022_loopback_remove(pl022->loopdev);
> +
> ? ? ? ?/* Remove the queue */
> ? ? ? ?status = destroy_queue(pl022);
> ? ? ? ?if (status != 0) {
> --
> 1.7.1.1
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
