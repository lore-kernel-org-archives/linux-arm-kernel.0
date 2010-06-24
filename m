From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 24 Jun 2010 05:17:23 +0200
Subject: [PATCH 1/4] pxa2xx/cpufreq: Simplify CPU frequency change asm
In-Reply-To: <87eifxa81o.fsf@free.fr>
References: <1276840135-5982-1-git-send-email-marek.vasut@gmail.com>
	<87eifxa81o.fsf@free.fr>
Message-ID: <201006240517.23651.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne St 23. ?ervna 2010 21:00:19 Robert Jarzmik napsal(a):
> Marek Vasut <marek.vasut@gmail.com> writes:
> > This patch does the following changes to cpufreq-pxa2xx:
> > 1) Simplifies the assembler code for frequency change
> 
> OK, but did you think over what the old code was doing ?
> My guess is that all the jumps were there to trigger a load into the
> I-Cache before playing with memory timings. Did you consider that your new
> assembly fits fully into a cache line, and hence is protected from memory
> shutdown for the frequency change period ?

Good point, I'll rethink this. FTTB dropped from patchqueue.
> 
> If you thought this over, then I would suggest to put a comment into the
> code to state that the assembly bit fits fully in one cache line. If not,
> I don't see clearly the benefit of removing the jumps ("b 2f" and "b 1b").
> 
> And I didn't find the reference for the need of reading the MDREFR register
> after the write. Would you give me a pointer in the pxa27x TRM please ?

I believe the written data might be stuck in the Dcache, reading it back should 
prevent this from happening. We certainly don't want to end with locked-up 
machine, which I saw already. The reason is still unknown to me though.

Cheers
> 
> Cheers.
> 
> --
> Robert
