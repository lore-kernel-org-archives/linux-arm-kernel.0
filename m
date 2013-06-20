From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jun 2013 21:02:30 +0200
Subject: [PATCH v3 02/10] clocksource:arm_global_timer: Add ARM global
 timer support.
In-Reply-To: <1371737121-9295-1-git-send-email-srinivas.kandagatla@st.com>
References: <1371736996-8770-1-git-send-email-srinivas.kandagatla@st.com>
 <1371737121-9295-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <201306202102.30478.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 June 2013, Srinivas KANDAGATLA wrote:
> +static u64 gt_counter_read(void)
> +{
> +       u64 counter;
> +       u32 lower;
> +       u32 upper, old_upper;
> +
> +       upper = __raw_readl(gt_base + GT_COUNTER1);
> +       do {
> +               old_upper = upper;
> +               lower = __raw_readl(gt_base + GT_COUNTER0);
> +               upper = __raw_readl(gt_base + GT_COUNTER1);
> +       } while (upper != old_upper);
> +
> +       counter = upper;
> +       counter <<= 32;
> +       counter |= lower;
> +       return counter;
> +}

Please replace __raw_readl etc with the non-__raw variants
throughout the code.

The __raw accessors are not endian safe and are not meant
for device drivers. If you are worried about latency from
extra barriers, use readl_relaxed().

	Arnd
