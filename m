From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 16 Apr 2010 23:30:45 -0700
Subject: [PATCH v3 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <e0e5dc30af89f0b65fd2e5e52f9e7fe9f162516b.1271156934.git.mika.westerberg@iki.fi>
References: <cover.1271156934.git.mika.westerberg@iki.fi>
	<e0e5dc30af89f0b65fd2e5e52f9e7fe9f162516b.1271156934.git.mika.westerberg@iki.fi>
Message-ID: <n2jfa686aa41004162330qae611a0u87be76ca08bfb52a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mika,

Thanks for the patch.  Comments below.

g.

On Tue, Apr 13, 2010 at 7:10 AM, Mika Westerberg <mika.westerberg@iki.fi> wrote:
> This patch adds an SPI master driver for the Cirrus EP93xx SPI controller found
> in EP93xx chips (EP9301, EP9302, EP9307, EP9312 and EP9315).
>
> Driver supports polling and interrupt based transfer methods. This can be
> selected with module parameter 'transfer_method'.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
> ---
> ?arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h | ? 34 +
> ?drivers/spi/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ? ?| ? 11 +
> ?drivers/spi/Makefile ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ?1 +
> ?drivers/spi/ep93xx_spi.c ? ? ? ? ? ? ? ? ? ? ? | 1113 ++++++++++++++++++++++++
> ?4 files changed, 1159 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h
> ?create mode 100644 drivers/spi/ep93xx_spi.c
>
> diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h b/arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h
> new file mode 100644
> index 0000000..fe93d2e
> --- /dev/null
> +++ b/arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h
> @@ -0,0 +1,34 @@
> +#ifndef __ASM_MACH_EP93XX_SPI_H
> +#define __ASM_MACH_EP93XX_SPI_H
> +
> +/**
> + * struct ep93xx_spi_info - EP93xx specific SPI descriptor
> + * @num_chipselect: number of chip select GPIOs on this board
> + * @cs_control: chip select control function
> + * @data: pointer to data that is passed to @cs_control function.
> + * ? ? ? ?Can be %NULL if not needed.
> + *
> + * This structure is passed from board support files to EP93xx SPI controller
> + * driver. It provides callback hook to control chip select GPIOs that are
> + * allocated in board support files during board initialization.
> + */
> +struct ep93xx_spi_info {
> + ? ? ? int ? ? num_chipselect;
> + ? ? ? /*
> + ? ? ? ?* cs_control() - control board chipselect GPIO lines
> + ? ? ? ?* @cs: chip select to control
> + ? ? ? ?* @value: value to set the chip select line to
> + ? ? ? ?* @data: optional data
> + ? ? ? ?*
> + ? ? ? ?* This function is used to control board specific GPIO lines that
> + ? ? ? ?* are allocated as SPI chipselects. @value is either %0 or %1. It
> + ? ? ? ?* is possibled to pass additional information using @data.
> + ? ? ? ?*
> + ? ? ? ?* This function is called from thread context and can sleep if
> + ? ? ? ?* necessary.
> + ? ? ? ?*/
> + ? ? ? void ? ?(*cs_control)(unsigned cs, unsigned value, void *data);
> + ? ? ? void ? ?*data;
> +};
> +
> +#endif /* __ASM_MACH_EP93XX_SPI_H */
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index a191fa2..5852340 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -117,6 +117,17 @@ config SPI_DAVINCI
> ? ? ? ?help
> ? ? ? ? ?SPI master controller for DaVinci and DA8xx SPI modules.
>
> +config SPI_EP93XX
> + ? ? ? tristate "Cirrus Logic EP93xx SPI controller"
> + ? ? ? depends on ARCH_EP93XX
> + ? ? ? help
> + ? ? ? ? This enables using the Cirrus EP93xx SPI controller in master
> + ? ? ? ? mode. This driver supports EP9301, EP9302, EP9307, EP9312 and EP9315
> + ? ? ? ? chips.
> +
> + ? ? ? ? To compile this driver as a module, choose M here. The module will be
> + ? ? ? ? called ep93xx_spi.
> +
> ?config SPI_GPIO
> ? ? ? ?tristate "GPIO-based bitbanging SPI Master"
> ? ? ? ?depends on GENERIC_GPIO
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index d7d0f89..377f845 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_SPI_DAVINCI) ? ? ? ? ? ? += davinci_spi.o
> ?obj-$(CONFIG_SPI_DESIGNWARE) ? ? ? ? ? += dw_spi.o
> ?obj-$(CONFIG_SPI_DW_PCI) ? ? ? ? ? ? ? += dw_spi_pci.o
> ?obj-$(CONFIG_SPI_DW_MMIO) ? ? ? ? ? ? ?+= dw_spi_mmio.o
> +obj-$(CONFIG_SPI_EP93XX) ? ? ? ? ? ? ? += ep93xx_spi.o
> ?obj-$(CONFIG_SPI_GPIO) ? ? ? ? ? ? ? ? += spi_gpio.o
> ?obj-$(CONFIG_SPI_IMX) ? ? ? ? ? ? ? ? ?+= spi_imx.o
> ?obj-$(CONFIG_SPI_LM70_LLP) ? ? ? ? ? ? += spi_lm70llp.o
> diff --git a/drivers/spi/ep93xx_spi.c b/drivers/spi/ep93xx_spi.c
> new file mode 100644
> index 0000000..7273611
> --- /dev/null
> +++ b/drivers/spi/ep93xx_spi.c
> @@ -0,0 +1,1113 @@
> +/*
> + * Driver for Cirrus Logic EP93xx SPI controller.
> + *
> + * Copyright (c) 2010 Mika Westerberg
> + *
> + * Explicit FIFO handling code was inspired by amba-pl022 driver.
> + *
> + * For more information about the SPI controller see documentation on Cirrus
> + * Logic web site:
> + * ? ? http://www.cirrus.com/en/pubs/manual/EP93xx_Users_Guide_UM1.pdf
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/bitops.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/workqueue.h>
> +#include <linux/sched.h>
> +#include <linux/spi/spi.h>
> +
> +#include <mach/ep93xx_spi.h>
> +
> +#define SSPCR0 ? ? ? ? ? ? ? ? 0x0000
> +#define SSPCR0_MODE_SHIFT ? ? ?6
> +#define SSPCR0_SCR_SHIFT ? ? ? 8
> +
> +#define SSPCR1 ? ? ? ? ? ? ? ? 0x0004
> +#define SSPCR1_RIE ? ? ? ? ? ? BIT(0)
> +#define SSPCR1_TIE ? ? ? ? ? ? BIT(1)
> +#define SSPCR1_RORIE ? ? ? ? ? BIT(2)
> +#define SSPCR1_LBM ? ? ? ? ? ? BIT(3)
> +#define SSPCR1_SSE ? ? ? ? ? ? BIT(4)
> +#define SSPCR1_MS ? ? ? ? ? ? ?BIT(5)
> +#define SSPCR1_SOD ? ? ? ? ? ? BIT(6)
> +
> +#define SSPDR ? ? ? ? ? ? ? ? ?0x0008
> +
> +#define SSPSR ? ? ? ? ? ? ? ? ?0x000c
> +#define SSPSR_TFE ? ? ? ? ? ? ?BIT(0)
> +#define SSPSR_TNF ? ? ? ? ? ? ?BIT(1)
> +#define SSPSR_RNE ? ? ? ? ? ? ?BIT(2)
> +#define SSPSR_RFF ? ? ? ? ? ? ?BIT(3)
> +#define SSPSR_BSY ? ? ? ? ? ? ?BIT(4)
> +#define SSPCPSR ? ? ? ? ? ? ? ? ? ? ? ?0x0010
> +
> +#define SSPIIR ? ? ? ? ? ? ? ? 0x0014
> +#define SSPIIR_RIS ? ? ? ? ? ? BIT(0)
> +#define SSPIIR_TIS ? ? ? ? ? ? BIT(1)
> +#define SSPIIR_RORIS ? ? ? ? ? BIT(2)
> +#define SSPICR ? ? ? ? ? ? ? ? SSPIIR
> +
> +/* timeout in milliseconds */
> +#define SPI_TIMEOUT ? ? ? ? ? ?100
> +/* maximum depth of RX/TX FIFO */
> +#define SPI_FIFO_SIZE ? ? ? ? ?8
> +
> +enum {
> + ? ? ? EP93XX_SPI_METHOD_POLL,
> + ? ? ? EP93XX_SPI_METHOD_INTERRUPT,
> + ? ? ? /* TODO: waiting for DMA support */
> +};
> +
> +static int transfer_method = EP93XX_SPI_METHOD_INTERRUPT;
> +module_param(transfer_method, int, S_IRUGO);
> +MODULE_PARM_DESC(transfer_method,
> + ? ? ? "Used transfer method (0=poll, 1=interrupt [default])");

