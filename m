From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sun, 9 Nov 2014 20:14:53 +0400
Subject: [PATCH] arm: xscale: correct auxiliary register in suspend/resume
In-Reply-To: <87oasgv1nc.fsf@free.fr>
References: <1415479134-19999-1-git-send-email-dbaryshkov@gmail.com>
 <87oasgv1nc.fsf@free.fr>
Message-ID: <CALT56yMg53Dd0iKc-8zwSeRaAJbTnsx9akod_V+X=1t5VN+VKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-09 18:23 GMT+03:00 Robert Jarzmik <robert.jarzmik@free.fr>:
> Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:
>
>> According to the manuals I have, XScale auxiliary register should be
>> reached with opc_2 = 1 instead of crn = 1. cpu_xscale_proc_init
>> correctly uses c1, c0, 1 arguments, but cpu_xscale_do_suspend and
>> cpu_xscale_do_resume use c1, c1, 0. Correct suspend/resume functions to
>> also use c1, c0, 1.
>
>> -     mrc     p15, 0, r8, c1, c1, 0   @ auxiliary control reg
>> +     mrc     p15, 0, r8, c1, c0, 1   @ auxiliary control reg
>
> My PXA320 manual says (PXA320 Developer's Guide, chapter 2.16.1, table 5) :
>  - Auxiliary Register: Crn=1, Crm=0, Opcode1=0, Opcode2=1
>    => that is what your patch changes
>
> My PXA270 manual says (PXA270 Developer's Guide, chapter 2.2.5.3) :
>  - Auxiliary Register: Crn=1, Crm=<don't care>, Opcode1=0, Opcode2=1
>    => same story as for the PX320
>
> My PXA255 manual doesn't say anything, but the Intel XScale Core Architecture
> manual seems to be applicable to it, and gives you reason.
>
> Moreover the CP15, Opcode=1, Crn=1, Crm=0, Opcode2=* doesn't point to any valid
> register in XScale architecture AFAIK.
>
> So your patch looks correct to me. I have a couple of questions :
>  - did you see an incorrect behaviour without your patch or is this coming from
>    code inspection ?

Noticed thanks to qemu that reported 'unsupported instruction' on suspend.

>  - did you test this patch during a suspend/resume cycle, and if so on which
>    variants (pxa25x and tosa maybe) ?

Tested on tosa (that is pxa255).

>
> As you might haved guessed, I'd like all these questions to have an answer in
> the commit message.

Do you need an updated message?

-- 
With best wishes
Dmitry
