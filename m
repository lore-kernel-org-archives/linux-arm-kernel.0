From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 11 Nov 2009 23:08:11 +0000
Subject: [PATCH] ARM: SAMSUNG: Add plat-samsung as starting point for
	plat-s3c* moves
In-Reply-To: <000001ca620b$2141c080$63c54180$%szyprowski@samsung.com>
References: <1257812406-17360-1-git-send-email-ben-linux@fluff.org>
	<000a01ca61a5$c573d000$505b7000$%kim@samsung.com>
	<9c9fda240911091927m46ed0fccyfbbc8873eb9c5da9@mail.gmail.com>
	<20091110094756.GN4048@prithivi.gnumonks.org>
	<000001ca620b$2141c080$63c54180$%szyprowski@samsung.com>
Message-ID: <20091111230811.GL4808@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 10, 2009 at 02:38:42PM +0100, Marek Szyprowski wrote:
> Hello,
> 
> On Tuesday, November 10, 2009 10:48 AM, Harald Welte wrote:
> 
> > Dear Kyungmin,
> > 
> > On Tue, Nov 10, 2009 at 12:27:15PM +0900, Kyungmin Park wrote:
> > > >
> > > >> We inted to re-organise the plat-s3c/plat-s3c24xx/plat-s3c64xx into a
> > > >> more generic plat-samsung with less code in the other plat- directories
> > > >> to make it easier to port new devices and try and clear up some of the
> > > >> naming issues with newer devices.
> > >
> > > Why do you miss the plat-s5pc1xx? Also add the plat-s5pc1xx series.
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

Did you see my comments on the last series you submitted?
 
> > > Why new plat-s5p is required? The main goal of plat-* directory is
> > > support the SoC common codes.
> > 
> > plat-samsung is intended for stuff that's shared between all the various
> > arm9/arm11/a8 based SoCs.  This is so far in plat-s3c, even though it's
> > not only used (and will not only be used) by s3c parts.
> 
> So most of the current code from plat-s3c (mainly common dev-* platform
> resources, clocks, uart and gpio core functions) would be moved to
> plat-samsung? Right?

As much as possible.
 
> > > Of course s5pc100 and s5pc110 is different features and different IPs
> > > but no need to create each plat directory.
> > 
> > The 6440 shares some things with the c100, and the 6442 shares again
> > some things with the c110.  So putting all those files into one
> > directory seems to make it much easier to share code between the
> > different parts as needed.  Also, it means that we have to do less
> > moving around.
> > 
> > Imagine we continue with one plat-s5p64xx and plat-s5pc1xx, etc. for
> > each new SoC.  Later we detect there is some sharing with an earlier
> > product, then we need to move the file to plat-s5p.  This moving around
> > of files causes breakage in patches that people are having in their
> > private trees before they can move it mainline.
> > 
> > Also, don't you think it is somewhat weird that soon samsung would have
> > as many plat-* directories as all other ARM SoC makers together?
> 
> These multiple plat-* directories for all Samsung chip series are in
> fact a big overhead for kernel tree. I assume that You want to end with
> only one plat-samsung directory. Am I right? What about multiple mach-*
> directories (mach-s3c2400, ..., mach-s3c24a0, mach-s3c6400, mach-s3c6410,
> mach-s5pc100, ...)? Do you plan to keep them? Maybe a multilevel structure
> would be more aproperiate? (mach-samsung/s3c2400, mach-samsung/s3c6400, 
> and so on)?

I'm not sure what you mean by 'big overhead', could you elaborate on
that statement.

I personally do not think multiple plat- directories are much of a problem
and much prefer them to some form of heirarchy as you are discussing here
although there are probably merits either way.

> How do you plan to handle different includes, register map, register
> offset defines, etc in each chip series? Would this result in moving
> the series specific include directories to mach-* directories?

No, each driver header carries all the necessary defines for the
version, since if the driver needs updating it is likely the header
file for that driver will need updating too.

For the maps, these are much more chip specific and will probably
be changed to a more specific name to make them easier to find if
they need to be common.

Part of the device change will be to move to a table based system
where there will be less need to have things defined in header
files.

We also want to try and ensure that <plat/xxx.h> xxx.h items are
unique as possible to avoid finding a large number of matches
for xxx.h in the header files and having to work out which one is
being included.
 
> How can we adapt the current plat-s5pcxx code to better match the
> migration to common plat-samsung directory?

Have a look at the documentation in the pre-release and then make
some comments then (if you need to).

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
