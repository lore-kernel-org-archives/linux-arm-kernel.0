From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 23 Jun 2010 21:00:19 +0200
Subject: [PATCH 1/4] pxa2xx/cpufreq: Simplify CPU frequency change asm
In-Reply-To: <1276840135-5982-1-git-send-email-marek.vasut@gmail.com> (Marek
	Vasut's message of "Fri\, 18 Jun 2010 07\:48\:52 +0200")
References: <1276840135-5982-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <87eifxa81o.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Vasut <marek.vasut@gmail.com> writes:

> This patch does the following changes to cpufreq-pxa2xx:
> 1) Simplifies the assembler code for frequency change
OK, but did you think over what the old code was doing ?
My guess is that all the jumps were there to trigger a load into the I-Cache
before playing with memory timings. Did you consider that your new assembly fits
fully into a cache line, and hence is protected from memory shutdown for the
frequency change period ?

If you thought this over, then I would suggest to put a comment into the code to
state that the assembly bit fits fully in one cache line. If not, I don't see
clearly the benefit of removing the jumps ("b 2f" and "b 1b").

And I didn't find the reference for the need of reading the MDREFR register
after the write. Would you give me a pointer in the pxa27x TRM please ?

Cheers.

--
Robert
