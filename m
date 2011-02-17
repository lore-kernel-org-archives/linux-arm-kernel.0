From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Feb 2011 09:26:17 +0000
Subject: [PATCH 2/2] ARM: remove the 4x expansion presumption while
	decompressing the kernel
In-Reply-To: <20110217000923.GF2364@angua.secretlab.ca>
References: <1297892343-29064-1-git-send-email-nico@fluxnic.net>
	<1297892343-29064-2-git-send-email-nico@fluxnic.net>
	<20110217000923.GF2364@angua.secretlab.ca>
Message-ID: <20110217092617.GB24627@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 16, 2011 at 05:09:23PM -0700, Grant Likely wrote:
> Patch looks good to me, but on a related note, I'm looking for a way
> to also find the end of .bss.
> 
> When John looks at adding support for appending an initrd and/or dtb
> to the zimage, it will be important to make sure the start of the
> initrd/dtb does not overlap the ram the kernel is expecting to be
> empty and available.

Appending data to the zImage has already been solved with the 'bootp'
stuff - and I'm afraid to say that merely catting a zImage with something
else just isn't going to work.  There's no way for the zImage decompressor
to know that there's anything on the end of the image, and there's no way
for it to know where it can relocate itself to or where in memory it can
safely decompress to in such scenarios.

While such stuff may be possible with architectures where you know memory
always starts at zero and extends contiguously for N MB where N is some
number larger than 16, we don't have that luxury on ARM.  Sometimes it
might be in 4MB chunks scattered throughout the physical address space
at maybe 256MB offset from zero.  Or maybe 32MB chunks starting at 3GB.
etc.

And that's why the 'bootp' stuff takes a fixed address for where to
locate the initrd - the only person who knows where its safe to do so is
the person building the image for the platform.
