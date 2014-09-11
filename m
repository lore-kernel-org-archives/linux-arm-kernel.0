From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 11 Sep 2014 12:07:35 +0200
Subject: [PATCH 1/2] ARM: cache-l2x0: clean up aurora cache handling
In-Reply-To: <5286718.xUAA8Uddjq@wuerfel>
References: <2852268.nkG1OoBDfE@wuerfel> <3459745.mC0zoLRDxy@wuerfel>
 <20140911105441.7876966a@free-electrons.com>
 <5286718.xUAA8Uddjq@wuerfel>
Message-ID: <20140911120735.127542e7@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Thu, 11 Sep 2014 11:50:29 +0200, Arnd Bergmann wrote:

> > I am fine with this one, but I'm wondering what is the benefit of doing
> > this? The l2x0_base is anyway a global variable that is available for
> > all those functions, so not sure what an additional local variable
> > brings us.
> 
> The compiler does not always know if the l2x0_base pointer has changed
> between two accesses. In particular if we do a spin_lock/spin_unlock
> as in aurora_pa_range() it has to reload it.
> 
> Using a local variable tells the compiler that the pointer should
> in fact be read once from memory and then used from a register,
> which results in slightly smaller and more efficient object code.

Ok, thanks for the explanation, makes sense.

> Interesting. If that is the intention of the code, it is rather broken
> because CONFIG_CACHE_PL310 gets set automatically on ARMv7:
> 
> if CACHE_L2X0
> 
> config CACHE_PL310
>         bool
>         default y if CPU_V7 && !(CPU_V6 || CPU_V6K)
>         help
>           This option enables optimisations for the PL310 cache
>           controller.
> ...
> endif
> 
> This is from the original l2x0 code that is no longer used by anything
> other than aurora. The idea was apparently that if we are on a v6+v7
> kernel, we might have a l210 and need to wait here, while on a v7-only
> kernel, we know that we have a pl310 and never need to do it.
> 
> > > -static inline void cache_sync(void)
> > > -{
> > > -     void __iomem *base = l2x0_base;
> > > -
> > > -     writel_relaxed(0, base + sync_reg_offset);
> > > -     cache_wait(base + L2X0_CACHE_SYNC, 1);
> > 
> > So to me, this line is actually doing something on an Aurora cache
> > controller.
> > 
> > Am I missing something?
> 
> It might be needed, I haven't checked the data sheet. However we don't
> run that code today, and my patch does not change that.

I just checked the datasheet, and about the L2 Cache Sync register, it
says:

  Writing to this register performs a draining operation of the L2
  eviction buffer. The write operation is when all maintenance
  operations of the issuing CPU are finished, and the eviction buffer
  is empty. This is an automatic operation, the L2 slave ports are
  stalled until the operation is completed.
  The written data is ignored.

So there is indeed no need to poll this register to see when the Sync
operation has completed: writing to the register already stalls the L2
slave ports until the operation is completed.

Moreover, I checked Marvell's LSP, and then indeed also only write to
the L2 Cache Sync register, without any busy wait loop. So your patch
looks good to me.

Thanks for the additional explanations!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
