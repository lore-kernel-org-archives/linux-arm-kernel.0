From: danielhilst@gmail.com (Daniel.)
Date: Tue, 14 Jul 2015 17:36:09 -0300
Subject: Need to disable I2C support globally for enable SPI support on
 gpio-mcp23s08.c?
Message-ID: <CAF3SDA7y8pHmkdqA6nabGP_nYEfFapQjd9pTDtU2RZx8p4JbAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I use a MCP23S17 on my board on which I stack another module to use
gpios from MCP as digital input and output ports. I've added IRQ to
this driver on kernel 3.0 and use it do detect input changes avoiding
polling. The MCP sits on spi0 bus, CS0. The problem is: It seems to me
that the new (the one at 3.14.28) gpio-mcp23s08.c driver only supports
SPI if I2C is globally disabled. This is the lines from
drivers/spi/Kconfig of it.

config GPIO_MCP23S08
        tristate "Microchip MCP23xxx I/O expander"
        depends on OF_GPIO
        depends on (SPI_MASTER && !I2C) || I2C

I can't fully disable I2C because other devices on my board uses it.
Is that right? If not, how to fix it?
I could compile it fine but when I hit `make modules_install
INSTALL_MOD_PATH=...' it gives me this line:
warning: (DIGITALIO) selects GPIO_MCP23S08 which has unmet direct
dependencies (GPIOLIB && OF_GPIO && (SPI_MASTER || !I2C))

Everything seems to be enabled on .config:
[geckos at csi24 linux-csi-mx6-3.14.28]$ grep
'CONFIG_GPIOLIB=\|CONFIG_OF_GPIO=\|CONFIG_SPI_MASTER=\|CONFIG_I2C='
.config
CONFIG_I2C=y
CONFIG_SPI_MASTER=y
CONFIG_GPIOLIB=y
CONFIG_OF_GPIO=y


Also I'm willing to add interrupt at a generic way so this can be
merged on main-line, so I don't have to patch this driver everytime
that a kernel update is needed. Any guidelines on this?

Best regards

- dhs
