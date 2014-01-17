From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 17 Jan 2014 12:22:27 +0100
Subject: [PATCH] arm64: mm: use ubfm for dcache_line_size
In-Reply-To: <000301cf135a$c1390e40$43ab2ac0$%han@samsung.com>
References: <000301cf135a$c1390e40$43ab2ac0$%han@samsung.com>
Message-ID: <CAKv+Gu8nnv-ePTyDGv0RiuFcJW7rWhOe0G1JFx439AjA28+wig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 January 2014 09:04, Jingoo Han <jg1.han@samsung.com> wrote:
> Use 'ubfm' for the bitfield move instruction; thus, single
> instruction can be used instead of two instructions, when
> getting the minimum D-cache line size from CTR_EL0 register.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  arch/arm64/mm/proc-macros.S |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm64/mm/proc-macros.S b/arch/arm64/mm/proc-macros.S
> index 8957b82..c31f41e 100644
> --- a/arch/arm64/mm/proc-macros.S
> +++ b/arch/arm64/mm/proc-macros.S
> @@ -38,8 +38,7 @@
>   */
>         .macro  dcache_line_size, reg, tmp
>         mrs     \tmp, ctr_el0                   // read CTR
> -       lsr     \tmp, \tmp, #16
> -       and     \tmp, \tmp, #0xf                // cache line size encoding
> +       ubfm    \tmp, \tmp, #0x16, 0x19         // cache line size encoding

Even if the # is optional for immediates these days, perhaps it is
better to adhere to a single style in one line?

-- 
Ard.
