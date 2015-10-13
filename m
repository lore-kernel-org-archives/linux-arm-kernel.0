From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 13 Oct 2015 22:38:12 +0200
Subject: [PATCH] mutex: make mutex_lock_nested an inline function
In-Reply-To: <11282238.AHmyWliPRj@wuerfel>
References: <11282238.AHmyWliPRj@wuerfel>
Message-ID: <20151013203812.GM17308@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 10:30:08PM +0200, Arnd Bergmann wrote:
> The second argument of the mutex_lock_nested() helper is only
> evaluated if CONFIG_DEBUG_LOCK_ALLOC is set. Otherwise we
> get this build warning for the new regulator_lock_supply
> function:
> 
> drivers/regulator/core.c: In function 'regulator_lock_supply':
> drivers/regulator/core.c:142:6: warning: unused variable 'i' [-Wunused-variable]
> 
> To avoid the warning, this patch changes the definition of
> mutex_lock_nested() to be static inline function rather than
> a macro, which tells gcc that the variable is potentially
> used.

> -# define mutex_lock_nested(lock, subclass) mutex_lock(lock)
> +static inline void mutex_lock_nested(struct mutex *lock, unsigned int subclass)
> +{
> +	return mutex_lock(lock);
> +}

Can you verify that this results in an identical kernel?

Having this a proper argument results in the compiler having to actually
evaluate the expression resulting in @subclass, this might have side
effects and generate code.

A quick grep shows a large amount of trivial code that optimizers will
still happily throw away, but it should be verified that this does not
result in pointless code generation.
