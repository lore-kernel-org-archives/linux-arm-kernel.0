From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Mar 2013 20:13:42 +0000
Subject: [PATCH] irqchip: Add support for ARMv7-M's NVIC
In-Reply-To: <20130312192702.GQ15375@pengutronix.de>
References: <1363103673-24720-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130312160101.GW4977@n2100.arm.linux.org.uk>
 <20130312192702.GQ15375@pengutronix.de>
Message-ID: <20130312201342.GY4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 08:27:02PM +0100, Uwe Kleine-K?nig wrote:
> On Tue, Mar 12, 2013 at 04:01:01PM +0000, Russell King - ARM Linux wrote:
> > On Tue, Mar 12, 2013 at 04:54:33PM +0100, Uwe Kleine-K?nig wrote:
> > > +#include <asm/irq.h>
> > > +#include <asm/io.h>
> > 
> > linux/io.h
> > 
> > > +	unsigned int irqs, i, irq_base;
> > > +
> > > +	irq_base = irq_alloc_descs(-1, 16, irqs - 16, numa_node_id());
> > > +	if (IS_ERR_VALUE(irq_base)) {
> > 
> > Erm... irq_alloc_descs() returns a negative number on error.
> > 
> > 	if ((int)irq_base < 0)
> > 
> > or make irq_base an int, and use:
> > 
> > 	if (irq_base < 0)
> Just for me: So the check using IS_ERR_VALUE is as wrong as the other
> occurences in arch/arm that you just kicked out or is it just ugly?

See my recent patch removing all but one.

What we're suffering from here is a mentality problem - one which seems
to be basically this:

	If a macro exists which looks like it does the job I need,
	I must use it.  I won't look at the function and check its
	range of values that it returns, I'll just use it and hope
	it's the right thing.

The IS_ERR_VALUE() patch and my IS_ERR_OR_NULL() patches, I've spent on
each one less than a minute, greping, reading the function, checking its
range of return values, sometimes longer if I need to look at other
functions, and worked out what the valid range of return values are.

However, the general pattern in the kernel is this:

	For any function that returns an int, values of success will
	be positive.  Values indicating errors will be negative.

There are very few int-returning functions which violate that.  There
is one big, well known exception, and that's in the mmap() stuff,
where there's a need to return valid values in the range (0..TASK_SIZE)
but differentiate them from -ve errnos.  This is where IS_ERR_VALUE()
came from, and why it was created.  See 07ab67c8d0d7c (Fix
get_unmapped_area sanity tests).


Today, it seems that IS_ERR_VALUE() is now being used just as a subsitute
for testing for < 0... and it needs to stop.  See above - unless there's
a *good* reason, treat +ve values as success, -ve values as failure from
functions returning int.  Always design functions in the kernel like that.
Again - unless there's a *good* reason like needing to return 0..TASK_SIZE.
