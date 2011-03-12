From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 12 Mar 2011 01:44:53 -0700
Subject: [PATCH] ARM:boot:device tree: Allow the device tree binary to
	be appended to zImage
In-Reply-To: <20110309230542.GC9995@trinity.fluff.org>
References: <20110309215800.26377.43925.stgit@riker>
	<20110309230542.GC9995@trinity.fluff.org>
Message-ID: <20110312084453.GD9347@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2011 at 11:05:42PM +0000, Ben Dooks wrote:
> On Wed, Mar 09, 2011 at 01:58:00PM -0800, John Bonesio wrote:
> > This patch provides the ability to boot using a device tree that is appended
> > to the raw binary zImage (e.g. cat zImage <filename>.dtb > zImage_w_dtb).
> 
> I'd much rather see something that wrappers the kernel and passes the
> DT through an ATAG. So possibly a pre-amble as well?

When DT support was initially implemented for ARM, it did exactly
that.  It passed the dt via an ATAG.  However, that leaves a number of
questions about which data is authoritative, ATAG or DT data.  Nicolas
argued rightly and successfully that if DT was going to be used, then
we should go at it whole hog and make passing a dtb the full boot
interface.

I disagreed strongly at first, but I'm glad to say he convinced me.
In the end the implementation of passing dt directly turned out to be
far more simple and elegant than the hybrid approach was.  In the
current code, a single kernel image can accept either a .dtb or an
ATAGs list (so no backwards compatibility issues) and it detects which
data structure to parse early in setup_arch().

As for this patch, this functionality was implemented for a client and
it is being posted for wider review in case anyone else finds it
useful.  I wasn't originally planning to push for mainline merging of
it, but after positive feedback on the first posting I though it was
probably worth the effort to refine it more and get it into acceptable
shape for mainline.

Regarding using a wrapper; that was the approach I initially wanted to
pursue, but modifying the zImage wrapper was much simpler to implement
because the wrapper has knowledge about how much RAM the kernel needs
at boot and can therefore make a good decision about where to locate
the .dtb before jumping into the kernel.

g.
