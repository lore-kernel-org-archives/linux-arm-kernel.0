From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 17 Feb 2011 10:51:56 -0700
Subject: [PATCH 2/2] ARM: remove the 4x expansion presumption while
	decompressing the kernel
In-Reply-To: <20110217092617.GB24627@n2100.arm.linux.org.uk>
References: <1297892343-29064-1-git-send-email-nico@fluxnic.net>
	<1297892343-29064-2-git-send-email-nico@fluxnic.net>
	<20110217000923.GF2364@angua.secretlab.ca>
	<20110217092617.GB24627@n2100.arm.linux.org.uk>
Message-ID: <20110217175156.GB31812@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 17, 2011 at 09:26:17AM +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 16, 2011 at 05:09:23PM -0700, Grant Likely wrote:
> > Patch looks good to me, but on a related note, I'm looking for a way
> > to also find the end of .bss.
> > 
> > When John looks at adding support for appending an initrd and/or dtb
> > to the zimage, it will be important to make sure the start of the
> > initrd/dtb does not overlap the ram the kernel is expecting to be
> > empty and available.
> 
> Appending data to the zImage has already been solved with the 'bootp'
> stuff - and I'm afraid to say that merely catting a zImage with something
> else just isn't going to work.  There's no way for the zImage decompressor
> to know that there's anything on the end of the image, and there's no way
> for it to know where it can relocate itself to or where in memory it can
> safely decompress to in such scenarios.

Even with weird memory, looking for an image header immediately after
the end of the image is a pretty safe thing to do.  As long as the
type and size of the appended data can be determined from the data
header it should work just fine.  John is investigating this now for
compressed ramdisks.

As for knowing where it can relocate to, we already know (actually
current code just makes an assumption) about how long the kernel
proper image is and where it wants to live in the zImage's head.S.
Assuming enough ram, if r6 reflects the size of the zImage + the size
of the appended data then it should be good.

> 
> While such stuff may be possible with architectures where you know memory
> always starts at zero and extends contiguously for N MB where N is some
> number larger than 16, we don't have that luxury on ARM.  Sometimes it
> might be in 4MB chunks scattered throughout the physical address space
> at maybe 256MB offset from zero.  Or maybe 32MB chunks starting at 3GB.
> etc.

Of course this makes assumptions about the size of memory available
to the image (which the current zImage also does), and that it is safe
to use a large hunk of ram immediately after the zImage.  If your
system has weird memory, then you *have* to know the constraints of
your system and make sure the zImage (+ appended data) is:

  1) in a region large enough to hold it, and
  2a) doesn't overlap what the kernel proper needs, or
  2b) has enough space behind it that it can be relocated safely
      before uncompressing the kernel

This is not really any different from today, the zImage still must
make assumptions about where it can do a relocation to or from (either
by relocating vmlinux after decompressing as in current code, or by
relocating the wrapped image before decompressing as in Nicolas'
patch). The data size can be up being a lot larger though.

So, I agree, when RAM is weird this may not be feasible, but there are
also a large number of systems where ram is *not* weird and this is a
useful feature...

Actually concerning this; the initial work that John completed was to
meet the requirements of a client.  I posted it for interest sake, but
I wasn't planning to try and get it merged.  I didn't think it would
be of much use outside of my client's use case, but after talking with
Nicolas and others we decided it could be useful and we're going to
spend the time to see if we can make it a general solution.  If it
doesn't work, then all we've lost is a bit of time, but I do think it
is a viable feature.

g.


> 
> And that's why the 'bootp' stuff takes a fixed address for where to
> locate the initrd - the only person who knows where its safe to do so is
> the person building the image for the platform.
