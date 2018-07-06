From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 06 Jul 2018 23:28:15 +0200
Subject: [PATCH] ARM: pxa: irq: fix handling of ICMR registers in
 suspend/resume
In-Reply-To: <20180706201500.2000-1-daniel@zonque.org> (Daniel Mack's message
 of "Fri, 6 Jul 2018 22:15:00 +0200")
References: <20180706201500.2000-1-daniel@zonque.org>
Message-ID: <87zhz4f40g.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack <daniel@zonque.org> writes:

> PXA3xx platforms have 56 interrupts that are stored in two ICMR
> registers. The code in pxa_irq_suspend() and pxa_irq_resume() however
> does a simple division by 32 which only leads to one register being
> saved at suspend and restored at resume time. The NAND interrupt
> setting, for instance, is lost.
>
> Fix this by using DIV_ROUND_UP() instead.
>
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> ---
>  arch/arm/mach-pxa/irq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
> index 9c10248fadcc..4e8c2116808e 100644
> --- a/arch/arm/mach-pxa/irq.c
> +++ b/arch/arm/mach-pxa/irq.c
> @@ -185,7 +185,7 @@ static int pxa_irq_suspend(void)
>  {
>  	int i;
>  
> -	for (i = 0; i < pxa_internal_irq_nr / 32; i++) {
> +	for (i = 0; i < DIV_ROUND_UP(pxa_internal_irq_nr, 32); i++) {
Okay, I get it.  Still, something tells me saved_icmr deserves some love too,
even if the result in the end won't change, it's just for corectness sake.

Of course, while@it I wonder if we couldn't have :
 - pxa_init_irq_common()
 - a kmalloc_array() or similar for saved_icmr[] and saved_ipr[]
That could be in this patch or another one ...

Cheers.

-- 
Robert
