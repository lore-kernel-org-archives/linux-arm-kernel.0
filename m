From: ynezz@true.cz (=?UTF-8?q?Petr=20=C5=A0tetiar?=)
Date: Fri,  1 Apr 2016 14:41:46 +0200
Subject: [PATCH] ARM: imx6: Fix PCIe reset gpio polarity on Toradex Apalis
Message-ID: <1459514508-8557-1-git-send-email-ynezz@true.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit 5c5fb40de8f14 "PCI: imx6: Add support for active-low reset GPIO"
I've made GPIO reset polarity aware, which made the PCIe working on Apalis SoM
(reset active-high), but it has broken PCIe on several other i.MX6 boards
(reset active-low) due to wrong logic level. It has made the default reset
logic active-high, but it was active-low since beginning due to the bug in the
reset code:

	gpio_set_value_cansleep(imx6_pcie->reset_gpio, 0);
	msleep(100);
	gpio_set_value_cansleep(imx6_pcie->reset_gpio, 1);

This breakage couldn't be fixed correctly by fixing the reset code snippet
mentioned above and fixing the broken DTBs, as we can't touch the DTBs, so the
5c5fb40de8f14 commit is going to be reverted, making PCIe reset broken on
Apalis modules again.

As suggested by Fabio, to fix this situation in backward compatible manner, we
should introduce new boolean DT property reset-gpio-active-high, which would
set PCIe reset GPIO polarity as needed. This patch series tries to do so.
