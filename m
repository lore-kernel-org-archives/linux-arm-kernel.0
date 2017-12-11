From: davem@davemloft.net (David Miller)
Date: Mon, 11 Dec 2017 14:16:51 -0500 (EST)
Subject: [PATCH net-next 2/2 v8] net: ethernet: Add a driver for Gemini
 gigabit ethernet
In-Reply-To: <20171210224558.27122-2-linus.walleij@linaro.org>
References: <20171210224558.27122-1-linus.walleij@linaro.org>
 <20171210224558.27122-2-linus.walleij@linaro.org>
Message-ID: <20171211.141651.2190843744682664766.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 10 Dec 2017 23:45:58 +0100

> diff --git a/drivers/net/ethernet/cortina/Kconfig b/drivers/net/ethernet/cortina/Kconfig
> new file mode 100644
> index 000000000000..7d279ac4357d
> --- /dev/null
> +++ b/drivers/net/ethernet/cortina/Kconfig
> @@ -0,0 +1,24 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Cortina ethernet devices
> +
> +config NET_VENDOR_CORTINA
> +	bool "Cortina Gemini devices"
> +	depends on (ARM || COMPILE_TEST)
> +	default ARCH_GEMINI
> +	---help---
> +	  If you have a network (Ethernet) card belonging to this class, say Y
> +	  and read the Ethernet-HOWTO, available from
> +	  <http://www.tldp.org/docs.html#howto>.

Vendor Kconfig guards should default to 'y'.  Remove the depends guard.

> +
> +if NET_VENDOR_CORTINA
> +
> +config GEMINI_ETHERNET
> +	tristate "Gemini Gigabit Ethernet support"
> +	depends on ARCH_GEMINI
> +	depends on OF
> +	select PHYLIB
> +	select CRC32
> +	---help---
> +	  This driver supports StorLink SL351x (Gemini) dual Gigabit Ethernet.

Make this driver buildable anywhere, you don't use any platform architecture
specific features.

Otherwise your driver will have bad build coverage and will likely
stop building when core APIs are changed.
