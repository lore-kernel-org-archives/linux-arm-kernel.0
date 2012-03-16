From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 16 Mar 2012 15:21:53 +0530
Subject: [PATCH v4] ARM: SPEAr600: Add device-tree support to SPEAr600
 boards
In-Reply-To: <1331890216-8361-1-git-send-email-sr@denx.de>
References: <1331890216-8361-1-git-send-email-sr@denx.de>
Message-ID: <4F630D39.2090905@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/16/2012 3:00 PM, Stefan Roese wrote:
> This patch adds a generic target for SPEAr600 board that can be
> configured via the device-tree. Currently the following devices
> are supported via the devicetree:
> 
> - VIC interrupts
> - PL011 UART
> - PL061 GPIO
> - Synopsys DW I2C
> - Synopsys DW ethernet
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Viresh Kumar <viresh.kumar@st.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Acked-by: Viresh Kumar <viresh.kumar@st.com>

I have one query (as part of my learning of DT) to all DT experts:

> 
> +                       /* local/cpu GPIO */
> +                       gpio0: gpio at f0100000 {
> +                               #gpio-cells = <2>;
> +                               compatible = "arm,pl061", "arm,primecell";
> +                               gpio-controller;
> +                               reg = <0xf0100000 0x1000>;
> +                               interrupt-parent = <&vic0>;
> +                               interrupts = <18>;
> +                       };
> +
> 

Can we add name property here:
				name = "gpio0"

So that we don't need to do below stuff.

> diff --git a/arch/arm/mach-spear6xx/clock.c b/arch/arm/mach-spear6xx/clock.c
> @@ -641,8 +641,8 @@ static struct clk_lookup spear_clk_lookups[] = {
> -       { .dev_id = "gpio0",            .clk = &gpio0_clk},
> -       { .dev_id = "gpio1",            .clk = &gpio1_clk},
> -       { .dev_id = "gpio2",            .clk = &gpio2_clk},
> +       { .dev_id = "f0100000.gpio",    .clk = &gpio0_clk},
> +       { .dev_id = "fc980000.gpio",    .clk = &gpio1_clk},

I can't find much dts files using this approach. Even i don't know
if setting name will be sufficient?

-- 
viresh
