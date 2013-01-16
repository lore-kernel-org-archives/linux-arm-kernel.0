From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 16 Jan 2013 13:03:29 +0100
Subject: [PATCH v7 1/3] ARM: make cr_alignment read-only #ifndef
 CONFIG_CPU_CP15
In-Reply-To: <50F554C4.3020903@arm.com>
References: <1350462872-16805-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1350462872-16805-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <50F554C4.3020903@arm.com>
Message-ID: <20130116120329.GX14860@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jonny,

On Tue, Jan 15, 2013 at 01:08:20PM +0000, Jonathan Austin wrote:
> On 17/10/12 09:34, Uwe Kleine-K?nig wrote:
> >This makes cr_alignment a constant 0 to break code that tries to modify
> >the value as it's likely that it's built on wrong assumption when
> >CONFIG_CPU_CP15 isn't defined. For code that is only reading the value 0
> >is more or less a fine value to report.
> >
> 
> Without the context of some of the discussion that was had on the
> list about how/why to do this, this description is a bit
> confusing...
> 
> I found myself asking "Why do we not #ifdef out uses of cr_alignment
> based on CONFIG_CPU_CP15" - a question which it seems is answered by
> you and Nicolas here:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/089968.html
> 
> So, perhaps it would help to have a little bit more context in this
> commit message?
> 
> I know that the cr_alignment stuff is currently tied up with
> CONFIG_CPU_15, but I wonder if you looked at using the
> CCR.UNALIGN_TRP bit and wiring that in to alignment trapping code?
> Is it something you think would make sense for the work you're
> doing?
I didn't, because I focus on getting the machine up and add bells and
whistles later.

> >+#ifdef CONFIG_CPU_CP15
> >  	.long	cr_alignment			@ r7
> >+#else
> >+	.long	0
> 
> This value still gets loaded in to r7, so it might be worth keeping
> the comments going... They certainly help when reading the code.
ok

> >--- a/arch/arm/mm/mmu.c
> >+++ b/arch/arm/mm/mmu.c
> >@@ -97,6 +97,7 @@ static struct cachepolicy cache_policies[] __initdata = {
> >  	}
> >  };
> >
> >+#ifdef CONFIG_CPU_CP15
> >  /*
> >   * These are useful for identifying cache coherency
> >   * problems by allowing the cache or the cache and
> >@@ -195,6 +196,22 @@ void adjust_cr(unsigned long mask, unsigned long set)
> >  }
> >  #endif
> >
> >+#else
> 
> When you read this file in its complete form there's a lot of code
> (including more preprocessor stuff) between the #ifdef and the
> #else.
> 
> Could you add
> 
> #else /* ifdef CONFIG_CPU_CP15 */
> 
> like you have in the other cases?
also ok.

Will fix up after lunch.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
