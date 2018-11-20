From: Andrei.Stefanescu@microchip.com (Andrei.Stefanescu at microchip.com)
Date: Tue, 20 Nov 2018 08:08:33 +0000
Subject: [PATCH v2 0/2] add SAMA5D2 PIOBU GPIO driver
Message-ID: <1542701330-23466-1-git-send-email-andrei.stefanescu@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On SAMA5D2 SoC the PIOBU pins do not lose their
voltage during Backup/Self-refresh mode. This can
be useful, for example, when the voltage must remain
positive for a peripheral during Backup/Self-refresh
mode (suspend-to ram is the Linux equivalent state).

v2:
- make driver be a subnode of the syscon node
- change Kconfig to depend on MFD_SYSCON and select GPIO_SYSCON
- change include header from linux/gpio.h to linux/gpio/driver.h
- include linux/bits.h header
- change intrusion in comment to tamper
- fix kerneldoc of functions
- replace GPIOF_DIR_* flags with 0/1
- replace ?: statement with if-else
- remove the use of sama5d2_piobu_template_chip
- retrieve syscon via syscon_node_to_regmap(pdev->dev.parent->of_node);

Note that PIOBU_REG_SIZE is used to determine the register to write to
with regmap:
	reg = PIOBU_BASE + pin * PIOBU_REG_SIZE;

Also, no irq capability implemented.

Andrei Stefanescu (2):
  dt-bindings: gpio: add SAMA5D2 PIOBU support
  gpio: add driver for SAMA5D2 PIOBU pins

 .../bindings/gpio/gpio-sama5d2-piobu.txt           |  31 +++
 MAINTAINERS                                        |   7 +
 drivers/gpio/Kconfig                               |  11 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-sama5d2-piobu.c                  | 253 +++++++++++++++++++++
 5 files changed, 303 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-sama5d2-piobu.txt
 create mode 100644 drivers/gpio/gpio-sama5d2-piobu.c

-- 
2.7.4
