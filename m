From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 19 Mar 2015 18:48:10 +0000
Subject: [RFC PATCH 2/7] printk: Simple implementation for NMI backtracing
In-Reply-To: <20150319183037.GT23123@twins.programming.kicks-ass.net>
References: <1426688428-3150-1-git-send-email-daniel.thompson@linaro.org>
 <1426688428-3150-3-git-send-email-daniel.thompson@linaro.org>
 <20150319133958.4821493e@gandalf.local.home>
 <20150319183037.GT23123@twins.programming.kicks-ass.net>
Message-ID: <550B19EA.6000202@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/03/15 18:30, Peter Zijlstra wrote:
> On Thu, Mar 19, 2015 at 01:39:58PM -0400, Steven Rostedt wrote:
>>> +void printk_nmi_backtrace_complete(void)
>>> +{
>>> +	struct nmi_seq_buf *s;
>>> +	int len, cpu, i, last_i;
>>> +
>>> +	/*
>>> +	 * Now that all the NMIs have triggered, we can dump out their
>>> +	 * back traces safely to the console.
>>> +	 */
>>> +	for_each_possible_cpu(cpu) {
>>> +		s = &per_cpu(nmi_print_seq, cpu);
>>> +		last_i = 0;
>>> +
>>> +		len = seq_buf_used(&s->seq);
>>> +		if (!len)
>>> +			continue;
>>> +
>>> +		/* Print line by line. */
>>> +		for (i = 0; i < len; i++) {
>>> +			if (s->buffer[i] == '\n') {
>>> +				print_seq_line(s, last_i, i);
>>> +				last_i = i + 1;
>>> +			}
>>> +		}
>>> +		/* Check if there was a partial line. */
>>> +		if (last_i < len) {
>>> +			print_seq_line(s, last_i, len - 1);
>>> +			pr_cont("\n");
>>> +		}
>>> +
>>> +		/* Wipe out the buffer ready for the next time around. */
>>> +		seq_buf_clear(&s->seq);
>>> +	}
>>> +
>>> +	clear_bit(0, &nmi_print_flag);
>>> +	smp_mb__after_atomic();
>>
>> Is this really necessary. What is the mb synchronizing?
>>
>> [ Added Peter Zijlstra to confirm it's not needed ]
>
> It surely looks suspect; and it lacks a comment, which is a clear sign
> its buggy.
>
> Now it if tries to order the accesses to the seqbuf againt the clearing
> of the bit one would have expected a _before_ barrier, not an _after_.

It's nothing to do with the seqbuf since I added the seqbuf code myself 
but the barrier was already in the code that I copied from.

In the mainline code today it looks like this as part of the x86 code 
(note that call to put_cpu() in my patchset but it lives in the arch/ 
specific code rather than the generic code):

:                 /* Check if there was a partial line. */
:                 if (last_i < len) {
:                         print_seq_line(s, last_i, len - 1);
:                         pr_cont("\n");
:                 }
:         }
:
:         clear_bit(0, &backtrace_flag);
:         smp_mb__after_atomic();
:         put_cpu();
: }

The barrier was not intended to have anything to do with put_cpu() 
either though since the barrier was added before put_cpu() arrived:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=554ec063982752e9a569ab9189eeffa3d96731b2

There's nothing in the commit comment explaining the barrier and I 
really can't see what it is for.


Daniel.
