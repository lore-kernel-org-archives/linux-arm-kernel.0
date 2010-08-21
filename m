From: mathieu.desnoyers@efficios.com (Mathieu Desnoyers)
Date: Sat, 21 Aug 2010 14:40:15 -0400
Subject: [PATCH for -tip 1/2] kernel.h: add
	MAYBE_BUILD_BUG_ON_NOT_POWER_OF_2
In-Reply-To: <20100821182623.GA9621@core2.telecom.by>
References: <20100821141750.770348530@efficios.com>
	<20100821142215.023431313@efficios.com>
	<20100821182623.GA9621@core2.telecom.by>
Message-ID: <20100821184015.GA17805@Krystal>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Alexey Dobriyan (adobriyan at gmail.com) wrote:
> On Sat, Aug 21, 2010 at 10:17:51AM -0400, Mathieu Desnoyers wrote:
> > +/* Force a compilation error if condition is constant and not a power of 2 */
> > +#define MAYBE_BUILD_BUG_ON_NOT_POWER_OF_2(n)		\
> > +	MAYBE_BUILD_BUG_ON((n) == 0 || (((n) & ((n) - 1)) != 0))
> 
> Sorry, this is tasteless macro.

Let's look at the surrounding where I added this macro in kernel.h:


/* Force a compilation error if condition is true */
#define BUILD_BUG_ON(condition) ((void)BUILD_BUG_ON_ZERO(condition))

/* Force a compilation error if condition is constant and true */
#define MAYBE_BUILD_BUG_ON(cond) ((void)sizeof(char[1 - 2 * !!(cond)]))

/* Force a compilation error if a constant expression is not a power of 2 */
#define BUILD_BUG_ON_NOT_POWER_OF_2(n)			\
	BUILD_BUG_ON((n) == 0 || (((n) & ((n) - 1)) != 0))

/* Force a compilation error if condition is true, but also produce a
   result (of value 0 and type size_t), so the expression can be used
   e.g. in a structure initializer (or where-ever else comma expressions
   aren't permitted). */
#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
#define BUILD_BUG_ON_NULL(e) ((void *)sizeof(struct { int:-!!(e); }))


So I am guessing that you plan to rewrite all of these ? Or perharps you have
other suggestions ? Commit cc8ef6eb21e964b1c5eb97b2d0e8ac9893e1bf86 introduced
"BUILD_BUG_ON_NOT_POWER_OF_2()" btw.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
