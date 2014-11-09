From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 09 Nov 2014 16:23:19 +0100
Subject: [PATCH] arm: xscale: correct auxiliary register in suspend/resume
References: <1415479134-19999-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <87oasgv1nc.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

> According to the manuals I have, XScale auxiliary register should be
> reached with opc_2 = 1 instead of crn = 1. cpu_xscale_proc_init
> correctly uses c1, c0, 1 arguments, but cpu_xscale_do_suspend and
> cpu_xscale_do_resume use c1, c1, 0. Correct suspend/resume functions to
> also use c1, c0, 1.

> -	mrc	p15, 0, r8, c1, c1, 0	@ auxiliary control reg
> +	mrc	p15, 0, r8, c1, c0, 1	@ auxiliary control reg

My PXA320 manual says (PXA320 Developer's Guide, chapter 2.16.1, table 5) :
 - Auxiliary Register: Crn=1, Crm=0, Opcode1=0, Opcode2=1
   => that is what your patch changes

My PXA270 manual says (PXA270 Developer's Guide, chapter 2.2.5.3) :
 - Auxiliary Register: Crn=1, Crm=<don't care>, Opcode1=0, Opcode2=1
   => same story as for the PX320

My PXA255 manual doesn't say anything, but the Intel XScale Core Architecture
manual seems to be applicable to it, and gives you reason.

Moreover the CP15, Opcode=1, Crn=1, Crm=0, Opcode2=* doesn't point to any valid
register in XScale architecture AFAIK.

So your patch looks correct to me. I have a couple of questions :
 - did you see an incorrect behaviour without your patch or is this coming from
   code inspection ?
 - did you test this patch during a suspend/resume cycle, and if so on which
   variants (pxa25x and tosa maybe) ?

As you might haved guessed, I'd like all these questions to have an answer in
the commit message.

Cheers.

--
Robert
