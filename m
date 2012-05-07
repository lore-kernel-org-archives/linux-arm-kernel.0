From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon, 7 May 2012 17:39:43 -0400
Subject: [PATCH] ARM: BCMRING: Fix UART declaration and clk dev name
 mismatch
In-Reply-To: <4FA823C4.1070109@broadcom.com>
References: <4FA823C4.1070109@broadcom.com>
Message-ID: <CAP=VYLofEt_+CZmv2H90CTJ2F5gDfu5o8qfJN-a2bALC5LN=Xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 7, 2012 at 3:34 PM, Jiandong Zheng <jdzheng@broadcom.com> wrote:
> Fix bcmring UART declaration and clk dev name mismatch
>
> With 888073d41680e8244232f3d850e0424a4e9de60f (ARM:
> bcmring: fix UART declarations), it introduced clk dev name
> mismatch and leads to UART initialization failure during boot.

Do things work if you simply do a partial revert of 888073d41 ?

Meaning:

-static AMBA_APB_DEVICE(uartA, "uartA", 0, MM_ADDR_IO_UARTA, {IRQ_UARTA}, NULL);
-static AMBA_APB_DEVICE(uartB, "uartB", 0, MM_ADDR_IO_UARTB, {IRQ_UARTB}, NULL);
+static AMBA_APB_DEVICE(uartA, "uarta", 0, MM_ADDR_IO_UARTA, {IRQ_UARTA}, NULL);
+static AMBA_APB_DEVICE(uartB, "uartb", 0, MM_ADDR_IO_UARTB, {IRQ_UARTB}, NULL);

The original error messages led me to believe it was two errors;
i.e. (1) the wrong # of args error, and (2) the "a" vs. "A" error.  But
I think Olof was right on his 1st instinct, that it was just the
single error, and the a <---> A thing was a side effect.

In which case the above should just work, and it will also keep
the naming consistent with what it was before any of these
commits.

Paul.
--

>
> Signed-off-by: Jiandong Zheng<jdzheng@broadcom.com
> ?<http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>>
> ---
> ?arch/arm/mach-bcmring/core.c | ? ?4 ++--
> ?1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-bcmring/core.c b/arch/arm/mach-bcmring/core.c
> index adbfb19..5559857 100644
> --- a/arch/arm/mach-bcmring/core.c
> +++ b/arch/arm/mach-bcmring/core.c
> @@ -110,10 +110,10 @@ static struct clk_lookup lookups[] = {
> ? ? ? ? ?.con_id = "apb_pclk",
> ? ? ? ? ?.clk =&dummy_apb_pclk,
> ? ? ?}, { ? ? ? ? ? ?/* UART0 */
> - ? ? ? ?.dev_id = "uarta",
> + ? ? ? ?.dev_id = "uartA",
> ? ? ? ? ?.clk =&uart_clk,
> ? ? ?}, { ? ? ? ? ? ?/* UART1 */
> - ? ? ? ?.dev_id = "uartb",
> + ? ? ? ?.dev_id = "uartB",
> ? ? ? ? ?.clk =&uart_clk,
> ? ? ?}, { ? ? ? ? ? ?/* SP804 timer 0 */
> ? ? ? ? ?.dev_id = "sp804",
> --
> 1.7.9.5
>
>
>
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
