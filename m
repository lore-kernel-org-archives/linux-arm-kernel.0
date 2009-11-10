From: laforge@gnumonks.org (Harald Welte)
Date: Tue, 10 Nov 2009 18:47:56 +0900
Subject: [PATCH] ARM: SAMSUNG: Add plat-samsung as starting point for
	plat-s3c* moves
In-Reply-To: <9c9fda240911091927m46ed0fccyfbbc8873eb9c5da9@mail.gmail.com>
References: <1257812406-17360-1-git-send-email-ben-linux@fluff.org>
	<000a01ca61a5$c573d000$505b7000$%kim@samsung.com>
	<9c9fda240911091927m46ed0fccyfbbc8873eb9c5da9@mail.gmail.com>
Message-ID: <20091110094756.GN4048@prithivi.gnumonks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kyungmin,

On Tue, Nov 10, 2009 at 12:27:15PM +0900, Kyungmin Park wrote:
> >
> >> We inted to re-organise the plat-s3c/plat-s3c24xx/plat-s3c64xx into a
> >> more generic plat-samsung with less code in the other plat- directories
> >> to make it easier to port new devices and try and clear up some of the
> >> naming issues with newer devices.
> 
> Why do you miss the plat-s5pc1xx? Also add the plat-s5pc1xx series.

Of course.  The code for the C100, C110, V210, etc. is also subject to
this.  Maybe Ben simply wanted to be polite and indicate he does not
intend to interfere with your current codebase.  After all, DMC is the
maintainer of the C100 support in mainline, and we hope we can have your
cooperation with this new structure.  But since we did not ask you yet,
we couldn't assume that you would agree.

> Why new plat-s5p is required? The main goal of plat-* directory is
> support the SoC common codes.

plat-samsung is intended for stuff that's shared between all the various
arm9/arm11/a8 based SoCs.  This is so far in plat-s3c, even though it's
not only used (and will not only be used) by s3c parts.

> Of course s5pc100 and s5pc110 is different features and different IPs
> but no need to create each plat directory.

The 6440 shares some things with the c100, and the 6442 shares again
some things with the c110.  So putting all those files into one
directory seems to make it much easier to share code between the
different parts as needed.  Also, it means that we have to do less
moving around.

Imagine we continue with one plat-s5p64xx and plat-s5pc1xx, etc. for
each new SoC.  Later we detect there is some sharing with an earlier
product, then we need to move the file to plat-s5p.  This moving around
of files causes breakage in patches that people are having in their
private trees before they can move it mainline. 

Also, don't you think it is somewhat weird that soon samsung would have
as many plat-* directories as all other ARM SoC makers together?

So the strategy for now is:

* introduce plat-samsung and plat-s5p
* implement some core changes regarding clock and platform_device to
  share more code between 6410, 6440, c100 (and sometimes also 24xx)
* introduce the s3c6440 core architecture code in plat-s5p
* introduce the smdk6440 support

After that is done and has stabilized, the idea is to
* complete the 6440 arch code with features like voltage scaling, dma,
  etc., submit more device drivers or update the mainline drivers to
  work on the 6440
* in parallel also think about converting the c100 code to use more of
  the new common code (clock, platform device and possibly more)

The System LSI focus at the moment is the 6440.  After that, V210 and
C100 are next on the priority scale (in that order).  So I think any
help that DMC can offer on completing the C100 codebase is appreciated
very much.  I don't expect any conflicts, as System LSI is working
on other parts meanwhile.

Regards,
	Harald
-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
