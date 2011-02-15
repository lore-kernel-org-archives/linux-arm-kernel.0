From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 15 Feb 2011 10:37:29 +0000
Subject: [PATCH] Ensure predictable endian state on signal handler entry
In-Reply-To: <20110214200222.GD31103@n2100.arm.linux.org.uk>
References: <20110214200222.GD31103@n2100.arm.linux.org.uk>
Message-ID: <20110215103728.GA2650@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 14, 2011 at 08:02:22PM +0000, Russell King - ARM Linux wrote:
> Ensure a predictable endian state when entering signal handlers.  This
> avoids programs which use SETEND to momentarily switch their endian
> state from having their signal handlers entered with an unpredictable
> endian state.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> --
> 
>  arch/arm/kernel/signal.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
> index 907d5a6..abaf844 100644
> --- a/arch/arm/kernel/signal.c
> +++ b/arch/arm/kernel/signal.c
> @@ -474,7 +474,9 @@ setup_return(struct pt_regs *regs, struct k_sigaction *ka,
>  	unsigned long handler = (unsigned long)ka->sa.sa_handler;
>  	unsigned long retcode;
>  	int thumb = 0;
> -	unsigned long cpsr = regs->ARM_cpsr & ~PSR_f;
> +	unsigned long cpsr = regs->ARM_cpsr & ~(PSR_f | PSR_E_BIT);
> +
> +	cpsr |= PSR_ENDSTATE;
>  
>  	/*
>  	 * Maybe we need to deliver a 32-bit signal to a 26-bit task.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Looks sensible to me.

Acked-by: Dave Martin <dave.martin@linaro.org>

Only tested it with little-endian, but it's enough to make my silly
test program not segfault.  (Without your patch, it definitely does...)

#include <stdio.h>
#include <signal.h>
#include <string.h>
#include <unistd.h>

static void handler(int n)
{
	unsigned long cpsr;
#define FORMAT "handler: CPSR = 0x%08lX\n"
	char buf[sizeof FORMAT - 5 + 8];

	asm ("mrs %0, CPSR" : "=r" (cpsr));

	snprintf(buf, sizeof buf, FORMAT, cpsr);

	write(STDOUT_FILENO, buf, strlen(buf));
}

int main(void)
{
	signal(SIGINT, handler);

	asm volatile (
	"0:	setend	be\n\t"
	"	b 0b"
	);
}

Cheers
---Dave
