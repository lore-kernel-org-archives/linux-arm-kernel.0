From: mingo@elte.hu (Ingo Molnar)
Date: Fri, 11 Dec 2009 11:19:52 +0100
Subject: [PATCH 4/4] arm/perfevents: implement perf event support for ARMv6
In-Reply-To: <1260524662-30683-5-git-send-email-jamie.iles@picochip.com>
References: <1260524662-30683-1-git-send-email-jamie.iles@picochip.com>
	<1260524662-30683-2-git-send-email-jamie.iles@picochip.com>
	<1260524662-30683-3-git-send-email-jamie.iles@picochip.com>
	<1260524662-30683-4-git-send-email-jamie.iles@picochip.com>
	<1260524662-30683-5-git-send-email-jamie.iles@picochip.com>
Message-ID: <20091211101952.GA16882@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Jamie Iles <jamie.iles@picochip.com> wrote:

> This patch implements support for ARMv6 performance counters in the 
> Linux performance events subsystem. ARMv6 architectures that have the 
> performance counters should enable ARMV6_PERF_EVENTS and define the 
> interrupts for the counters in arch/arm/kernel/perf_event.c
> 
> Signed-off-by: Jamie Iles <jamie.iles@picochip.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@elte.hu>
> ---
>  arch/arm/Kconfig                  |    5 +
>  arch/arm/include/asm/perf_event.h |    2 -
>  arch/arm/kernel/Makefile          |    1 +
>  arch/arm/kernel/perf_event.c      |  993 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 999 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/kernel/perf_event.c

Very nice!

The code looks sane - i've only got a few (minor) stylistic comments.

Firstly, you seem to be using several different, inconsistent multi-line 
comment styles:

> +	/*
> +	 * The interrupts are cleared by writing the overflow flags back to
> +	 * the control register. All of the other bits don't have any effect
> +	 * if they are rewritten, so write the whole value back.
> +	 */

> +/* Define the IRQs for the system. We could use something like a platform
> + * device but that seems fairly heavyweight for this. Also, the performance
> + * counters can't be removed or hotplugged. */

please use the first variant everywhere, that's what is specified in 
Documentation/CodingStyle as well:

  /*
   * Comment .....
   * ...... goes here.
   */

There's also some whitespace damage as well:

> +        /* frame pointers should strictly progress back up the stack
> +         * (towards higher addresses) */

(should be tabs, not spaces)

Thanks,

	Ingo
