From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 26 Nov 2014 19:37:47 +0100
Subject: [PATCH 2/5] pinctrl: sun6i: Add A31s pinctrl support
In-Reply-To: <54758B29.7040203@redhat.com>
References: <1416747283-13489-1-git-send-email-hdegoede@redhat.com>
 <1416747283-13489-3-git-send-email-hdegoede@redhat.com>
 <20141125180831.GB25249@lukather> <54758B29.7040203@redhat.com>
Message-ID: <20141126183747.GK25249@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 09:11:21AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 11/25/2014 07:08 PM, Maxime Ripard wrote:
> >On Sun, Nov 23, 2014 at 01:54:40PM +0100, Hans de Goede wrote:
> >>The A31s is a stripped down version of the A31, as such it is missing some
> >>pins and some functions on some pins.
> >>
> >>The new pinctrl-sun6i-a31s.c this commit adds is a copy of pinctrl-sun6i-a31s.c
> >>with the missing pins and functions removed.
> >>
> >>Note there is no a31s specific version of pinctrl-sun6i-a31-r.c, as the
> >>prcm pins are identical between the A31 and the A31s.
> >>
> >>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>---
> >>  .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
> >>  drivers/pinctrl/sunxi/Kconfig                      |   4 +
> >>  drivers/pinctrl/sunxi/Makefile                     |   1 +
> >>  drivers/pinctrl/sunxi/pinctrl-sun6i-a31s.c         | 814 +++++++++++++++++++++
> >>  4 files changed, 820 insertions(+)
> >>  create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun6i-a31s.c
> >>
> >>diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> >>index 93ce12e..fdd8046 100644
> >>--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> >>+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> >>@@ -11,6 +11,7 @@ Required properties:
> >>    "allwinner,sun5i-a10s-pinctrl"
> >>    "allwinner,sun5i-a13-pinctrl"
> >>    "allwinner,sun6i-a31-pinctrl"
> >>+  "allwinner,sun6i-a31s-pinctrl"
> >>    "allwinner,sun6i-a31-r-pinctrl"
> >>    "allwinner,sun7i-a20-pinctrl"
> >>    "allwinner,sun8i-a23-pinctrl"
> >>diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
> >>index a5e10f7..6cffe38 100644
> >>--- a/drivers/pinctrl/sunxi/Kconfig
> >>+++ b/drivers/pinctrl/sunxi/Kconfig
> >>@@ -21,6 +21,10 @@ config PINCTRL_SUN6I_A31
> >>  	def_bool MACH_SUN6I
> >>  	select PINCTRL_SUNXI_COMMON
> >>
> >>+config PINCTRL_SUN6I_A31S
> >>+	def_bool MACH_SUN6I
> >>+	select PINCTRL_SUNXI_COMMON
> >>+
> >>  config PINCTRL_SUN6I_A31_R
> >>  	def_bool MACH_SUN6I
> >>  	depends on RESET_CONTROLLER
> >>diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
> >>index e797efb..2f82290 100644
> >>--- a/drivers/pinctrl/sunxi/Makefile
> >>+++ b/drivers/pinctrl/sunxi/Makefile
> >>@@ -6,6 +6,7 @@ obj-$(CONFIG_PINCTRL_SUN4I_A10)		+= pinctrl-sun4i-a10.o
> >>  obj-$(CONFIG_PINCTRL_SUN5I_A10S)	+= pinctrl-sun5i-a10s.o
> >>  obj-$(CONFIG_PINCTRL_SUN5I_A13)		+= pinctrl-sun5i-a13.o
> >>  obj-$(CONFIG_PINCTRL_SUN6I_A31)		+= pinctrl-sun6i-a31.o
> >>+obj-$(CONFIG_PINCTRL_SUN6I_A31S)	+= pinctrl-sun6i-a31s.o
> >>  obj-$(CONFIG_PINCTRL_SUN6I_A31_R)	+= pinctrl-sun6i-a31-r.o
> >>  obj-$(CONFIG_PINCTRL_SUN7I_A20)		+= pinctrl-sun7i-a20.o
> >>  obj-$(CONFIG_PINCTRL_SUN8I_A23)		+= pinctrl-sun8i-a23.o
> >>diff --git a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31s.c b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31s.c
> >>new file mode 100644
> >>index 0000000..42ee373
> >>--- /dev/null
> >>+++ b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31s.c
> >>@@ -0,0 +1,814 @@
> >>+/*
> >>+ * Allwinner A31 SoCs pinctrl driver.
> >
> >                 ^ A31s
> >
> 
> Good one.
> 
> >>+ *
> >>+ * Copyright (C) 2014 Maxime Ripard
> >>+ *
> >>+ * Maxime Ripard <maxime.ripard@free-electrons.com>
> >
> >And I guess your copyright would be more appropriate here.
> 
> It is a copy of a file you authored, with some lines removed, so I deliberately left
> this as is.

I'd feel more confortable with at least listing you as the author and
copyright owner, you did more work than I on this one, but it's your
call.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141126/5b8e3369/attachment.sig>
