From: schwidefsky@de.ibm.com (Martin Schwidefsky)
Date: Mon, 17 Jan 2011 13:18:23 +0100
Subject: [PATCH] sched: provide scheduler_ipi() callback in response to
	smp_send_reschedule()
In-Reply-To: <1295262433.30950.53.camel@laptop>
References: <1295262433.30950.53.camel@laptop>
Message-ID: <20110117131823.410e515c@mschwide.boeblingen.de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Jan 2011 12:07:13 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> I visited existing smp_send_reschedule() implementations and tried to
> add a call to scheduler_ipi() in their handler part, but esp. for MIPS
> I'm not quite sure I actually got all of them.
>  
> diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
> index 94cf510..61789e8 100644
> --- a/arch/s390/kernel/smp.c
> +++ b/arch/s390/kernel/smp.c
> @@ -163,12 +163,12 @@ static void do_ext_call_interrupt(unsigned int ext_int_code,
>  
>  	/*
>  	 * handle bit signal external calls
> -	 *
> -	 * For the ec_schedule signal we have to do nothing. All the work
> -	 * is done automatically when we return from the interrupt.
>  	 */
>  	bits = xchg(&S390_lowcore.ext_call_fast, 0);
>  
> +	if (test_bit(ec_schedule, &bits))
> +		scheduler_ipi();
> +
>  	if (test_bit(ec_call_function, &bits))
>  		generic_smp_call_function_interrupt();
>  

s390 bits are fine.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
