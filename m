From: kevin.wells@nxp.com (Kevin Wells)
Date: Fri, 20 Nov 2009 02:11:28 +0100
Subject: RFC [PATCH 5/9] Added phy3250 platform for the lcp3250
Message-ID: <083DF309106F364B939360100EC290F804F54D560E@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added phy3250 platform for the lcp3250

Signed-off-by: Kevin Wells <kevin.wells@nxp.com>
---
 arch/arm/mach-lpc32xx/phy3250.c |  534 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 534 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-lpc32xx/phy3250.c

diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
new file mode 100644
index 0000000..844c344
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -0,0 +1,534 @@
+/*
+ *  linux/arch/arm/mach-lpc32xx/phy3250.c
+ *
+ *  Copyright (C) 2009 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/tty.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/sysdev.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/dma-mapping.h>
+#include <linux/sysdev.h>
+#include <linux/input.h>
+#include <linux/device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/eeprom.h>
+#include <linux/delay.h>
+#include <linux/leds.h>
+#include <linux/gpio.h>
+#include <linux/mmc/host.h>
+#include <linux/amba/bus.h>
+#include <linux/amba/clcd.h>
+#include <linux/amba/mmci.h>
+#include <linux/amba/pl022.h>
+
+#include <mach/hardware.h>
+#include <asm/setup.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/irq.h>
+#include <asm/mach/irq.h>
+#include <asm/mach/map.h>
+
+#include <mach/platform.h>
+#include <mach/clock.h>
+#include <mach/gpio.h>
+#include "common.h"
+
+/*
+ * Mapped GPIOLIB GPIOs
+ */
+#define SPI0_CS_GPIO   LPC32XX_GPIO(GPIO_P3_GRP, 5)
+#define LCD_POWER_GPIO LPC32XX_GPIO(GPO_P3_GRP, 0)
+#define BKL_POWER_GPIO LPC32XX_GPIO(GPO_P3_GRP, 4)
+#define LED_GPIO       LPC32XX_GPIO(GPO_P3_GRP, 1)
+
+static void phy3250_spi_cs_set(u32 control);
+
+
+#define PHY_HW_VER_VAL 0x000A3250
+#define SEEPROM_READ          0x03
+#define PHY3250_SEEPROM_SIZE  0x8000
+#define PHY3250_SEEPROM_CFGOFS (PHY3250_SEEPROM_SIZE - 0x100)
+
+/*
+ * Structure used to define the hardware for the Phytec board
+ */
+struct phytec_hardware {
+  u32 dramcfg;
+  u32 syscfg;
+  u8  mac[8]; /* Only the first 6 are used */
+  u32 rsvd [5];
+  u32 fieldvval;
+} PHY_HW_T;
+static struct phytec_hardware phyhwdata;
+
+/*
+ * Load board hardware descriptor to get MAC address
+ */
+static void __init phy3250_load_hw_desc(void)
+{
+       u32 tmp, addr, saveclk;
+       int i, len;
+       u8 *p8, cmd [4], in [4];
+       u32 sspiobase = io_p2v(SSP0_BASE);
+
+       saveclk = readl(CLKPWR_SSP_CLK_CTRL(CLKPWR_IOBASE));
+       writel((saveclk | CLKPWR_SSPCTRL_SSPCLK0_EN),
+               CLKPWR_SSP_CLK_CTRL(CLKPWR_IOBASE));
+
+       writel(0, LSSP_ICR(sspiobase));
+       writel((LSSP_ICR_RORIC | LSSP_ICR_RTIC), LSSP_IMSC(sspiobase));
+
+       /* Setup default SPI mode at about 5MHz */
+       writel((LSSP_CR0_DSS(8) | LSSP_CR0_FRF_SPI | LSSP_CR0_CPOL(0) |
+               LSSP_CR0_CPHA(0) | LSSP_CR0_SCR(40)), LSSP_CR0(sspiobase));
+       writel(LSSP_CR1_SSP_ENABLE, LSSP_CR1(sspiobase));
+       writel(LSSP_CPSR_CPDVSR(40), LSSP_CPSR(sspiobase));
+
+       while (readl(LSSP_SR(sspiobase)) & LSSP_SR_RNE)
+               tmp = readl(LSSP_DATA(sspiobase));
+
+       len = sizeof (phyhwdata);
+       p8 = (u8 *) &phyhwdata;
+       addr = PHY3250_SEEPROM_CFGOFS;
+       while (len > 0) {
+               phy3250_spi_cs_set(0);
+
+               /* Issue read command and address for 1 byte */
+               cmd[0] = SEEPROM_READ;
+               cmd[1] = ((addr >> 8) & 0xFF);
+               cmd[2] = ((addr >> 0) & 0xFF);
+               cmd[3] = 0xFF;
+               for (i = 0; i < 4; i++)
+                       writel((u32) cmd [i], LSSP_DATA(sspiobase));
+
+               /* Save 3 null bytes and 1 data byte */
+               i = 0;
+               while (i < 4) {
+                       if (readl(LSSP_SR(sspiobase)) & LSSP_SR_RNE) {
+                               in[i] = (u8) readl(LSSP_DATA(sspiobase));
+                               i++;
+                       }
+               }
+
+               /* Only that last byte matters */
+               *p8 = in [3];
+               p8++;
+               len--;
+               addr++;
+
+               phy3250_spi_cs_set(1);
+       }
+
+       writel(0, LSSP_CR0(sspiobase));
+
+       if (phyhwdata.fieldvval != PHY_HW_VER_VAL)
+               printk(KERN_ERR "Invalid Phytec board descriptor!\n");
+
+       /* Shutdown SSP clock to save power */
+       writel((saveclk & ~CLKPWR_SSPCTRL_SSPCLK0_EN),
+               CLKPWR_SSP_CLK_CTRL(CLKPWR_IOBASE));
+}
+
+/*
+ * AMBA LCD controller
+ */
+static struct clcd_panel conn_lcd_panel = {
+       .mode           = {
+               .name           = "QVGA portrait",
+               .refresh        = 60,
+               .xres           = 240,
+               .yres           = 320,
+               .pixclock       = 191828,
+               .left_margin    = 22,
+               .right_margin   = 11,
+               .upper_margin   = 2,
+               .lower_margin   = 1,
+               .hsync_len      = 5,
+               .vsync_len      = 2,
+               .sync           = 0,
+               .vmode          = FB_VMODE_NONINTERLACED,
+       },
+       .width          = -1,
+       .height         = -1,
+       .tim2           = (TIM2_IVS | TIM2_IHS),
+       .cntl           = (CNTL_BGR | CNTL_LCDTFT | CNTL_LCDVCOMP(1) |
+                               CNTL_LCDBPP16_565),
+       .bpp            = 16,
+};
+#define PANEL_SIZE (3 * SZ_64K)
+
+static int lpc32xx_clcd_setup(struct clcd_fb *fb)
+{
+       dma_addr_t dma;
+
+       fb->fb.screen_base = (void *) NULL;
+#if defined(CONFIG_MACH_LPC32XX_IRAM_FOR_CLCD)
+       if (PANEL_SIZE <= LPC32XX_IRAM_SIZE) {
+               fb->fb.screen_base = (void *) io_p2v(IRAM_BASE);
+               fb->fb.fix.smem_start = (dma_addr_t) IRAM_BASE;
+       }
+#endif
+
+       if (fb->fb.screen_base == NULL) {
+               fb->fb.screen_base = dma_alloc_writecombine(&fb->dev->dev,
+                       PANEL_SIZE, &dma, GFP_KERNEL);
+               fb->fb.fix.smem_start = dma;
+       }
+
+       if (!fb->fb.screen_base) {
+               printk(KERN_ERR "CLCD: unable to map framebuffer\n");
+               return -ENOMEM;
+       }
+
+       fb->fb.fix.smem_len = PANEL_SIZE;
+       fb->panel = &conn_lcd_panel;
+
+       gpio_request(LCD_POWER_GPIO, "LCD power");
+       gpio_direction_output(LCD_POWER_GPIO, 1);
+       gpio_request(BKL_POWER_GPIO, "LCD backlight power");
+       gpio_direction_output(BKL_POWER_GPIO, 1);
+
+       return 0;
+}
+
+static int lpc32xx_clcd_mmap(struct clcd_fb *fb, struct vm_area_struct *vma)
+{
+#if defined(CONFIG_MACH_LPC32XX_IRAM_FOR_CLCD)
+       if (PANEL_SIZE <= LPC32XX_IRAM_SIZE) {
+               vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+               if (remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+                       (vma->vm_end - vma->vm_start), vma->vm_page_prot)) {
+                       return -EAGAIN;
+               }
+
+               return 0;
+       }
+       else
+#endif
+
+       return dma_mmap_writecombine(&fb->dev->dev, vma,
+                                    fb->fb.screen_base,
+                                    fb->fb.fix.smem_start,
+                                    fb->fb.fix.smem_len);
+}
+
+static void lpc32xx_clcd_remove(struct clcd_fb *fb)
+{
+#if defined(CONFIG_MACH_LPC32XX_IRAM_FOR_CLCD)
+       if (PANEL_SIZE > LPC32XX_IRAM_SIZE)
+#endif
+
+       dma_free_writecombine(&fb->dev->dev, fb->fb.fix.smem_len,
+                             fb->fb.screen_base, fb->fb.fix.smem_start);
+}
+
+#if defined (CONFIG_PHY3250_QVGA_PANEL_1307_0)
+#define LCD_BKL_ON     0
+#define LCD_BKL_OFF    1
+#elif defined (CONFIG_PHY3250_QVGA_PANEL_1307_1)
+#define LCD_BKL_ON     1
+#define LCD_BKL_OFF    0
+#endif
+
+static void clcd_disable(struct clcd_fb *fb)
+{
+       gpio_set_value(BKL_POWER_GPIO, LCD_BKL_OFF);
+       gpio_set_value(LCD_POWER_GPIO, 0);
+}
+
+static void clcd_enable(struct clcd_fb *fb)
+{
+       gpio_set_value(BKL_POWER_GPIO, LCD_BKL_ON);
+       gpio_set_value(LCD_POWER_GPIO, 1);
+}
+
+static struct clcd_board lpc32xx_clcd_data = {
+       .name           = "Phytec LCD",
+       .check          = clcdfb_check,
+       .decode         = clcdfb_decode,
+       .disable        = clcd_disable,
+       .enable         = clcd_enable,
+       .setup          = lpc32xx_clcd_setup,
+       .mmap           = lpc32xx_clcd_mmap,
+       .remove         = lpc32xx_clcd_remove,
+};
+
+static struct amba_device clcd_device = {
+       .dev                            = {
+               .coherent_dma_mask      = ~0,
+               .init_name              = "dev:clcd",
+               .platform_data          = &lpc32xx_clcd_data,
+       },
+       .res                            = {
+               .start                  = LCD_BASE,
+               .end                    = (LCD_BASE + SZ_4K - 1),
+               .flags                  = IORESOURCE_MEM,
+       },
+       .dma_mask                       = ~0,
+       .irq                            = {IRQ_LCD, NO_IRQ},
+};
+
+/*
+ * AMBA SSP (SPI)
+ */
+static void phy3250_spi_cs_set(u32 control)
+{
+       gpio_set_value(SPI0_CS_GPIO, (int) control);
+}
+
+static struct pl022_config_chip spi0_chip_info = {
+       .lbm                    = LOOPBACK_DISABLED,
+       .com_mode               = POLLING_TRANSFER,
+       .iface                  = SSP_INTERFACE_MOTOROLA_SPI,
+       .hierarchy              = SSP_SLAVE,
+       .slave_tx_disable       = 0,
+       .endian_tx              = SSP_TX_LSB,
+       .endian_rx              = SSP_RX_LSB,
+       .data_size              = SSP_DATA_BITS_8,
+       .rx_lev_trig            = SSP_RX_8_OR_MORE_ELEM,
+       .tx_lev_trig            = SSP_TX_8_OR_MORE_EMPTY_LOC,
+       .clk_phase              = SSP_CLK_SECOND_EDGE,
+       .clk_pol                = SSP_CLK_POL_IDLE_LOW,
+       .ctrl_len               = SSP_BITS_8,
+       .wait_state             = SSP_MWIRE_WAIT_ZERO,
+       .duplex                 = SSP_MICROWIRE_CHANNEL_FULL_DUPLEX,
+       .cs_control             = phy3250_spi_cs_set,
+};
+
+static struct pl022_ssp_controller lpc32xx_ssp0_data = {
+       .bus_id                 = 0,
+       .num_chipselect         = 1,
+       .enable_dma             = 0
+};
+
+static struct amba_device ssp0_device = {
+       .dev                            = {
+               .coherent_dma_mask      = ~0,
+               .init_name              = "dev:ssp0",
+               .platform_data          = &lpc32xx_ssp0_data,
+       },
+       .res                            = {
+               .start                  = SSP0_BASE,
+               .end                    = (SSP0_BASE + SZ_4K - 1),
+               .flags                  = IORESOURCE_MEM,
+       },
+       .dma_mask                       = ~0,
+       .irq                            = {IRQ_SSP0, NO_IRQ},
+};
+
+/* AT25 driver registration */
+static int __init phy3250_spi_board_register(void)
+{
+#if defined(CONFIG_SPI_SPIDEV) || defined(CONFIG_SPI_SPIDEV_MODULE)
+       struct spi_board_info info[] = {
+               {
+                       .modalias = "spidev",
+                       .max_speed_hz = 5000000,
+                       .bus_num = 0,
+                       .chip_select = 0,
+                       .controller_data = &spi0_chip_info,
+               },
+       };
+
+#else
+       static struct spi_eeprom eeprom = {
+               .name = "at25256a",
+               .byte_len = 0x8000,
+               .page_size = 64,
+               .flags = EE_ADDR2,
+       };
+       struct spi_board_info info[] = {
+               {
+                       .modalias = "at25",
+                       .max_speed_hz = 5000000,
+                       .bus_num = 0,
+                       .chip_select = 0,
+                       .platform_data = &eeprom,
+                       .controller_data = &spi0_chip_info,
+               },
+       };
+#endif
+       return spi_register_board_info(info, ARRAY_SIZE(info));
+}
+arch_initcall(phy3250_spi_board_register);
+
+/*
+ * USB OHCI
+ */
+static u64 ohci_dmamask = ~(u32) 0;
+static struct resource ohci_resources[] = {
+       {
+               .start = IO_ADDRESS(USB_BASE),
+               .end = IO_ADDRESS(USB_BASE + 0x100),
+               .flags = IORESOURCE_MEM,
+       }, {
+               .start = IRQ_USB_HOST,
+               .flags = IORESOURCE_IRQ,
+       },
+};
+
+struct platform_device ohci_device = {
+       .name = "usb-ohci",
+       .id = -1,
+       .dev = {
+               .dma_mask = &ohci_dmamask,
+               .coherent_dma_mask = 0xFFFFFFFF,
+               },
+       .num_resources = ARRAY_SIZE(ohci_resources),
+       .resource = ohci_resources,
+};
+
+static struct i2c_board_info __initdata phy3250_i2c_board_info [] = {
+       {
+               I2C_BOARD_INFO("rtc-pcf8563", 0x51),
+       },
+};
+
+static struct gpio_led phy_leds[] = {
+       {
+               .name                   = "led0",
+               .gpio                   = LED_GPIO,
+               .active_low             = 1,
+               .default_trigger        = "heartbeat",
+       },
+};
+
+static struct gpio_led_platform_data led_data = {
+       .leds = phy_leds,
+       .num_leds = ARRAY_SIZE(phy_leds),
+};
+
+static struct platform_device lpc32xx_gpio_led_device = {
+       .name                   = "leds-gpio",
+       .id                     = -1,
+       .dev.platform_data      = &led_data,
+};
+
+static struct platform_device* phy3250_devs[] __initdata = {
+       &i2c0_device,
+       &i2c2_device,
+       &watchdog_device,
+       &lpc32xx_gpio_led_device,
+};
+
+static struct amba_device *amba_devs[] __initdata = {
+       &clcd_device,
+       &ssp0_device,
+};
+
+/*
+ * Board specific functions
+ */
+static void __init phy3250_board_init(void)
+{
+       u32 tmp;
+       int i;
+
+       /* Setup clocks and gpios before anything else! */
+       clk_init();
+       lpc32xx_gpio_init();
+
+       /* Register GPIOs used on this board */
+       gpio_request(SPI0_CS_GPIO, "spi0 cs");
+       gpio_direction_output(SPI0_CS_GPIO, 1);
+
+       /* Setup network interface for RMII mode */
+       tmp = readl(CLKPWR_MACCLK_CTRL(CLKPWR_IOBASE));
+       tmp &= ~CLKPWR_MACCTRL_PINS_MSK;
+       tmp |= CLKPWR_MACCTRL_USE_RMII_PINS;
+       writel(tmp, CLKPWR_MACCLK_CTRL(CLKPWR_IOBASE));
+
+       /* Setup SLC NAND controller muxing */
+       writel(CLKPWR_NANDCLK_SEL_SLC,
+               CLKPWR_NAND_CLK_CTRL(CLKPWR_IOBASE));
+
+       /* Setup LCD muxing to RGB565 */
+       tmp = readl(CLKPWR_LCDCLK_CTRL(CLKPWR_IOBASE)) &
+               ~(CLKPWR_LCDCTRL_LCDTYPE_MSK | CLKPWR_LCDCTRL_PSCALE_MSK);
+       tmp |= CLKPWR_LCDCTRL_LCDTYPE_TFT16;
+       writel(tmp, CLKPWR_LCDCLK_CTRL(CLKPWR_IOBASE));
+
+       /* Set up I2C levels */
+       tmp = readl(CLKPWR_I2C_CLK_CTRL(CLKPWR_IOBASE));
+       tmp |= CLKPWR_I2CCLK_USBI2CHI_DRIVE | CLKPWR_I2CCLK_I2C2HI_DRIVE;
+       writel(tmp, CLKPWR_I2C_CLK_CTRL(CLKPWR_IOBASE));
+
+       /* Enable DMA for I2S1 channel */
+       tmp = readl(CLKPWR_I2S_CLK_CTRL(CLKPWR_IOBASE));
+       tmp = CLKPWR_I2SCTRL_I2S1_USE_DMA;
+       writel(tmp, CLKPWR_I2S_CLK_CTRL(CLKPWR_IOBASE));
+
+       /* Load the board hardware descriptor, as some other board functions
+          require it's data */
+       phy3250_load_hw_desc();
+
+       serial_init();
+
+       /* AMBA peripheral clocks need to be enabled prior to AMBA device
+          detection or a data fault will occur, so we enable the clocks
+          here. However, we don't want to enable them if the peripheral
+          isn't included in the image */
+#if defined (CONFIG_MMC_ARMMMCI)
+       tmp = readl(CLKPWR_MS_CTRL(CLKPWR_IOBASE));
+       writel((tmp | CLKPWR_MSCARD_SDCARD_EN | CLKPWR_MSCARD_MSDIO_PU_EN),
+               CLKPWR_MS_CTRL(CLKPWR_IOBASE));
+#endif
+#if defined (CONFIG_FB_ARMCLCD)
+       tmp = readl(CLKPWR_LCDCLK_CTRL(CLKPWR_IOBASE));
+       writel((tmp | CLKPWR_LCDCTRL_CLK_EN),
+               CLKPWR_LCDCLK_CTRL(CLKPWR_IOBASE));
+#endif
+#if defined (CONFIG_SPI_PL022)
+       tmp = readl(CLKPWR_SSP_CLK_CTRL(CLKPWR_IOBASE));
+       writel((tmp | CLKPWR_SSPCTRL_SSPCLK0_EN),
+               CLKPWR_SSP_CLK_CTRL(CLKPWR_IOBASE));
+#endif
+
+       platform_add_devices(phy3250_devs, ARRAY_SIZE(phy3250_devs));
+       for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
+               struct amba_device *d = amba_devs[i];
+               amba_device_register(d, &iomem_resource);
+       }
+
+       /* Disable UART5->USB transparent mode or USB won't work */
+       tmp = readl(UARTCTL_CTRL(io_p2v(UART_CTRL_BASE)));
+       tmp &= ~UART_U5_ROUTE_TO_USB;
+       writel(tmp, UARTCTL_CTRL(io_p2v(UART_CTRL_BASE)));
+
+       /* Test clock needed for UDA1380 initial init */
+       writel((CLKPWR_TESTCLK2_SEL_MOSC | CLKPWR_TESTCLK_TESTCLK2_EN),
+               CLKPWR_TEST_CLK_SEL(CLKPWR_IOBASE));
+
+       i2c_register_board_info(0, phy3250_i2c_board_info,
+                               ARRAY_SIZE(phy3250_i2c_board_info));
+}
+
+MACHINE_START (LPC3XXX, "Phytec 3250 board with the LPC3250 Microcontroller")
+       /* Maintainer: Kevin Wells, NXP Semiconductors */
+       .phys_io        = UART5_BASE,
+       .io_pg_offst    = ((io_p2v (UART5_BASE))>>18) & 0xfffc,
+       .boot_params    = 0x80000100,
+       .map_io         = lpc32xx_map_io,
+       .init_irq       = lpc32xx_init_irq,
+       .timer          = &lpc32xx_timer,
+       .init_machine   = phy3250_board_init,
+MACHINE_END
--
1.6.0.6
