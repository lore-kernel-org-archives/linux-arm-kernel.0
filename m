From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 7 Feb 2012 12:25:30 -0800
Subject: [PATCH 1/2] genalloc: add support of named pool
In-Reply-To: <20120207025212.GA15647@game.jcrosoft.org>
References: <1328466576-29384-1-git-send-email-plagnioj@jcrosoft.com>
 <20120206152028.310656a3.akpm@linux-foundation.org>
 <20120207025212.GA15647@game.jcrosoft.org>
Message-ID: <20120207122530.bb88568a.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 7 Feb 2012 03:52:12 +0100
Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:

> On 15:20 Mon 06 Feb     , Andrew Morton wrote:
> > On Sun,  5 Feb 2012 19:29:35 +0100
> > Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:
> > 
> > > so we can get the pool in the driver by name instead of passing it via
> > > parameter
> > > 
> > > this will be use on AT91 to get access from different drivers to the sram or
> > > gpbr as example
> > > 
> > > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > ---
> > > Hi,
> > > 
> > > 	if you don't mind I'll apply this via at91 tree as it's needed to
> > > 	finish a cleanup on at91 to allow multiple soc in the same kernel
> > 
> > Please do not do this.
> > 
> > The patch is still as buggy as it was when I reviewed it in December. 
> > You didn't reply to my review email and you didn't reply to Steven
> > Rothwell's review email and you fixed almost none of our review
> > comments.
> I did
> 
> all comment from Stephen Rothwell as integrated
> 
> I put the lock on the list as you request
> I drop the race condition
> 
> I put the example
> 
> so what did I miss?
> 

The interface remains racy and cannot be fixed, without a lot of work. 

gen_pool_create_byname() is racy, doing the lookup before taking the
lock.  This bug is easily fixed by doing the lookup while holding the
lock.


gen_pool_byname() returns a pointer to an object which can be released
at any time, so any code which calls gen_pool_byname() cannot safely
use that function's return value!

The way in which the kernel solves this problem is to take a refcount
against the object (while holding the lock).  The caller who obtained
that refcount via the lookup function is responsible for doing some
put() operation on it.  On the last put(), the object is freed.

If a resource is to be shared between multiple subsystems then this
issue should be addressed.


Also, the patch still has coding-style errors, detected by checkpatch.


Also, it is unobvious why we need a "lookup by name" ability.  If a
subsystem want to access another subsystem's exported data structures
then this can be done with globally-scoped C symbols.  But this is just
a different way of doing lookup: the lifetime management issues should
still be addressed.
