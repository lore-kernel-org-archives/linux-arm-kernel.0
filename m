From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 14 Oct 2015 10:20:50 +0200
Subject: [PATCH] mutex: make mutex_lock_nested an inline function
In-Reply-To: <11817958.z9KtmeKzV7@wuerfel>
References: <11282238.AHmyWliPRj@wuerfel>
 <20151013203812.GM17308@twins.programming.kicks-ass.net>
 <11817958.z9KtmeKzV7@wuerfel>
Message-ID: <20151014082050.GQ17308@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > On Tue, Oct 13, 2015 at 10:30:08PM +0200, Arnd Bergmann wrote:
> > > The second argument of the mutex_lock_nested() helper is only
> > > evaluated if CONFIG_DEBUG_LOCK_ALLOC is set. Otherwise we
> > > get this build warning for the new regulator_lock_supply
> > > function:
> > > 
> > > drivers/regulator/core.c: In function 'regulator_lock_supply':
> > > drivers/regulator/core.c:142:6: warning: unused variable 'i' [-Wunused-variable]
> > > 
> > > To avoid the warning, this patch changes the definition of
> > > mutex_lock_nested() to be static inline function rather than
> > > a macro, which tells gcc that the variable is potentially
> > > used.

Uuh, I just looked at next and saw this regulator_lock_supply()
function. How is that limited? subclass must be <8 otherwise bad things
happen.
