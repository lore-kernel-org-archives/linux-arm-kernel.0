From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Sep 2014 12:20:42 +0200
Subject: [PATCH] ARM: cache-l2x0: optimize aurora range operations
In-Reply-To: <20140911120839.59d4b728@free-electrons.com>
References: <2852268.nkG1OoBDfE@wuerfel> <2885617.4rXk1QzsZ5@wuerfel>
 <20140911120839.59d4b728@free-electrons.com>
Message-ID: <3371190.Z44AUJudFN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 September 2014 12:08:39 Thomas Petazzoni wrote:
> On Mon, 08 Sep 2014 22:43:32 +0200, Arnd Bergmann wrote:
> > The aurora_inv_range(), aurora_clean_range() and aurora_flush_range()
> > functions are highly redundant, both in source and in object code, and
> > they are harder to understand than necessary.
> > 
> > By moving the range loop into the aurora_pa_range() function, they
> > become trivial wrappers, and the object code start looking like what
> > one would expect for an optimal implementation.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/arm/mm/cache-l2x0.c | 67 +++++++++++++++++-----------------------------------------
> >  1 file changed, 22 insertions(+), 45 deletions(-)
> 
> Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>  (on Armada 370 RD and Armada XP GP, boot tested, plus a little bit of
>  DMA traffic by reading data from a SD card)
> 

Ok, thanks!

I wonder if it's worth doing benchmarks over this, as there is still a
little optimization potential in the range function if we hold the
spinlock a little longer. Right now we drop and reacquire the lock
for every 1024 bytes being flushed, which can cause a lot of traffic
on the coherency bus if we flush really long ranges.

We could hold the lock across the entire loop to improve that, but
that can also cause extra latency if multiple CPUs try to do cache
operations simultaneously.

	Arnd
