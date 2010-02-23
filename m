From: rabin@rab.in (Rabin Vincent)
Date: Wed, 24 Feb 2010 00:11:04 +0530
Subject: [PATCH 04/10] ARM: ftrace: allow building without frame pointers
In-Reply-To: <1266948185.24271.6079.camel@gandalf.stny.rr.com>
References: <1266090518-31120-1-git-send-email-rabin@rab.in>
	<1266090518-31120-5-git-send-email-rabin@rab.in>
	<20100222190516.GJ5055@nowhere> <1266931113.19540.5.camel@frodo>
	<20100223171112.GC5357@nowhere> <20100223175807.GB5836@debian>
	<1266948185.24271.6079.camel@gandalf.stny.rr.com>
Message-ID: <20100223184104.GA6325@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2010 at 01:03:05PM -0500, Steven Rostedt wrote:
> On Tue, 2010-02-23 at 23:28 +0530, Rabin Vincent wrote:
> > The easiest option to have a more obvious message than a linker error
> > would be to add something like this in entry-common.S:
> > 
> >   #if (__GNUC__ < 4 || (__GNUC__ == 4 && __GNUC_MINOR__ < 4)) \
> > 	&& !defined(OLD_MCOUNT)
> >   #warning Ftrace on GCC < 4.4 requires frame pointers
> >   #endif
> > 
> > Messages like this are also present in other places in ARM (for example
> > arch/arm/kernel/unwind.c), so this wouldn't be this first.
> > 
> > Note that the above message would help in all cases except the one where
> > someone builds the kernel with !fp and GCC 4.4+, and then builds a
> > module with an older GCC.  That would still be only a linker error.
> 
> I was going to recommend the #if above. But shouldn't it be a #error
> instead of a #warning?

Yes, I'll make it a #error.

(I had it at #warning in case some one had a custom compiler that had
the new mcount patch backported, and chose to ignore the warning.  But
it's probably better to leave it at #error and see if someone actually
complains about it, rather than have someone miss the message with it as
a #warning.)

Rabin
