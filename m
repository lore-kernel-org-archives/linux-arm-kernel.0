From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 01 Oct 2013 15:44:00 -0600
Subject: [PATCH 2/6] clk: exynos5410: register clocks using common clock
 framework
In-Reply-To: <1380644227-12244-3-git-send-email-v.tyrtov@samsung.com>
References: <1380644227-12244-1-git-send-email-v.tyrtov@samsung.com>
 <1380644227-12244-3-git-send-email-v.tyrtov@samsung.com>
Message-ID: <524B4220.1070209@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2013 10:17 AM, Vyacheslav Tyrtov wrote:
> From: Tarek Dakhran <t.dakhran@samsung.com>
> 
> The EXYNOS5410 clocks are statically listed and registered
> using the Samsung specific common clock helper functions.

> diff --git a/Documentation/devicetree/bindings/clock/exynos5410-clock.txt b/Documentation/devicetree/bindings/clock/exynos5410-clock.txt

> +       [Core Clocks]
> +  [Clock Gate for Special Clocks]
> +   [Peripheral Clock Gates]

These headers/titles for the sections/lists aren't consistently aligned.

> +  [Clock Gate for Special Clocks]
> +
> +  Clock			ID
> +  ----------------------------
> +  sclk_uart0		128
> +  sclk_uart1		129
> +  sclk_uart2		130
> +  sclk_uart3		131
> +  sclk_mmc0		132
> +  sclk_mmc1		133
> +  sclk_mmc2		134
> +
> +   [Peripheral Clock Gates]
> +
> +  Clock			ID
> +  ----------------------------
> +
> +  uart0			257
> +  uart1			258
> +  uart2			259
> +  uart3			260
> +  mct			315
> +  mmc0			351
> +  mmc1			352
> +  mmc2			353

That's not many clocks. I assume you're planning on adding more IDs
later, in a backwards-compatible fashion? I suppose that's OK since it
won't break any existing usage, as long as there's no need to renumber
any existing values.

On that topic, are any of those clock IDs derived from HW, e.g. register
numbers, or bit numbers in an array of registers? Numbering clocks in a
HW-derived fashion would make it easier or more obvious how to add new
clock IDs later while maintaining some consistency and without
introducing the desire to break any ABI.

Finally, how about creating a header file such as
include/dt-bindings/clock/exynos5410.h to define those clock IDs, so
that both *.dts and the clock driver can share the values without having
to manually write them?
