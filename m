From: marcel@holtmann.org (Marcel Holtmann)
Date: Mon, 19 Jan 2015 13:36:08 -0800
Subject: [PATCH] bluetooth: Add hci_h4p driver
In-Reply-To: <20141223130219.GA5731@amd>
References: <20141223130219.GA5731@amd>
Message-ID: <CB643345-4B50-4ED0-8C3E-296CD225754D@holtmann.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

> Add HCI driver for H4 with Nokia extensions. This device is used on
> Nokia N900 cell phone.
> 
> Older version of this driver lived in staging, before being reverted
> in a4102f90e87cfaa3fdbed6fdf469b23f0eeb4bfd .
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> Thanks-to: Sebastian Reichel <sre@debian.org>
> Thanks-to: Joe Perches <joe@perches.com>
> 
> ---
> 
> Please apply,
> 								Pavel
> 
> 
> Kconfig      |   10 
> Makefile     |    4 
> nokia_core.c | 1149 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> nokia_fw.c   |   99 +++++
> nokia_h4p.h  |  214 ++++++++++
> nokia_uart.c |  171 ++++++++
> 7 files changed, 1667 insertions(+)

so when I run this through checkpatch --strict, then I get tons of warning that we have DOS style ^M line breaks. There are also trailing whitespace that need fixing. I can use cleanpatch to do this, but so can you.

Even after doing that there are still obvious plain coding style violation in the patch. For example:

ERROR: space prohibited before that ',' (ctx:WxW)
#610: FILE: drivers/bluetooth/nokia_core.c:517:
+			__h4p_set_auto_ctsrts(info, 0 , UART_EFR_RTS);
 			                              ^

CHECK: Alignment should match open parenthesis
#662: FILE: drivers/bluetooth/nokia_core.c:569:
+		h4p_outb(info, UART_OMAP_SCR,
+			     h4p_inb(info, UART_OMAP_SCR) |

CHECK: Blank lines aren't necessary before a close brace '}'
#692: FILE: drivers/bluetooth/nokia_core.c:599:
+
+}

These are only few. They are more and all these need fixing before I even consider it.

Also this worries me:

WARNING: DT compatible string "brcm,uart,bcm2048" appears un-documented -- check ./Documentation/devicetree/bindings/
#1222: FILE: drivers/bluetooth/nokia_core.c:1129:
+	{ .compatible = "brcm,uart,bcm2048" },

Regards

Marcel
