From: toddpoynor@google.com (Todd Poynor)
Date: Mon, 27 Jun 2011 13:38:10 -0700
Subject: IRQS off tracer - is it useful or not?
In-Reply-To: <20110625132112.GH23234@n2100.arm.linux.org.uk>
References: <20110625132112.GH23234@n2100.arm.linux.org.uk>
Message-ID: <20110627203810.GD6187@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I used IRQs off tracing on 2.6.36 on Tegra (and am responsible for
sending the fixups to make it work better on ARM).  The tracing did
help find probably 2-3 real problems with drivers performing too much
processing with IRQs disabled (I can go dig up which problems if
that would be useful).  I didn't usually pay close attention
to any values printed that were in the sub-millisecond range, mostly
looking for larger outliers.

I did have a couple of problems with it.  One, as already noted,
the tracing points aren't necessarily positioned such that the
return address points to the caller of interest.  As I recall, it
looked like various config options could change whether the place
with the trace point was called directly by the code of interest
or whether that function was likely to be an intermediary --
options such as CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE=n probably
broke the assumptions, and other things like
CONFIG_DEBUG_LOCK_ALLOC and CONFIG_DEBUG_SPINLOCK could also
affect what was inlined.  I did hack these up to get to the real
caller where I found something of possible interest.

There was another problem with an approximate 2500ms time
delta in impossible places.  I debugged it some and found that
it was likely due to something already been fixed in later kernels,
so I just discarded those results.  (I made a note at the time that it
was probably fixed in 69d1b839 "ring-buffer: Bind time extend and data
events together", but I can't recall the details at the moment.)

Having stuck my neck for out for the feature having some use, I can
volunteer my time to help clean things up if folks think it's worth
it.


Todd
 
