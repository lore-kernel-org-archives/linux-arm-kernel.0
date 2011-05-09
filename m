From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 9 May 2011 11:48:57 +0800
Subject: [PATCH] pxa: Fix PGSR register address calculation
In-Reply-To: <E1QItCc-0003up-FQ@outmx08.plus.net>
References: <E1QItCc-0003up-FQ@outmx08.plus.net>
Message-ID: <BANLkTi=N5YWeouh6U8sxByR9eAFmBiT8SA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 8, 2011 at 9:54 AM, Paul Parsons <lost.distance@yahoo.com> wrote:
> The file mfp-pxa2xx.c defines a macro, PGSR(), which translates a gpio bank number to a PGSR register address. The function pxa2xx_mfp_suspend() erroneously passed in a gpio number instead of a gpio bank number.
>
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>

Applied to 'fix'.

> ---
> --- clean-2.6.39-rc6/arch/arm/mach-pxa/mfp-pxa2xx.c ? ? 2011-03-15 01:20:32.000000000 +0000
> +++ linux-2.6.39-rc6/arch/arm/mach-pxa/mfp-pxa2xx.c ? ? 2011-05-08 02:09:36.706294235 +0100
> @@ -347,9 +347,9 @@ static int pxa2xx_mfp_suspend(struct sys
> ? ? ? ? ? ? ? ?if ((gpio_desc[i].config & MFP_LPM_KEEP_OUTPUT) &&
> ? ? ? ? ? ? ? ? ? ?(GPDR(i) & GPIO_bit(i))) {
> ? ? ? ? ? ? ? ? ? ? ? ?if (GPLR(i) & GPIO_bit(i))
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? PGSR(i) |= GPIO_bit(i);
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? PGSR(gpio_to_bank(i)) |= GPIO_bit(i);
> ? ? ? ? ? ? ? ? ? ? ? ?else
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? PGSR(i) &= ~GPIO_bit(i);
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? PGSR(gpio_to_bank(i)) &= ~GPIO_bit(i);
> ? ? ? ? ? ? ? ?}
> ? ? ? ?}
>
>
>
