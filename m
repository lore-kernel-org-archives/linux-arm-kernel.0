From: mathieu.desnoyers@efficios.com (Mathieu Desnoyers)
Date: Tue, 17 Aug 2010 22:09:53 -0400
Subject: [RFC PATCH 01/20] Create generic alignment API (v8)
In-Reply-To: <1282094726.3268.2197.camel@gandalf.stny.rr.com>
References: <20100817231619.277457797@efficios.com>
	<20100817232150.251244768@efficios.com>
	<1282094726.3268.2197.camel@gandalf.stny.rr.com>
Message-ID: <20100818020953.GA10401@Krystal>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Steven Rostedt (rostedt at goodmis.org) wrote:
> On Tue, 2010-08-17 at 19:16 -0400, Mathieu Desnoyers wrote:
> 
> > +/*
> > + * Align pointer on natural object alignment. Object size must be power of two.
> > + */
> 
> Hmm, I wonder if we should add a compiler bug here too.
> 
> extern void __bug_obj_not_power_of_two(void);
> 
> ({
> 	if ((sizeof(*obj) - 1) & sizeof(*obj))
> 		__bug_obj_not_power_of_two();
> 	PTR_ALIGN((obj), __alignof__(*(obj)));
> })

[...]

Nevermind the "Object size must be power of two." part of the comment. That was
true when I first implemented the patch, where I used sizeof(), e.g.:

#define object_align(obj)       PTR_ALIGN(obj, sizeof(*(obj)))
#define object_align_floor(obj) PTR_ALIGN_FLOOR(obj, sizeof(*(obj)))

But given that we can expect structures and various objects to be passed as
parameters, __alignof__ is more appropriate. This is what this patch now
implements:

#define object_align(obj)       PTR_ALIGN(obj, __alignof__(*(obj)))
#define object_align_floor(obj) PTR_ALIGN_FLOOR(obj, __alignof__(*(obj)))

so we let gcc determine the appropriate alignment. It will automatically be a
power of two. I'll just update the comment.

[...]

> I take it that theses functions can have variables passed to it for
> alignment, thus a check wont help. Although, we could add a test for the
> constant case.

That's right. I could add something like:

  MAYBE_BUILD_BUG_ON_NOT_POWER_OF_2(alignment);

which will add a dependency on kernel.h (for MAYBE_BUILD_BUG_ON) and log2.h (for
is_power_of_2). I'll move the #include <linux/align.h> further down in kernel.h,
keeping it outside of #ifdef __KERNEL__.

To make sure this build test works when a constant is passed to offset_align or
offset_align_floor, I'll have to turn them into macros instead of static
inlines.

The next round will have a patch that adds "MAYBE_BUILD_BUG_ON_NOT_POWER_OF_2"
to kernel.h.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