Should this really be a module parameter?  Would it be better to
expose this knob as part of pdata or in sysfs?  (Assuming there even
is a real need to manipulate this control)

> +
> +/**
> + * struct ep93xx_spi - EP93xx SPI controller structure
> + * @lock: spinlock that protects concurrent accesses to fields @running,
> + * ? ? ? ?@current_msg and @msg_queue
> + * @pdev: pointer to platform device
> + * @info: platform specific info
> + * @clk: clock for the controller
> + * @regs_base: pointer to ioremap()'d registers
> + * @irq: IRQ number used by the driver. If @irq is %0, we are in polled mode.
> + * @min_rate: minimum clock rate (in Hz) supported by the controller
> + * @max_rate: maximum clock rate (in Hz) supported by the controller
> + * @running: is the queue running
> + * @msg_queue: queue for the messages
> + * @wq: workqueue used by the driver
> + * @msg_work: work that is queued for the driver
> + * @wait: wait here until given transfer is completed
> + * @current_msg: message that is currently processed (or %NULL if none)
> + * @spi_dev: pointer to device that was previously selected
> + * @tx: current byte in transfer to transmit
> + * @rx: current byte in transfer to receive
> + * @fifo_level: how full is FIFO (%0..%SPI_FIFO_SIZE - %1). Receiving one
> + * ? ? ? ? ? ? ?frame decreases this level and sending one frame increases it.
> + * @transfer: method that performs the actual data transfer
> + *
> + * This structure holds EP93xx SPI controller specific information. When
> + * @running is %true, driver accepts transfer requests from protocol drivers.
> + * @current_msg is used to hold pointer to the message that is currently
> + * processed. If @current_msg is %NULL, it means that no processing is going
> + * on.
> + *
> + * Most of the fields are only written once and they can be accessed without
> + * taking the @lock. Fields that are accessed concurrently are: @current_msg,
> + * @running and @msg_queue.
> + */
> +struct ep93xx_spi {
> + ? ? ? spinlock_t ? ? ? ? ? ? ? ? ? ? ?lock;
> + ? ? ? const struct platform_device ? ?*pdev;
> + ? ? ? const struct ep93xx_spi_info ? ?*info;

You probably don't need to keep the info pointer around.  It isn't
interesting once you've extracted the data out of it.

> + ? ? ? struct clk ? ? ? ? ? ? ? ? ? ? ?*clk;
> + ? ? ? void __iomem ? ? ? ? ? ? ? ? ? ?*regs_base;
> + ? ? ? int ? ? ? ? ? ? ? ? ? ? ? ? ? ? irq;
> + ? ? ? unsigned long ? ? ? ? ? ? ? ? ? min_rate;
> + ? ? ? unsigned long ? ? ? ? ? ? ? ? ? max_rate;
> + ? ? ? bool ? ? ? ? ? ? ? ? ? ? ? ? ? ?running;
> + ? ? ? struct workqueue_struct ? ? ? ? *wq;
> + ? ? ? struct work_struct ? ? ? ? ? ? ?msg_work;
> + ? ? ? struct completion ? ? ? ? ? ? ? wait;
> + ? ? ? struct list_head ? ? ? ? ? ? ? ?msg_queue;
> + ? ? ? struct spi_message ? ? ? ? ? ? ?*current_msg;
> + ? ? ? size_t ? ? ? ? ? ? ? ? ? ? ? ? ?tx;
> + ? ? ? size_t ? ? ? ? ? ? ? ? ? ? ? ? ?rx;
> + ? ? ? size_t ? ? ? ? ? ? ? ? ? ? ? ? ?fifo_level;
> + ? ? ? void ? ? ? ? ? ? ? ? ? ? ? ? ? ?(*transfer)(struct ep93xx_spi *);
> +};
> +
> +/**
> + * struct ep93xx_spi_chip - SPI device hardware settings
> + * @rate: max rate in hz this chip supports
> + * @div_cpsr: cpsr (pre-scaler) divider
> + * @div_scr: scr divider
> + * @dss: bits per word (4 - 16 bits)
> + * @mode: chip SPI mode (see also &struct spi_device)
> + *
> + * This structure is used to store hardware register specific settings for each
> + * SPI device. Settings are written to hardware by function
> + * ep93xx_spi_chip_setup().
> + */
> +struct ep93xx_spi_chip {
> + ? ? ? unsigned long ? rate;
> + ? ? ? u8 ? ? ? ? ? ? ?div_cpsr;
> + ? ? ? u8 ? ? ? ? ? ? ?div_scr;
> + ? ? ? u8 ? ? ? ? ? ? ?dss;
> + ? ? ? u8 ? ? ? ? ? ? ?mode;
> +};
> +
> +/* converts bits per word to CR0.DSS value */
> +#define bits_per_word_to_dss(bpw) ? ? ?((bpw) - 1)
> +
> +static inline void
> +ep93xx_spi_write_u8(const struct ep93xx_spi *espi, u16 reg, u8 value)
> +{
> + ? ? ? __raw_writeb(value, espi->regs_base + reg);
> +}
> +
> +static inline u8
> +ep93xx_spi_read_u8(const struct ep93xx_spi *spi, u16 reg)
> +{
> + ? ? ? return __raw_readb(spi->regs_base + reg);
> +}
> +
> +static inline void
> +ep93xx_spi_write_u16(const struct ep93xx_spi *espi, u16 reg, u16 value)
> +{
> + ? ? ? __raw_writew(value, espi->regs_base + reg);
> +}
> +
> +static inline u16
> +ep93xx_spi_read_u16(const struct ep93xx_spi *spi, u16 reg)
> +{
> + ? ? ? return __raw_readw(spi->regs_base + reg);
> +}
> +
> +/**
> + * ep93xx_spi_enable() - enables the SPI controller and clock
> + * @espi: ep93xx SPI controller struct
> + *
> + * This function enables the SPI controller and its clock. Returns %0 in case
> + * of success and negative error in case if failure.
> + */
> +static int ep93xx_spi_enable(const struct ep93xx_spi *espi)
> +{
> + ? ? ? u8 regval;
> + ? ? ? int err;
> +
> + ? ? ? err = clk_enable(espi->clk);
> + ? ? ? if (err)
> + ? ? ? ? ? ? ? return err;
> +
> + ? ? ? regval = ep93xx_spi_read_u8(espi, SSPCR1);
> + ? ? ? regval |= SSPCR1_SSE;
> + ? ? ? ep93xx_spi_write_u8(espi, SSPCR1, regval);
> +
> + ? ? ? return 0;
> +}
> +
> +/**
> + * ep93xx_spi_disable() - disables the SPI controller and clock
> + * @espi: ep93xx SPI controller struct
> + *
> + * Function disables SPI controller and its clock.
> + */
> +static void ep93xx_spi_disable(const struct ep93xx_spi *espi)
> +{
> + ? ? ? u8 regval;
> +
> + ? ? ? regval = ep93xx_spi_read_u8(espi, SSPCR1);
> + ? ? ? regval &= ~SSPCR1_SSE;
> + ? ? ? ep93xx_spi_write_u8(espi, SSPCR1, regval);
> +
> + ? ? ? clk_disable(espi->clk);
> +}
> +
> +/**
> + * ep93xx_spi_enable_interrupts() - enables all SPI interrupts
> + * @espi: ep93xx SPI controller struct
> + *
> + * Enables all SPI interrupts: receive overrun (ROR), transmit and receive.
> + */
> +static inline void
> +ep93xx_spi_enable_interrupts(const struct ep93xx_spi *espi)
> +{
> + ? ? ? u8 regval;
> +
> + ? ? ? regval = ep93xx_spi_read_u8(espi, SSPCR1);
> + ? ? ? regval |= (SSPCR1_RORIE | SSPCR1_TIE | SSPCR1_RIE);
> + ? ? ? ep93xx_spi_write_u8(espi, SSPCR1, regval);
> +}
> +
> +/**
> + * ep93xx_spi_disable_interrupts() - disables all SPI interrupts
> + * @espi: ep93xx SPI controller struct
> + *
> + * Disables all SPI interrupts.
> + */
> +static inline void
> +ep93xx_spi_disable_interrupts(const struct ep93xx_spi *espi)
> +{
> + ? ? ? u8 regval;
> +
> + ? ? ? regval = ep93xx_spi_read_u8(espi, SSPCR1);
> + ? ? ? regval &= ~(SSPCR1_RORIE | SSPCR1_TIE | SSPCR1_RIE);
> + ? ? ? ep93xx_spi_write_u8(espi, SSPCR1, regval);
> +}
> +
> +/**
> + * ep93xx_spi_flush() - flushes SPI RX FIFO
> + * @espi: ep93xx SPI controller struct
> + * @msecs: timeout in milliseconds to wait
> + *
> + * This function flushes RX FIFO. Returns %0 in case of success and %-ETIMEDOUT
> + * when timeout occured. Wait is implemented in busylooping so this function can
> + * also be called from atomic context.
> + */
> +static int ep93xx_spi_flush(const struct ep93xx_spi *espi, unsigned long msecs)
> +{
> + ? ? ? unsigned long timeout = jiffies + msecs_to_jiffies(msecs);
> +
> + ? ? ? while (ep93xx_spi_read_u16(espi, SSPSR) & SSPSR_RNE) {
> + ? ? ? ? ? ? ? if (time_after(jiffies, timeout))
> + ? ? ? ? ? ? ? ? ? ? ? return -ETIMEDOUT;

Ouch.  With the current code the driver could busy wait for 100ms!  If
flushing takes time, then don't busywait.  Bail out to some form of
deferred work.  Let the kernel get on with something else.

> +
> + ? ? ? ? ? ? ? ep93xx_spi_read_u16(espi, SSPDR);
> + ? ? ? }
> +
> + ? ? ? return 0;
> +}

