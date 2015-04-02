From: manabian@gmail.com (Joachim Eastwood)
Date: Thu,  2 Apr 2015 22:31:42 +0200
Subject: [PATCH 0/6] Clk drivers for NXP LPC18xx family
Message-ID: <1428006708-13690-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for the two main clock peripherals types in
the LPC18xx/43xx MCU family. For a MCU the clock structure is quite
complex. Patches are based on Linus master 4.0-rc6.

The Clock Generation Unit (CGU) is the base source of all clocks. It has
five external inputs and contains PLLs, dividers and muxes. The outputs
from the CGU are then routed to a Clock Control Unit (CCU) and a few
peripherals directly. There are two CCUs in the MCU. The CCU is a
collection of gates and a few dividers that sits between the CGU and
most of the peripherals. See the bottom for full clock tree.

Which clocks that are available depends on the specific device and it's
peripherals. It's possible in DT to setup the routing between the CGU
and the CCUs.

I have tried to use the generic clock elements as much as possible to
build the driver using composite clocks. For the most part the gates,
dividers and muxes in cgu and ccu are simple registers.

In patch 4 there is a function called of_clk_get_parent_arg(...) which
could be moved to more generic place if there is interest.

The last patch shows the full cgu/ccu additions to DT.

See the base support patch set for LPC18xx here:
http://marc.info/?l=linux-arm-kernel&m=142792344110733&w=2

Joachim Eastwood (6):
  clk: add table_size member to struct clk_mux
  clk: add lpc18xx cgu clk driver
  doc: dt: add documentation for lpc1850-cgu clk driver
  clk: add lpc18xx ccu clk driver
  doc: dt: add documentation for lpc1850-ccu clk driver
  ARM: dts: lpc18xx: add clock nodes for cgu and ccu

 .../devicetree/bindings/clock/lpc1850-ccu.txt      | 146 ++++++
 .../devicetree/bindings/clock/lpc1850-cgu.txt      | 138 +++++
 arch/arm/boot/dts/lpc18xx.dtsi                     |  96 +++-
 drivers/clk/Makefile                               |   2 +
 drivers/clk/clk-lpc18xx-ccu.c                      | 318 ++++++++++++
 drivers/clk/clk-lpc18xx-cgu.c                      | 570 +++++++++++++++++++++
 include/dt-bindings/clock/lpc18xx-ccu.h            |  74 +++
 include/dt-bindings/clock/lpc18xx-cgu.h            |  41 ++
 include/linux/clk-provider.h                       |   3 +-
 9 files changed, 1373 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/lpc1850-ccu.txt
 create mode 100644 Documentation/devicetree/bindings/clock/lpc1850-cgu.txt
 create mode 100644 drivers/clk/clk-lpc18xx-ccu.c
 create mode 100644 drivers/clk/clk-lpc18xx-cgu.c
 create mode 100644 include/dt-bindings/clock/lpc18xx-ccu.h
 create mode 100644 include/dt-bindings/clock/lpc18xx-cgu.h

