From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 25 Jan 2010 11:44:36 +0000
Subject: Default machine include placements
In-Reply-To: <20100125110116.GB16340@n2100.arm.linux.org.uk>
References: <20100125040255.GN26562@trinity.fluff.org>
	<20100125104956.GP26562@trinity.fluff.org>
	<20100125110116.GB16340@n2100.arm.linux.org.uk>
Message-ID: <20100125114436.GR26562@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2010 at 11:01:16AM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 25, 2010 at 10:49:56AM +0000, Ben Dooks wrote:
> > On Mon, Jan 25, 2010 at 04:02:56AM +0000, Ben Dooks wrote:
> > > Currently in the s3c/s5p familt we're seeing quite a number of the
> > > same things being repeated for items like entry-macro.S, hardware.h
> > > and so on.
> > > 
> > > The first question is about adding include/mach directories to
> > > eitehr plat-s5p or plat-samsung to mop up the files that keep
> > > getting repeated (since the plat-* directories are processed after
> > > the machine directory includes the mach-xxx are still free to overide
> > > these as necessary)
> > 
> > As context, this is part of the work that I am currently doing with
> > Samsung to improve the mainlining of the newer SoC series. Part of this
> > is to try and cut down on the amount of repetition that gets done by
> > some of the porting teams. This is generally to stop things like the
> > replication of the serial drivers or ending up with complete new copies
> > of the SDHCI core simply because they could.
> 
> Changing the policy wrt include files isn't going to stop drivers
> and core code being copy-n-edited.
> 
> The copy-n-edit is a culture thing - it's something that people
> needlessly do because that's how they've worked in the past and don't
> know any better.  The solution to that is education, not changing the
> way we layout files in the kernel tree.

This is an unfortunate side-effect of the education process, having
looked ast te s5p6440 code that is already queued for merging and the
s5pv210 code that is currently in review, there are a number of header
files that are common, for example:

<mach/hardware.h> which is 18 lines long has three lines different:

linux at linux-laptop:~/bjd.git$ diff -u arch/arm/mach-s5pv210/include/mach/hardware.h  arch/arm/mach-s5p6440/include/mach/hardware.h 
--- arch/arm/mach-s5pv210/include/mach/hardware.h       2010-01-25 20:31:01.000000000 +0900
+++ arch/arm/mach-s5p6440/include/mach/hardware.h       2010-01-22 10:50:22.000000000 +0900
@@ -1,9 +1,9 @@
-/* linux/arch/arm/mach-s5pv210/include/mach/hardware.h
+/* linux/arch/arm/mach-s5p6440/include/mach/hardware.h
  *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
  *
- * S5PV210 - Hardware support
+ * S5P6440 - Hardware support
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as

The same is with <mach/system.h> where for 26 lines and have the same
three differences due to copyright date and placemeent.

With the map files, it isn't so bad as each chip does have differences
in the phyiscal addresses of hte peripheral blocks (yay) and thus we
can easily abstract the same data into a platform include with a unique
name.

As long as we have a clear policy then it makes it easier, my main worry
is that I've spent quite a lot of time trying to ensure that things are
not being duplicated and then have to turn around and say 'but not here'
and then end up having to try and ensure that the whole process does not
end up failing.

As a last comment, is a header file such as <mach/entry-macro.S> allowed
to be simply a copyright statement followed by including a platform
include file, as so:

/*
 * arch/arm/mach-foo/include/mach/entry-macro.S
 *
 * Copyright 2010 FooCorp
 *
 * Licensed under GPLv25B
*/

#include <plat/entry-macro-common-foocorp.S>

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