This function is only called in one place; should it just be made a
part of ep93xx_spi_process_message?

> +
> +/**
> + * ep93xx_spi_calc_divisors() - calculates SPI clock divisors
> + * @espi: ep93xx SPI controller struct
> + * @chip: divisors are calculated for this chip
> + * @rate: desired SPI output clock rate
> + *
> + * Function calculates cpsr (clock pre-scaler) and scr divisors based on
> + * given @rate and places them to @chip->div_cpsr and @chip->div_scr. If,
> + * for some reason, divisors cannot be calculated nothing is stored and
> + * %-EINVAL is returned.
> + */
> +static int ep93xx_spi_calc_divisors(const struct ep93xx_spi *espi,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct ep93xx_spi_chip *chip,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned long rate)
> +{
> + ? ? ? unsigned long spi_clk_rate = clk_get_rate(espi->clk);
> + ? ? ? int cpsr, scr;
> +
> + ? ? ? /*
> + ? ? ? ?* Make sure that max value is between values supported by the
> + ? ? ? ?* controller. Note that minimum value is already checked in
> + ? ? ? ?* ep93xx_spi_transfer().
> + ? ? ? ?*/
> + ? ? ? rate = clamp(rate, espi->min_rate, espi->max_rate);
> +
> + ? ? ? /*
> + ? ? ? ?* Calculate divisors so that we can get speed according the
> + ? ? ? ?* following formula:
> + ? ? ? ?* ? ? ?rate = spi_clock_rate / (cpsr * (1 + scr))
> + ? ? ? ?*
> + ? ? ? ?* cpsr must be even number and starts from 2, scr can be any number
> + ? ? ? ?* between 0 and 255.
> + ? ? ? ?*/
> + ? ? ? for (cpsr = 2; cpsr <= 254; cpsr += 2) {
> + ? ? ? ? ? ? ? for (scr = 0; scr <= 255; scr++) {

Non-deterministic.  Big nested loops mean a lot of calculations within
 ep93xx_spi_process_transfer, and calculated values aren't cached if
they get replaced.  If you can, it would be better if you can
algebraically calculate the factors instead of an iterative loop.
It's requires more thinking@the outset, but it is worth the effort.

> + ? ? ? ? ? ? ? ? ? ? ? if ((spi_clk_rate / (cpsr * (scr + 1))) <= rate) {
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? chip->div_scr = (u8)scr;
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? chip->div_cpsr = (u8)cpsr;
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? return 0;
> + ? ? ? ? ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? }
> + ? ? ? }
> +
> + ? ? ? return -EINVAL;
> +}
> +
> +/**
> + * ep93xx_spi_select_device() - select given SPI device
> + * @espi: ep93xx SPI controller struct
> + * @spi: SPI device to select
> + *
> + * Function asserts GPIO chipselect line as specified in @spi->chip_select in
> + * board specific manner (calls @info->cs_control()).
> + *
> + * Note that this function is called from a thread context and can sleep.
> + */
> +static void ep93xx_spi_select_device(const struct ep93xx_spi *espi,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct spi_device *spi)
> +{
> + ? ? ? const struct ep93xx_spi_info *info = espi->info;
> + ? ? ? unsigned value = (spi->mode & SPI_CS_HIGH) ? 1 : 0;
> +
> + ? ? ? info->cs_control(spi->chip_select, value, info->data);
> +}
> +
> +/**
> + * ep93xx_spi_deselect_device() - deselects given SPI device
> + * @espi: ep93xx SPI controller struct
> + * @spi: SPI device to deselect
> + *
> + * Function deasserts GPIO chipselect line as specified in @spi->chip_select in
> + * board specific manner (calls @info->cs_control()).
> + *
> + * Note that this function is called from a thread context and can sleep.
> + */
> +static void ep93xx_spi_deselect_device(const struct ep93xx_spi *espi,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct spi_device *spi)
> +{
> + ? ? ? const struct ep93xx_spi_info *info = espi->info;
> + ? ? ? unsigned value = (spi->mode & SPI_CS_HIGH) ? 0 : 1;
> +
> + ? ? ? info->cs_control(spi->chip_select, value, info->data);
> +}

These 2 functions are identical, other than the test being reversed.
The code can be a lot more concise here.

> +
> +/**
> + * ep93xx_spi_setup() - setup an SPI device
> + * @spi: SPI device to setup
> + *
> + * This function sets up SPI device mode, speed etc. Can be called multiple
> + * times for a single device. Returns %0 in case of success, negative error in
> + * case of failure. When this function returns success, the device is
> + * deselected.
> + */
> +static int ep93xx_spi_setup(struct spi_device *spi)
> +{
> + ? ? ? struct ep93xx_spi *espi = spi_master_get_devdata(spi->master);
> + ? ? ? struct ep93xx_spi_chip *chip;
> +
> + ? ? ? if (spi->bits_per_word < 4 || spi->bits_per_word > 16) {
> + ? ? ? ? ? ? ? dev_err(&espi->pdev->dev, "invalid bits per word %d\n",
> + ? ? ? ? ? ? ? ? ? ? ? spi->bits_per_word);
> + ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? }
> +
> + ? ? ? chip = spi_get_ctldata(spi);
> + ? ? ? if (!chip) {
> + ? ? ? ? ? ? ? chip = kzalloc(sizeof(*chip), GFP_KERNEL);
> + ? ? ? ? ? ? ? if (!chip)
> + ? ? ? ? ? ? ? ? ? ? ? return -ENOMEM;
> +
> + ? ? ? ? ? ? ? spi_set_ctldata(spi, chip);
> + ? ? ? }
> +
> + ? ? ? if (spi->max_speed_hz != chip->rate) {
> + ? ? ? ? ? ? ? int err;
> +
> + ? ? ? ? ? ? ? err = ep93xx_spi_calc_divisors(espi, chip, spi->max_speed_hz);
> + ? ? ? ? ? ? ? if (err != 0) {
> + ? ? ? ? ? ? ? ? ? ? ? spi_set_ctldata(spi, NULL);
> + ? ? ? ? ? ? ? ? ? ? ? kfree(chip);
> + ? ? ? ? ? ? ? ? ? ? ? return err;
> + ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? chip->rate = spi->max_speed_hz;
> + ? ? ? }
> +
> + ? ? ? chip->mode = spi->mode;
> + ? ? ? chip->dss = bits_per_word_to_dss(spi->bits_per_word);

Why is mode and dss getting copied into chip?  chip should probable
instead have a reference back to its assigned spi device and the
original values should be used.

> +
> + ? ? ? ep93xx_spi_deselect_device(espi, spi);
> + ? ? ? return 0;
> +}
> +
> +/**
> + * ep93xx_spi_transfer() - queue message to be transferred
> + * @spi: target SPI device
> + * @msg: message to be transferred
> + *
> + * This function is called by SPI device drivers when they are going to transfer
> + * a new message. It simply puts the message in the queue and schedules
> + * workqueue to perform the actual transfer later on.
> + *
> + * Returns %0 on success and negative error in case of failure.
> + */
> +static int ep93xx_spi_transfer(struct spi_device *spi, struct spi_message *msg)
> +{
> + ? ? ? struct ep93xx_spi *espi = spi_master_get_devdata(spi->master);
> + ? ? ? struct spi_transfer *t;
> + ? ? ? unsigned long flags;
> +
> + ? ? ? if (!msg || !msg->complete)
> + ? ? ? ? ? ? ? return -EINVAL;
> +
> + ? ? ? spin_lock_irqsave(&espi->lock, flags);
> + ? ? ? if (!espi->running) {
> + ? ? ? ? ? ? ? spin_unlock_irqrestore(&espi->lock, flags);
> + ? ? ? ? ? ? ? return -ESHUTDOWN;
> + ? ? ? }
> + ? ? ? spin_unlock_irqrestore(&espi->lock, flags);

The spin lock isn't protecting anything here.  The value of running
can change either immediately before or immediately after the critical
region.  Reading espi->running without the spinlock will have exactly
the same behaviour.

If the value of running matters when processing this function, then
the function needs to continue to hold the spin lock while the message
is being processed and then added to the message queue at the end of
the function.

However, the for_each_entry loop below is safe to process before
grabbing the lock, so you can defer grabbing the lock and checking
->running until just before the message is enqueued.

> +
> + ? ? ? /* first validate each transfer */
> + ? ? ? list_for_each_entry(t, &msg->transfers, transfer_list) {
> + ? ? ? ? ? ? ? if (t->bits_per_word) {
> + ? ? ? ? ? ? ? ? ? ? ? if (t->bits_per_word < 4 || t->bits_per_word > 16)
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? if (t->speed_hz && t->speed_hz < espi->min_rate)
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? }
> +
> + ? ? ? /*
> + ? ? ? ?* Now that we own the message, let's initialize it so that it is
> + ? ? ? ?* suitable for us. We use @msg->status to signal whether there was
> + ? ? ? ?* error in transfer and @msg->state is used to hold pointer to the
> + ? ? ? ?* current transfer (or %NULL if no active current transfer).
> + ? ? ? ?*/
> + ? ? ? msg->state = NULL;
> + ? ? ? msg->status = 0;
> + ? ? ? msg->actual_length = 0;
> +
> + ? ? ? spin_lock_irqsave(&espi->lock, flags);
> + ? ? ? list_add_tail(&msg->queue, &espi->msg_queue);
> + ? ? ? queue_work(espi->wq, &espi->msg_work);
> + ? ? ? spin_unlock_irqrestore(&espi->lock, flags);
> +
> + ? ? ? return 0;
> +}
> +
> +/**
> + * ep93xx_spi_cleanup() - cleans up master controller specific state
> + * @spi: SPI device to cleanup
> + *
> + * This function releases master controller specific state for given @spi
> + * device.
> + */
> +static void ep93xx_spi_cleanup(struct spi_device *spi)
> +{
> + ? ? ? struct ep93xx_spi_chip *chip;
> +
> + ? ? ? chip = spi_get_ctldata(spi);
> + ? ? ? if (chip) {
> + ? ? ? ? ? ? ? spi_set_ctldata(spi, NULL);
> + ? ? ? ? ? ? ? kfree(chip);
> + ? ? ? }
> +}
> +
> +/**
> + * ep93xx_spi_chip_setup() - configures hardware according to given @chip
> + * @espi: ep93xx SPI controller struct
> + * @chip: chip specific settings
> + *
> + * This function sets up the actual hardware registers with settings given in
> + * @chip. Note that no validation is done so make sure that callers validate
> + * settings before calling this.
> + */
> +static void ep93xx_spi_chip_setup(const struct ep93xx_spi *espi,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? const struct ep93xx_spi_chip *chip)
> +{
> + ? ? ? u16 cr0;
> +
> + ? ? ? cr0 = chip->div_scr << SSPCR0_SCR_SHIFT;
> + ? ? ? cr0 |= (chip->mode & (SPI_CPHA | SPI_CPOL)) << SSPCR0_MODE_SHIFT;
> + ? ? ? cr0 |= chip->dss;
> +
> + ? ? ? dev_dbg(&espi->pdev->dev, "setup: mode %d, cpsr %d, scr %d, dss %d\n",
> + ? ? ? ? ? ? ? chip->mode, chip->div_cpsr, chip->div_scr, chip->dss);
> + ? ? ? dev_dbg(&espi->pdev->dev, "setup: cr0 %#x", cr0);
> +
> + ? ? ? ep93xx_spi_write_u8(espi, SSPCPSR, chip->div_cpsr);
> + ? ? ? ep93xx_spi_write_u16(espi, SSPCR0, cr0);
> +}
> +
> +static void u8_writer(struct ep93xx_spi *espi,
> + ? ? ? ? ? ? ? ? ? ? const struct spi_transfer *t)
> +{
> + ? ? ? u8 tx_val = 0;
> +
> + ? ? ? if (t->tx_buf)
> + ? ? ? ? ? ? ? tx_val = ((u8 *)t->tx_buf)[espi->tx];
> + ? ? ? ep93xx_spi_write_u8(espi, SSPDR, tx_val);
> + ? ? ? espi->tx += sizeof(tx_val);
> +}
> +
> +static void u8_reader(struct ep93xx_spi *espi,
> + ? ? ? ? ? ? ? ? ? ? struct spi_transfer *t)
> +{
> + ? ? ? u8 rx_val;
> +
> + ? ? ? rx_val = ep93xx_spi_read_u8(espi, SSPDR);
> + ? ? ? if (t->rx_buf)
> + ? ? ? ? ? ? ? ((u8 *)t->rx_buf)[espi->rx] = rx_val;
> + ? ? ? espi->rx += sizeof(rx_val);
> +}
> +
> +static void u16_writer(struct ep93xx_spi *espi,
> + ? ? ? ? ? ? ? ? ? ? ?const struct spi_transfer *t)
> +{
> + ? ? ? u16 tx_val = 0;
> +
> + ? ? ? if (t->tx_buf)
> + ? ? ? ? ? ? ? tx_val = ((u16 *)t->tx_buf)[espi->tx];
> + ? ? ? ep93xx_spi_write_u16(espi, SSPDR, tx_val);
> + ? ? ? espi->tx += sizeof(tx_val);
> +}
> +
> +static void u16_reader(struct ep93xx_spi *espi,
> + ? ? ? ? ? ? ? ? ? ? ?struct spi_transfer *t)
> +{
> + ? ? ? u16 rx_val;
> +
> + ? ? ? rx_val = ep93xx_spi_read_u16(espi, SSPDR);
> + ? ? ? if (t->rx_buf)
> + ? ? ? ? ? ? ? ((u16 *)t->rx_buf)[espi->rx] = rx_val;
> + ? ? ? espi->rx += sizeof(rx_val);
> +}

These 4 functions are only used once each.  Just merge them into the caller.

> +
> +/**
> + * bits_per_word() - returns bits per word for current message
> + */
> +static inline int bits_per_word(const struct ep93xx_spi *espi)
> +{
> + ? ? ? struct spi_message *msg = espi->current_msg;
> + ? ? ? struct spi_transfer *t = msg->state;
> +
> + ? ? ? return t->bits_per_word ? t->bits_per_word : msg->spi->bits_per_word;
> +}
> +
> +static void ep93xx_do_write(struct ep93xx_spi *espi,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? struct spi_transfer *t)
> +{
> + ? ? ? if (bits_per_word(espi) > 8)
> + ? ? ? ? ? ? ? u16_writer(espi, t);
> + ? ? ? else
> + ? ? ? ? ? ? ? u8_writer(espi, t);
> +}
> +
> +static void ep93xx_do_read(struct ep93xx_spi *espi,
> + ? ? ? ? ? ? ? ? ? ? ? ? ?struct spi_transfer *t)
> +{
> + ? ? ? if (bits_per_word(espi) > 8)
> + ? ? ? ? ? ? ? u16_reader(espi, t);
> + ? ? ? else
> + ? ? ? ? ? ? ? u8_reader(espi, t);
> +}
> +
> +/**
> + * ep93xx_spi_read_write() - perform next RX/TX transfer
> + * @espi: ep93xx SPI controller struct
> + *
> + * This function transfers next bytes (or words) to/from RX/TX FIFOs. If called
> + * several times, the whole transfer will be completed. Returns %0 when current
> + * transfer was not yet completed otherwise length of the transfer (>%0). When
> + * this function is finished, RX FIFO should be empty and TX FIFO should be
> + * full.
> + *
> + * Can be called from any context.
> + */
> +static int ep93xx_spi_read_write(struct ep93xx_spi *espi)
> +{
> + ? ? ? struct spi_message *msg;
> + ? ? ? struct spi_transfer *t;
> + ? ? ? unsigned long flags;
> +
> + ? ? ? spin_lock_irqsave(&espi->lock, flags);
> + ? ? ? msg = espi->current_msg;
> + ? ? ? spin_unlock_irqrestore(&espi->lock, flags);

Again, this spin lock isn't protecting anything.  Plain single reads
can always be considered to be atomic.  Review the locking model, but
I suspect the lock needs to be held over the entire function.

> +
> + ? ? ? t = msg->state;
> +
> + ? ? ? /*
> + ? ? ? ?* We explicitly handle FIFO level here. This way we don't have to check
> + ? ? ? ?* TX FIFO status using %SSPSR_TNF bit which may cause RX FIFO overruns.
> + ? ? ? ?*/
> + ? ? ? if (espi->tx == 0 && espi->rx == 0)
> + ? ? ? ? ? ? ? espi->fifo_level = 0;
> +
> + ? ? ? /* read all received data */
> + ? ? ? while ((ep93xx_spi_read_u8(espi, SSPSR) & SSPSR_RNE) &&
> + ? ? ? ? ? ? ? espi->rx < t->len) {
> + ? ? ? ? ? ? ? ep93xx_do_read(espi, t);
> + ? ? ? ? ? ? ? espi->fifo_level--;
> + ? ? ? }

Another busywait loop.  Could end up burning an awful lot of cycles
here.  A state machine might be more suitable for this driver so that
processing can be punted to deferred work when the FIFO gets either
empty or full.

> +
> + ? ? ? /* write as long as FIFO has room */
> + ? ? ? while (espi->fifo_level < SPI_FIFO_SIZE && espi->tx < t->len) {
> + ? ? ? ? ? ? ? ep93xx_do_write(espi, t);
> + ? ? ? ? ? ? ? espi->fifo_level++;
> + ? ? ? }
> +
> + ? ? ? /* are we done yet? */
> + ? ? ? if (espi->tx == t->len && espi->rx == t->len) {
> + ? ? ? ? ? ? ? msg->actual_length += t->len;
> + ? ? ? ? ? ? ? return t->len;
> + ? ? ? }
> +
> + ? ? ? return 0;
> +}
> +
> +/**
> + * ep93xx_spi_polling_transfer() - implement polling mode transfer
> + * @espi: ep93xx SPI controller struct
> + *
> + * Function performs one polling mode transfer. When this function is finished,
> + * the whole transfer should be completed, or failed in case of error.
> + */
> +static void ep93xx_spi_polling_transfer(struct ep93xx_spi *espi)
> +{
> + ? ? ? while (!ep93xx_spi_read_write(espi))
> + ? ? ? ? ? ? ? cpu_relax();

And if it never finishes?  No exit path on error.

> +}
> +
> +/**
> + * ep93xx_spi_polling_transfer() - implement interrupt based transfer

Comment doesn't match

> + * @espi: ep93xx SPI controller struct
> + *
> + * Function performs one interrupt based transfer. When this function is
> + * finished, the whole transfer should be completed, or failed in case of error.
> + */
> +static void ep93xx_spi_interrupt_transfer(struct ep93xx_spi *espi)
> +{
> + ? ? ? ep93xx_spi_enable_interrupts(espi);
> + ? ? ? wait_for_completion(&espi->wait);
> +}
> +
> +/**
> + * ep93xx_spi_process_transfer() - processes one SPI transfer
> + * @espi: ep93xx SPI controller struct
> + * @msg: current message
> + * @t: transfer to process
> + *
> + * This function processes one SPI transfer given in @t. Function waits until
> + * transfer is complete (may sleep) and updates @msg->status based on whether
> + * transfer was succesfully processed or not.
> + */
> +static void ep93xx_spi_process_transfer(struct ep93xx_spi *espi,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct spi_message *msg,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct spi_transfer *t)
> +{
> + ? ? ? struct ep93xx_spi_chip *chip = spi_get_ctldata(msg->spi);
> +
> + ? ? ? msg->state = t;
> +
> + ? ? ? /*
> + ? ? ? ?* Handle any transfer specific settings if needed. We use
> + ? ? ? ?* temporary chip settings here and restore original later when
> + ? ? ? ?* the transfer is finished.
> + ? ? ? ?*/
> + ? ? ? if (t->speed_hz || t->bits_per_word) {
> + ? ? ? ? ? ? ? struct ep93xx_spi_chip tmp_chip = *chip;
> +
> + ? ? ? ? ? ? ? if (t->speed_hz) {
> + ? ? ? ? ? ? ? ? ? ? ? int err;
> +
> + ? ? ? ? ? ? ? ? ? ? ? err = ep93xx_spi_calc_divisors(espi, &tmp_chip,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?t->speed_hz);
> + ? ? ? ? ? ? ? ? ? ? ? if (err) {
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? dev_err(&espi->pdev->dev,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "failed to adjust speed\n");
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? msg->status = err;
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? return;
> + ? ? ? ? ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? }
> +
> + ? ? ? ? ? ? ? if (t->bits_per_word)
> + ? ? ? ? ? ? ? ? ? ? ? tmp_chip.dss = bits_per_word_to_dss(t->bits_per_word);
> +
> + ? ? ? ? ? ? ? /*
> + ? ? ? ? ? ? ? ?* Set up temporary new hw settings for this transfer.
> + ? ? ? ? ? ? ? ?*/
> + ? ? ? ? ? ? ? ep93xx_spi_chip_setup(espi, &tmp_chip);
> + ? ? ? }
> +
> + ? ? ? espi->rx = 0;
> + ? ? ? espi->tx = 0;
> +
> + ? ? ? /*
> + ? ? ? ?* Now everything is set up for the current transfer. Perform the actual
> + ? ? ? ?* transfer depending on the method.
> + ? ? ? ?*/
> + ? ? ? espi->transfer(espi);
> +
> + ? ? ? /*
> + ? ? ? ?* In case of error during transmit, we bail out from processing
> + ? ? ? ?* the message.
> + ? ? ? ?*/
> + ? ? ? if (msg->status)
> + ? ? ? ? ? ? ? return;
> +
> + ? ? ? /*
> + ? ? ? ?* After this transfer is finished, perform any possible
> + ? ? ? ?* post-transfer actions requested by the protocol driver.
> + ? ? ? ?*/
> + ? ? ? if (t->delay_usecs)
> + ? ? ? ? ? ? ? udelay(t->delay_usecs);

Consider sleeping instead.  busywaits increase latency.

> + ? ? ? if (t->cs_change) {
> + ? ? ? ? ? ? ? /*
> + ? ? ? ? ? ? ? ?* In case protocol driver is asking us to drop the
> + ? ? ? ? ? ? ? ?* chipselect briefly, we let the scheduler to handle
> + ? ? ? ? ? ? ? ?* any "delay" here.
> + ? ? ? ? ? ? ? ?*/
> + ? ? ? ? ? ? ? if (!list_is_last(&t->transfer_list, &msg->transfers)) {
> + ? ? ? ? ? ? ? ? ? ? ? ep93xx_spi_deselect_device(espi, msg->spi);
> + ? ? ? ? ? ? ? ? ? ? ? cond_resched();
> + ? ? ? ? ? ? ? ? ? ? ? ep93xx_spi_select_device(espi, msg->spi);
> + ? ? ? ? ? ? ? }
> + ? ? ? }
> +
> + ? ? ? if (t->speed_hz || t->bits_per_word)
> + ? ? ? ? ? ? ? ep93xx_spi_chip_setup(espi, chip);
> +}
> +
> +/*
> + * ep93xx_spi_process_message() - process one SPI message
> + * @espi: ep93xx SPI controller struct
> + * @msg: message to process
> + *
> + * This function processes a single SPI message. We go through all transfers in
> + * the message and pass them to ep93xx_spi_process_transfer(). Chipselect is
> + * asserted during the whole message (unless per transfer cs_change is set).
> + *
> + * @msg->status contains %0 in case of success or negative error code in case of
> + * failure.
> + */
> +static void ep93xx_spi_process_message(struct ep93xx_spi *espi,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct spi_message *msg)
> +{
> + ? ? ? struct spi_transfer *t;
> + ? ? ? int err;
> +
> + ? ? ? /*
> + ? ? ? ?* Enable the SPI controller and its clock.
> + ? ? ? ?*/
> + ? ? ? err = ep93xx_spi_enable(espi);
> + ? ? ? if (err) {
> + ? ? ? ? ? ? ? dev_err(&espi->pdev->dev, "failed to enable SPI controller\n");
> + ? ? ? ? ? ? ? msg->status = err;
> + ? ? ? ? ? ? ? return;
> + ? ? ? }
> +
> + ? ? ? /*
> + ? ? ? ?* Just to be sure: flush any data from RX FIFO.
> + ? ? ? ?*/
> + ? ? ? err = ep93xx_spi_flush(espi, SPI_TIMEOUT);
> + ? ? ? if (err) {
> + ? ? ? ? ? ? ? dev_warn(&espi->pdev->dev, "timeout while flushing RX fifo\n");
> + ? ? ? ? ? ? ? msg->status = err;
> + ? ? ? ? ? ? ? return;
> + ? ? ? }
> +
> + ? ? ? /*
> + ? ? ? ?* Update SPI controller registers according to spi device and assert
> + ? ? ? ?* the chipselect.
> + ? ? ? ?*/
> + ? ? ? ep93xx_spi_chip_setup(espi, spi_get_ctldata(msg->spi));
> + ? ? ? ep93xx_spi_select_device(espi, msg->spi);
> +
> + ? ? ? list_for_each_entry(t, &msg->transfers, transfer_list) {
> + ? ? ? ? ? ? ? cond_resched();

Why is this necessary?

> + ? ? ? ? ? ? ? ep93xx_spi_process_transfer(espi, msg, t);
> + ? ? ? ? ? ? ? if (msg->status)
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? }
> +
> + ? ? ? /*
> + ? ? ? ?* Now the whole message is transferred (or failed for some reason). We
> + ? ? ? ?* deselect the device and disable the SPI controller.
> + ? ? ? ?*/
> + ? ? ? ep93xx_spi_deselect_device(espi, msg->spi);
> + ? ? ? ep93xx_spi_disable(espi);
> +}
> +
> +#define work_to_espi(work) (container_of((work), struct ep93xx_spi, msg_work))
> +
> +/**
> + * ep93xx_spi_work() - EP93xx SPI workqueue worker function
> + * @work: work struct
> + *
> + * Workqueue worker function. This function is called when there are new
> + * SPI messages to be processed. Message is taken out from the queue and then
> + * passed to ep93xx_spi_process_message().
> + *
> + * After message is transferred, protocol driver is notified by calling
> + * @msg->complete(). In case of error, @msg->status is set to negative error
> + * number, otherwise it contains zero (and @msg->actual_length is updated).
> + */
> +static void ep93xx_spi_work(struct work_struct *work)
> +{
> + ? ? ? struct ep93xx_spi *espi = work_to_espi(work);
> + ? ? ? struct spi_message *msg;
> +
> + ? ? ? spin_lock_irq(&espi->lock);
> + ? ? ? if (!espi->running || espi->current_msg ||
> + ? ? ? ? ? ? ? list_empty(&espi->msg_queue)) {
> + ? ? ? ? ? ? ? spin_unlock_irq(&espi->lock);
> + ? ? ? ? ? ? ? return;
> + ? ? ? }
> + ? ? ? msg = list_first_entry(&espi->msg_queue, struct spi_message, queue);
> + ? ? ? list_del_init(&msg->queue);
> + ? ? ? espi->current_msg = msg;
> + ? ? ? spin_unlock_irq(&espi->lock);

I'm nervous about the locking.  I'm not convinced that it covers all
the important cases.  Are you able to describe what the locks protect,
and why they are taken when they are?  That would help me evaluate
what the driver should be doing.

> +
> + ? ? ? ep93xx_spi_process_message(espi, msg);
> +
> + ? ? ? /*
> + ? ? ? ?* Update the current message and re-schedule ourselves if there are
> + ? ? ? ?* more messages in the queue.
> + ? ? ? ?*/
> + ? ? ? spin_lock_irq(&espi->lock);
> + ? ? ? espi->current_msg = NULL;
> + ? ? ? if (espi->running && !list_empty(&espi->msg_queue))
> + ? ? ? ? ? ? ? queue_work(espi->wq, &espi->msg_work);
> + ? ? ? spin_unlock_irq(&espi->lock);
> +
> + ? ? ? /* notify the protocol driver that we are done with this message */
> + ? ? ? msg->complete(msg->context);
> +}
> +
> +/**
> + * ep93xx_spi_interrupt() - SPI interrupt handler
> + * @irq: IRQ number (not used)
> + * @dev_id: pointer to EP93xx controller struct
> + *
> + * This function handles TX/RX/ROR interrupts that come from the SPI controller.
> + * Returns %IRQ_HANDLED when interrupt was handled and %IRQ_NONE in case the
> + * @irq was not handled.
> + */
> +static irqreturn_t ep93xx_spi_interrupt(int irq, void *dev_id)
> +{
> + ? ? ? struct ep93xx_spi *espi = dev_id;
> + ? ? ? u8 irq_status;
> +
> + ? ? ? irq_status = ep93xx_spi_read_u8(espi, SSPIIR);
> +
> + ? ? ? if (!(irq_status & (SSPIIR_RORIS | SSPIIR_TIS | SSPIIR_RIS)))
> + ? ? ? ? ? ? ? return IRQ_NONE; /* not for us */
> +
> + ? ? ? /* clear the interrupt */
> + ? ? ? ep93xx_spi_write_u8(espi, SSPICR, 0);
> +
> + ? ? ? /*
> + ? ? ? ?* If we got ROR (receive overrun) interrupt we know that something is
> + ? ? ? ?* wrong. Just abort the message.
> + ? ? ? ?*/
> + ? ? ? if (unlikely(irq_status & SSPIIR_RORIS)) {
> + ? ? ? ? ? ? ? dev_warn(&espi->pdev->dev,
> + ? ? ? ? ? ? ? ? ? ? ? ?"receive overrun, aborting the message\n");
> +
> + ? ? ? ? ? ? ? spin_lock(&espi->lock);
> + ? ? ? ? ? ? ? espi->current_msg->status = -EIO;
> + ? ? ? ? ? ? ? spin_unlock(&espi->lock);
> + ? ? ? } else {
> + ? ? ? ? ? ? ? /*
> + ? ? ? ? ? ? ? ?* Interrupt is either RX (RIS) or TX (TIS). For both cases we
> + ? ? ? ? ? ? ? ?* simply execute next data transfer.
> + ? ? ? ? ? ? ? ?*/
> + ? ? ? ? ? ? ? if (!ep93xx_spi_read_write(espi)) {
> + ? ? ? ? ? ? ? ? ? ? ? /*
> + ? ? ? ? ? ? ? ? ? ? ? ?* In normal case, there still is some processing left
> + ? ? ? ? ? ? ? ? ? ? ? ?* for current transfer. Let's wait for the next
> + ? ? ? ? ? ? ? ? ? ? ? ?* interrupt then.
> + ? ? ? ? ? ? ? ? ? ? ? ?*/
> + ? ? ? ? ? ? ? ? ? ? ? return IRQ_HANDLED;
> + ? ? ? ? ? ? ? }
> + ? ? ? }
> +
> + ? ? ? /*
> + ? ? ? ?* Current transfer is finished, either with error or with success. In
> + ? ? ? ?* any case we disable interrupts and notify the worker to handle
> + ? ? ? ?* any post-processing of the message.
> + ? ? ? ?*/
> + ? ? ? ep93xx_spi_disable_interrupts(espi);
> + ? ? ? complete(&espi->wait);
> + ? ? ? return IRQ_HANDLED;
> +}
> +
> +static int __init ep93xx_spi_probe(struct platform_device *pdev)
> +{
> + ? ? ? struct spi_master *master;
> + ? ? ? struct ep93xx_spi_info *info;
> + ? ? ? struct ep93xx_spi *espi;
> + ? ? ? struct resource *res;
> + ? ? ? int error;
> +
> + ? ? ? info = pdev->dev.platform_data;
> +
> + ? ? ? master = spi_alloc_master(&pdev->dev, sizeof(*espi));
> + ? ? ? if (!master) {
> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "failed to allocate spi master\n");
> + ? ? ? ? ? ? ? return -ENOMEM;
> + ? ? ? }
> +
> + ? ? ? master->setup = ep93xx_spi_setup;
> + ? ? ? master->transfer = ep93xx_spi_transfer;
> + ? ? ? master->cleanup = ep93xx_spi_cleanup;
> + ? ? ? master->bus_num = 0;
> + ? ? ? master->num_chipselect = info->num_chipselect;
> + ? ? ? master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
> +
> + ? ? ? platform_set_drvdata(pdev, master);
> +
> + ? ? ? espi = spi_master_get_devdata(master);
> +
> + ? ? ? espi->clk = clk_get(&pdev->dev, NULL);
> + ? ? ? if (IS_ERR(espi->clk)) {
> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "unable to get spi clock\n");
> + ? ? ? ? ? ? ? error = PTR_ERR(espi->clk);
> + ? ? ? ? ? ? ? goto fail_release_master;
> + ? ? ? }
> +
> + ? ? ? spin_lock_init(&espi->lock);
> + ? ? ? init_completion(&espi->wait);
> +
> + ? ? ? /*
> + ? ? ? ?* Calculate maximum and minimum supported clock rates
> + ? ? ? ?* for the controller.
> + ? ? ? ?*/
> + ? ? ? espi->max_rate = clk_get_rate(espi->clk) / 2;
> + ? ? ? espi->min_rate = clk_get_rate(espi->clk) / (254 * 256);
> + ? ? ? espi->info = info;
> + ? ? ? espi->pdev = pdev;
> +
> + ? ? ? switch (transfer_method) {
> + ? ? ? case EP93XX_SPI_METHOD_POLL:
> + ? ? ? ? ? ? ? espi->transfer = ep93xx_spi_polling_transfer;
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case EP93XX_SPI_METHOD_INTERRUPT:
> + ? ? ? ? ? ? ? espi->transfer = ep93xx_spi_interrupt_transfer;
> + ? ? ? ? ? ? ? espi->irq = platform_get_irq(pdev, 0);
> + ? ? ? ? ? ? ? if (espi->irq < 0) {
> + ? ? ? ? ? ? ? ? ? ? ? error = -EBUSY;
> + ? ? ? ? ? ? ? ? ? ? ? dev_err(&pdev->dev, "failed to get irq resources\n");
> + ? ? ? ? ? ? ? ? ? ? ? goto fail_put_clock;
> + ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? default:
> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "invalid transfer method %d given\n",
> + ? ? ? ? ? ? ? ? ? ? ? transfer_method);
> + ? ? ? ? ? ? ? error = -EINVAL;
> + ? ? ? ? ? ? ? goto fail_put_clock;
> + ? ? ? }
> +
> + ? ? ? res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + ? ? ? if (!res) {
> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "unable to get iomem resource\n");
> + ? ? ? ? ? ? ? error = -ENODEV;
> + ? ? ? ? ? ? ? goto fail_put_clock;
> + ? ? ? }
> +
> + ? ? ? res = request_mem_region(res->start, resource_size(res), pdev->name);
> + ? ? ? if (!res) {
> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "unable to request iomem resources\n");
> + ? ? ? ? ? ? ? error = -EBUSY;
> + ? ? ? ? ? ? ? goto fail_put_clock;
> + ? ? ? }
> +
> + ? ? ? espi->regs_base = ioremap(res->start, resource_size(res));
> + ? ? ? if (!espi->regs_base) {
> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "failed to map resources\n");
> + ? ? ? ? ? ? ? error = -ENODEV;
> + ? ? ? ? ? ? ? goto fail_free_mem;
> + ? ? ? }
> +
> + ? ? ? if (espi->irq) {
> + ? ? ? ? ? ? ? error = request_irq(espi->irq, ep93xx_spi_interrupt, 0,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "ep93xx-spi", espi);
> + ? ? ? ? ? ? ? if (error) {
> + ? ? ? ? ? ? ? ? ? ? ? dev_err(&pdev->dev, "failed to request irq\n");
> + ? ? ? ? ? ? ? ? ? ? ? goto fail_unmap_regs;
> + ? ? ? ? ? ? ? }
> + ? ? ? }
> +
> + ? ? ? espi->wq = create_singlethread_workqueue("ep93xx_spid");
> + ? ? ? if (!espi->wq) {
> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "unable to create workqueue\n");
> + ? ? ? ? ? ? ? goto fail_free_irq;
> + ? ? ? }
> + ? ? ? INIT_WORK(&espi->msg_work, ep93xx_spi_work);
> + ? ? ? INIT_LIST_HEAD(&espi->msg_queue);
> + ? ? ? espi->running = true;
> +
> + ? ? ? /* make sure that the hardware is disabled */
> + ? ? ? ep93xx_spi_write_u8(espi, SSPCR1, 0);
> +
> + ? ? ? error = spi_register_master(master);
> + ? ? ? if (error)
> + ? ? ? ? ? ? ? goto fail_free_queue;
> +
> + ? ? ? dev_info(&pdev->dev, "EP93xx SPI Controller at 0x%08lx\n",
> + ? ? ? ? ? ? ? ?(unsigned long)res->start);
> + ? ? ? if (espi->irq)
> + ? ? ? ? ? ? ? dev_info(&pdev->dev, "using irq %d\n", ?espi->irq);
> +
> + ? ? ? return 0;
> +
> +fail_free_queue:
> + ? ? ? destroy_workqueue(espi->wq);
> +fail_free_irq:
> + ? ? ? if (espi->irq)
> + ? ? ? ? ? ? ? free_irq(espi->irq, espi);
> +fail_unmap_regs:
> + ? ? ? iounmap(espi->regs_base);
> +fail_free_mem:
> + ? ? ? release_mem_region(res->start, resource_size(res));
> +fail_put_clock:
> + ? ? ? clk_put(espi->clk);
> +fail_release_master:
> + ? ? ? spi_master_put(master);
> + ? ? ? platform_set_drvdata(pdev, NULL);
> +
> + ? ? ? return error;
> +}
> +
> +static int __exit ep93xx_spi_remove(struct platform_device *pdev)
> +{
> + ? ? ? struct spi_master *master = platform_get_drvdata(pdev);
> + ? ? ? struct ep93xx_spi *espi = spi_master_get_devdata(master);
> + ? ? ? struct resource *res;
> +
> + ? ? ? spin_lock_irq(&espi->lock);
> + ? ? ? espi->running = false;
> + ? ? ? spin_unlock_irq(&espi->lock);
> +
> + ? ? ? destroy_workqueue(espi->wq);
> +
> + ? ? ? /*
> + ? ? ? ?* Complete remaining messages with %-ESHUTDOWN status.
> + ? ? ? ?*/
> + ? ? ? spin_lock_irq(&espi->lock);
> + ? ? ? while (!list_empty(&espi->msg_queue)) {
> + ? ? ? ? ? ? ? struct spi_message *msg;
> +
> + ? ? ? ? ? ? ? msg = list_first_entry(&espi->msg_queue,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct spi_message, queue);
> + ? ? ? ? ? ? ? list_del_init(&msg->queue);
> + ? ? ? ? ? ? ? msg->status = -ESHUTDOWN;
> + ? ? ? ? ? ? ? spin_unlock_irq(&espi->lock);
> + ? ? ? ? ? ? ? msg->complete(msg->context);
> + ? ? ? ? ? ? ? spin_lock_irq(&espi->lock);
> + ? ? ? }
> + ? ? ? spin_unlock_irq(&espi->lock);
> +
> + ? ? ? if (espi->irq)
> + ? ? ? ? ? ? ? free_irq(espi->irq, espi);
> +
> + ? ? ? iounmap(espi->regs_base);
> + ? ? ? res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + ? ? ? release_mem_region(res->start, resource_size(res));
> + ? ? ? clk_put(espi->clk);
> + ? ? ? platform_set_drvdata(pdev, NULL);
> +
> + ? ? ? spi_unregister_master(master);
> + ? ? ? return 0;
> +}
> +
> +static struct platform_driver ep93xx_spi_driver = {
> + ? ? ? .driver ? ? ? ? = {
> + ? ? ? ? ? ? ? .name ? = "ep93xx-spi",
> + ? ? ? ? ? ? ? .owner ?= THIS_MODULE,
> + ? ? ? },
> + ? ? ? .remove ? ? ? ? = __exit_p(ep93xx_spi_remove),
> +};
> +
> +static int __init ep93xx_spi_init(void)
> +{
> + ? ? ? return platform_driver_probe(&ep93xx_spi_driver, ep93xx_spi_probe);
> +}
> +module_init(ep93xx_spi_init);
> +
> +static void __exit ep93xx_spi_exit(void)
> +{
> + ? ? ? platform_driver_unregister(&ep93xx_spi_driver);
> +}
> +module_exit(ep93xx_spi_exit);
> +
> +MODULE_DESCRIPTION("EP93xx SPI Controller driver");
> +MODULE_AUTHOR("Mika Westerberg <mika.westerberg@iki.fi>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:ep93xx-spi");
> --
> 1.5.6.5
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
