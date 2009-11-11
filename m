From: laforge@gnumonks.org (Harald Welte)
Date: Wed, 11 Nov 2009 13:58:35 +0900
Subject: [PATCH] ARM: SAMSUNG: Add plat-samsung as starting point for
	plat-s3c* moves
In-Reply-To: <000001ca620b$2141c080$63c54180$%szyprowski@samsung.com>
References: <1257812406-17360-1-git-send-email-ben-linux@fluff.org>
	<000a01ca61a5$c573d000$505b7000$%kim@samsung.com>
	<9c9fda240911091927m46ed0fccyfbbc8873eb9c5da9@mail.gmail.com>
	<20091110094756.GN4048@prithivi.gnumonks.org>
	<000001ca620b$2141c080$63c54180$%szyprowski@samsung.com>
Message-ID: <20091111045835.GO4047@prithivi.gnumonks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Tue, Nov 10, 2009 at 02:38:42PM +0100, Marek Szyprowski wrote:
> > 
> > Of course.  The code for the C100, C110, V210, etc. is also subject to
> > this.  Maybe Ben simply wanted to be polite and indicate he does not
> > intend to interfere with your current codebase.  After all, DMC is the
> > maintainer of the C100 support in mainline, and we hope we can have your
> > cooperation with this new structure.  But since we did not ask you yet,
> > we couldn't assume that you would agree.
> 
> We are also interested in improving mainline support for C100 series as
> well as upcoming C110.

Ok.  The general goal of the work that Ben and me have been discussing
and initiating is to remove the amount of code duplication when
introducing support for a new SoC.  Right now, the c100 code contains a
number of copies of the 6410 code, and the 6440 code also copies a lot
from 6410.

A lot of copying was identified in things like the platform device files
(*-dev.c) and the *-clock.c files - which is why that was the starting
point.

There may also be other files up to something like sleep.S where again
much duplication is visible (see my 6440 review mail recently)

> > plat-samsung is intended for stuff that's shared between all the various
> > arm9/arm11/a8 based SoCs.  This is so far in plat-s3c, even though it's
> > not only used (and will not only be used) by s3c parts.
> 
> So most of the current code from plat-s3c (mainly common dev-* platform
> resources, clocks, uart and gpio core functions) would be moved to
> plat-samsung? Right?

I think this is the goal, yes.  I personally don't care too much about
correct naming or correct directory name.  The most important goal is to
prevent/remove copy+paste style code and really have every function only
once, if it is the same or 99% the same on multiple SoCs.

> > Also, don't you think it is somewhat weird that soon samsung would have
> > as many plat-* directories as all other ARM SoC makers together?
> 
> These multiple plat-* directories for all Samsung chip series are in
> fact a big overhead for kernel tree. I assume that You want to end with
> only one plat-samsung directory. 

I think currently having 3 directories: plat-samsung, plat-s3c and
plat-s5p are in the discussion.

> Am I right? What about multiple mach-* directories (mach-s3c2400, ...,
> mach-s3c24a0, mach-s3c6400, mach-s3c6410, mach-s5pc100, ...)? Do you
> plan to keep them? Maybe a multilevel structure would be more
> aproperiate? (mach-samsung/s3c2400, mach-samsung/s3c6400, and so on)?

I think at the moment we're focusing on the plat-* directories first and
try not to change everything at the same time.  I would not propose
freely renaming / moving all directories if this does not at the same
time mean that we can remove code duplication.

> How do you plan to handle different includes, register map, register
> offset defines, etc in each chip series? Would this result in moving
> the series specific include directories to mach-* directories?

I think the details will be worked out while the task is being done.
The actual base addresses for each integrated peripheral will be
provided through a soc-specific table that is passed to the platform
device handling code that ben is working on.
 
> How can we adapt the current plat-s5pcxx code to better match the
> migration to common plat-samsung directory?

I think it is best to first wait for those changes to appear on the
24xx/6410 code in mainline.  We are working with System LSI to add the
6440.  Once that has been implemented and is known to work in next-s3c,
I think you can adapt your code and e.g. remove some code from
s5pc100-clock.c

So for right now, I would recommend to be a bit patient until the core
changes have emerged and stabilized, to avoid wasting your time to
change to a moving target.  

Regards,
-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
