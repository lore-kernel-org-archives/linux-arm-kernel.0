From: slash.tmp@free.fr (Mason)
Date: Wed, 14 Oct 2015 21:34:30 +0200
Subject: l2c: Kernel panic in l2c310_enable() in non-secure mode
In-Reply-To: <20151014174503.GQ32532@n2100.arm.linux.org.uk>
References: <561E6407.6000002@sigmadesigns.com>
 <20151014174503.GQ32532@n2100.arm.linux.org.uk>
Message-ID: <561EAE46.4080901@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/2015 19:45, Russell King - ARM Linux wrote:

> On Wed, Oct 14, 2015 at 04:17:43PM +0200, Marc Gonzalez wrote:
>
>> Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP ARM
>>
>> On my platform, Linux v4.2 running in non-secure mode panics in
>> l2c310_enable() with the pc pointing at this instruction:
>>
>> c03390cc: ee013f30 mcr 15, 0, r3, cr1, cr0, {1}
>>
>> which corresponds to set_auxcr IIUC.
> ...
>> According to the Cortex A9 documentation,
>> ACTLR is RO in non-secure mode if NSACR[18]=0 and RW if NSACR[18]=1
>>
>> I suppose writing to a RO register cause the exception I see?
> 
> It should not, the write should be ignored and no exception should be
> raised.

Interesting.

>> Commit 8abd259f657d5 ("l2c: provide generic hook to intercept
>> writes to secure registers") introduced a mechanism for non-secure
>> platforms to define how to write to the L2CC AUXCTRL register.
> 
> Wrong register.  This is the _CPU_ auxiliary control register, not the
> L2CC auxiliary control register.

Right.

>> Is there a similar mechanism for asking the firmware to write
>> to the CP15 ACTRL?
> 
> That's entirely dependent on the secure monitor implementation.  ARM Ltd
> didn't listen to me originally when I said there needs to be a spec for
> that, so there's no standardised way to talk to it, sorry.

My question was ambiguous. I didn't mean to ask how to interact
with the firmware, but rather if there existed some way to prevent
Linux from just writing the CP15 ACTRL, and instead go through
a platform-specific function (as you provided for L2CC AUXCTRL).

> Now, you've quoted one line from the oops, and a load of information that
> we already know (because we have access to the manuals).  You've omitted
> the rest of the oops, which is information we don't know, and is information
> that we, as kernel developers, have decided that the kernel should print
> to allow _us_, on the receiving end of an oops, to be able to diagnose
> what happened and why.
> 
> Please, if you get an oops, include the _full_ dump when reporting
> problems, even if you've diagnosed it already.  Not only does it help to
> confirm the diagnosis, but it also serves as a source of documentation
> if/when we commit a change to solve it.

I didn't provide the full oops because I don't know how to enable
early_printk on my platform. My ad-hoc method is attaching a debugger,
stop in panic() and examine the __log_buf array.

Can I just dump the relevant part of the unformatted log?

Regards.