Clock tree from /sys/kernel/debug/clk/clk_summary after bootloader setup.

   clock                         enable_cnt  prepare_cnt        rate   accuracy   phase
 irc                                      0            0    12000000          0 0  
    base_cgu_out1_clk                     0            0    12000000          0 0  
    base_cgu_out0_clk                     0            0    12000000          0 0  
    base_audio_clk                        0            0    12000000          0 0  
       audio                              0            0    12000000          0 0  
    base_out_clk                          0            0    12000000          0 0  
    base_ssp1_clk                         0            0    12000000          0 0  
       apb2_ssp1                          0            0    12000000          0 0  
    base_ssp0_clk                         0            0    12000000          0 0  
       apb0_ssp0                          0            0    12000000          0 0  
    base_sdio_clk                         0            0    12000000          0 0  
       sdio                               0            0    12000000          0 0  
    base_adchs_clk                        0            0    12000000          0 0  
    base_lcd_clk                          0            0    12000000          0 0  
    base_apb3_clk                         0            0    12000000          0 0  
       apb3_bus                           0            0    12000000          0 0  
          apb3_can0                       0            0    12000000          0 0  
          apb3_adc1                       0            0    12000000          0 0  
          apb3_adc0                       0            0    12000000          0 0  
          apb3_dac                        0            0    12000000          0 0  
          apb3_i2c1                       0            0    12000000          0 0  
    base_apb1_clk                         0            0    12000000          0 0  
       apb1_bus                           0            0    12000000          0 0  
          apb1_can1                       0            0    12000000          0 0  
          apb1_i2s                        0            0    12000000          0 0  
          apb1_i2c0                       0            0    12000000          0 0  
          apb1_motorcon_pwm               0            0    12000000          0 0  
    base_phy_tx_clk                       0            0    12000000          0 0  
    base_phy_rx_clk                       0            0    12000000          0 0  
    base_spi_clk                          0            0    12000000          0 0  
       spi                                0            0    12000000          0 0  
    base_spifi_clk                        0            0    12000000          0 0  
       spifi                              0            0    12000000          0 0  
    base_usb1_clk                         0            0    12000000          0 0  
       usb1                               0            0    12000000          0 0  
    base_periph_clk                       0            0    12000000          0 0  
       periph_bus                         0            0    12000000          0 0  
          periph_sgpio                    0            0    12000000          0 0  
          periph_core                     0            0    12000000          0 0  
    base_safe_clk                         0            0    12000000          0 0  
    idive                                 0            0    12000000          0 0  
    idivd                                 0            0    12000000          0 0  
    idivb                                 0            0    12000000          0 0  
    idiva                                 0            0    12000000          0 0  
    pll0audio                             0            0    12000000          0 0  
 gp_clkin                                 0            0           0          0 0  
 enet_tx_clk                              0            0           0          0 0  
 enet_rx_clk                              0            0           0          0 0  
 xtal32                                   0            0       32768          0 0  
 xtal                                     1            1    12000000          0 0  
    osc                                   1            1    12000000          0 0  
       pll1                               2            2   144000000          0 0  
          base_uart3_clk                  0            0   144000000          0 0  
             apb2_uart3                   0            0   144000000          0 0  
          base_uart2_clk                  0            0   144000000          0 0  
             apb2_uart2                   0            0   144000000          0 0  
          base_uart1_clk                  0            0   144000000          0 0  
             apb0_uart1                   0            0   144000000          0 0  
          base_uart0_clk                  1            1   144000000          0 0  
             apb0_uart0                   1            1   144000000          0 0  
          base_cpu_clk                    1            1   144000000          0 0  
             cpu_bus                      7            7   144000000          0 0  
                cpu_qei                   0            0   144000000          0 0  
                cpu_ssp1                  0            0   144000000          0 0  
                cpu_timer3                0            0   144000000          0 0  
                cpu_timer2                0            0   144000000          0 0  
                cpu_uart3                 0            0   144000000          0 0  
                cpu_uart2                 0            0   144000000          0 0  
                cpu_ritimer               0            0   144000000          0 0  
                cpu_creg                  1            1   144000000          0 0  
                cpu_scu                   0            0   144000000          0 0  
                cpu_timer1                1            1   144000000          0 0  
                cpu_timer0                1            1   144000000          0 0  
                cpu_ssp0                  0            0   144000000          0 0  
                cpu_uart1                 0            0   144000000          0 0  
                cpu_uart0                 1            1   144000000          0 0  
                cpu_wwdt                  0            0   144000000          0 0  
                cpu_eeprom                0            0   144000000          0 0  
                cpu_adchs                 0            0   144000000          0 0  
                cpu_m0app                 0            0   144000000          0 0  
                cpu_flashb                0            0   144000000          0 0  
                cpu_flasha                0            0   144000000          0 0  
                cpu_emcdiv                1            1    72000000          0 0  
                cpu_usb1                  0            0   144000000          0 0  
                cpu_sct                   0            0   144000000          0 0  
                cpu_core                  1            1   144000000          0 0  
                cpu_dma                   0            0   144000000          0 0  
                cpu_sdio                  0            0   144000000          0 0  
                cpu_emc                   1            1   144000000          0 0  
                cpu_usb0                  0            0   144000000          0 0  
                cpu_ethernet              0            0   144000000          0 0  
                cpu_lcd                   0            0   144000000          0 0  
                cpu_gpio                  0            0   144000000          0 0  
                cpu_spifi                 0            0   144000000          0 0  
          idivc                           0            0    48000000          0 0  
       pll0usb                            0            0   480000000          0 0  
          base_usb0_clk                   0            0   480000000          0 0  
             usb0                         0            0   480000000          0 0

-- 
1.8.0
