From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 23 May 2018 16:34:14 +0200
Subject: [PATCH RT] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
In-Reply-To: <20180518124605.GA13470@e103592.cambridge.arm.com>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
 <20180517181932.GW7753@e103592.cambridge.arm.com>
 <20180518124605.GA13470@e103592.cambridge.arm.com>
Message-ID: <20180523143414.3oqpzt7cujvkxxve@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-05-18 13:46:36 [+0100], Dave Martin wrote:
> On Thu, May 17, 2018 at 07:19:43PM +0100, Dave Martin wrote:
> 
> [...]
> 
> > kernel_neon_begin() could then do
> > 
> > 	local_fpsimd_context_lock();
> > 
> > 	/* ... */
> > 
> > 	preempt_disable();
> > 	local_unlock(fpsimd_context_lock);
> > 
> > ... with the following in kernel_neon_end():
> > 
> > 	local_unlock(fpsimd_lock);
> > 	preempt_enable();
> > 
> > 
> > If kernel-mode NEON was considered harmful to RT due to the context
> > switch overheads, then the above might be overkill.  SVE will be worse
> > in that regard, and also needs thinking about at some point -- I've not
> > looked at if from the RT angle at all.
> 
> Hmmm, !KERNEL_MODE_NEON breaks EFI, so this probably does want looking
> at.  Ard's recent rework to enable voluntary preemption the crypto
> backends for arm64 [1] should reduce the fpsimd_lock blackouts, but it
> still depends on the backends playing nice.

oh. I've seen the series, I more or less asked for this and I am glad
for it. I will try to unbreak this EFI problem then?
I remember the good old days when the boot loader was gone after it
jumped to the kernel?

> Cheers
> ---Dave

Sebastian
