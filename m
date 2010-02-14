From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 14 Feb 2010 12:08:40 +0100
Subject: [PATCH 08/10] ARM: ftrace: fix and update dynamic ftrace
In-Reply-To: <1266090518-31120-9-git-send-email-rabin@rab.in>
References: <1266090518-31120-1-git-send-email-rabin@rab.in>
	<1266090518-31120-9-git-send-email-rabin@rab.in>
Message-ID: <20100214110840.GA21357@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sun, Feb 14, 2010 at 01:18:36AM +0530, Rabin Vincent wrote:
> This adds mcount recording and updates dynamic ftrace for ARM to work
> with the new ftrace dyamic tracing implementation.  It also adds support
> for the mcount format used by newer ARM compilers.
> 
> With dynamic tracing, mcount() is implemented as a nop.  Callsites are
> patched on startup with nops, and dynamically patched to call to the
> ftrace_caller() routine as needed.
> 
> Signed-off-by: Rabin Vincent <rabin@rab.in>
> ---
>  arch/arm/include/asm/ftrace.h  |   19 +++++-
>  arch/arm/kernel/entry-common.S |   37 +++++++---
>  arch/arm/kernel/ftrace.c       |  155 +++++++++++++++++++++++++++------------
>  scripts/recordmcount.pl        |    2 +
>  4 files changed, 155 insertions(+), 58 deletions(-)
> 
> diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
> index 103f7ee..4a56a2e 100644
> --- a/arch/arm/include/asm/ftrace.h
> +++ b/arch/arm/include/asm/ftrace.h
> @@ -2,12 +2,29 @@
>  #define _ASM_ARM_FTRACE
>  
>  #ifdef CONFIG_FUNCTION_TRACER
> -#define MCOUNT_ADDR		((long)(mcount))
> +#define MCOUNT_ADDR		((unsigned long)(__gnu_mcount_nc))
hhmm, does this work with both the old and the new mcount function?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
