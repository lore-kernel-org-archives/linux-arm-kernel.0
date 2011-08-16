From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 16 Aug 2011 13:57:08 +0530
Subject: [PATCH] amba: consolidate PrimeCell magic
In-Reply-To: <1313402104-27024-1-git-send-email-linus.walleij@stericsson.com>
References: <1313402104-27024-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CABb+yY3Bb2VnFLv8OmeqJH9FpWrpixCHPSgd0yVUnWRoFGA10Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2011 at 3:25 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>
> Since two drivers use the PrimeCell scheme without using the
> amba_bus driver logic, let's break the magic lookups out as
> static inlines in the <linux/amba/bus.h> header so we get
> some consolidation anyway.
>
> Cc: Boojin Kim <boojin.kim@samsung.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Viresh Kumar <viresh.kumar@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

You might also CC the author of relevant code. That of pl330.c in this case.

.....

> +static inline u32 amba_get_magic(void __iomem *base, u32 size, u8 offset)
> +{
> + ? ? ? u32 magic;
> + ? ? ? int i;
> +
> + ? ? ? for (magic = 0, i = 0; i < 4; i++)
> + ? ? ? ? ? ? ? magic |= (readl(base + size - offset + 4 * i) & 255)
> + ? ? ? ? ? ? ? ? ? ? ? << (i * 8);
0xff looks much better than 255, esp when we play with bits.
Also you might simply use readb and drop the sieve ?
Anyways, nothing serious. You might choose to keep it as such
for you personal style.

Other than fixing the compilation breakage. Looks ok to me.
