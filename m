From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 21 May 2014 11:18:09 +0100
Subject: [PATCH 4/4] arm64: Enable TEXT_OFFSET fuzzing
In-Reply-To: <20140520160827.GK3663@leverpostej>
References: <1400233839-15140-1-git-send-email-mark.rutland@arm.com>
 <1400233839-15140-5-git-send-email-mark.rutland@arm.com>
 <20140516140606.GH5624@arm.com>
 <20140516165548.GA14766@leverpostej>
 <20140520141126.GA1752@bill-the-cat>
 <20140520160827.GK3663@leverpostej>
Message-ID: <20140521101809.GD17827@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 05:08:27PM +0100, Mark Rutland wrote:

[...]

> > > The 16B increment is required due to some code in head.S (__turn_mmu_on)
> > > requiring a minimum 16B alignment for the object.
> > > 
> > > The 2MB maximum comes from the fact we rely on the start of memory being
> > > 2MB aligned. I'm not sure there's a compelling reason to limit the
> > > randomization if enabled at all -- either you can handle it or you
> > > can't. Are we ever likely to want an offset larger than the memory
> > > alignment?
> > 
> > A reason to limit the randomization is to make it easier on the
> > bootloaders to be able to rule of thumb initial loads.  It's not a big
> > deal with Image if it gets loaded lower than the offset, we can start
> > shifting data at the end.  But when we start looking at Image.gz (or xz
> > or ...), in some cases we'll get the whole image read into memory (network
> > booting for example), uncompress the first block so we can confirm a
> > good Image header and see about text_offset/image_size.  If we know that
> > text_offset is somewhere random inside of 2MB (or some other documented
> > max), we can then go with saying an initial load should be at say +32MB
> > (to mirror Documentation/arm/Booting).  If it can be anywhere, then
> > things get hard, or at least annoying (error out and tell the user to
> > re-load things because of a random value?  I can see testing frameworks
> > being annoyed about that).
> 
> Ouch, that is somewhat painful.
> 
> I don't think we expect to see a text_offset larger than 2MB, and I
> can't immediately see why we'd care about any particular text offset
> assuming the page tables are at the end of the runtime image. That said,
> I'm not completely clear on the history of the text_offset.
> 
> > And we should document the range of the offset in
> > Documentation/arm64/booting.txt as well.
> 
> As far as I am aware, we have a 64-bit field specifically to allow for
> an arbitrarily large value, so placing limitations on that may be a
> little difficult.
> 
> As stated above, I don't think there'd be a reason for having a
> text_offset larger than our memory alignment restriction (2MB), but
> there may be something I've missed. If others are reasonably confident
> with an upper limit, I'd be happy to go with it.

Having thought about it a little more, the primary reason for having
text_offset is to allow for memory below the kernel to be addressable.
If we decouple the linear mapping from the kernel text mapping this
would not be a problem -- we'd be able to load the kernel at any
2MB-aligned address + text_offset and use memory below it.

So I think we could get away with limiting text_offset to 2MB.

Cheers,
Mark.
