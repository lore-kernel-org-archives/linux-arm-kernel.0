From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 3 Dec 2015 12:29:44 +0000
Subject: arm64 boot requirements
In-Reply-To: <1449083028.6139.25.camel@infradead.org>
References: <565BAA2E.5090102@cog.systems> <20151201110159.GA4757@leverpostej>
 <1449083028.6139.25.camel@infradead.org>
Message-ID: <20151203122943.GD28731@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 11:03:48AM -0800, Geoff Levand wrote:
> Hi,
> 
> On Tue, 2015-12-01 at 11:02 +0000, Mark Rutland wrote:
> > Pratyush, Geoff, I understood you were loading the kernel vmlinux for
> > kexec. Do you parse the Image header to figure out where to place
> > things?
> 
> Yes, in the kexec user tools we use text_offset to make
> enough room for the kernel, but there is also the need for
> page_offset.
> 
> We need to know the page_offset to be able to do virtual to
> physical address conversions.  We can calculate the page_offset
> for a vmlinux image as page_offset = phdr->p_vaddr - text_offset.

I don't understadn why you need to do that.

Is that just just so you can figure out where to load the segments
physically?

> The binary Image currently has no info about page_offset or
> virtual addressing.  We have a kexec-tools option for the
> user to specify a page_offset.  If that option is not provided
> we try to look at the running kernel's symbols, and if that
> fails, fall back to a default page_offset.  This is less than
> ideal, and certainly makes the binary Image less appealing to
> use with kexec.

I don't follow at all why this complication is necessary. I don't think
that the kexec tools should be looking at the kernel symbols in that
manner, and I don't think that we need to expose the page offset via the
Image header.

The first loaded address in the vmlinux corresponds to PHYS_OFFSET +
TEXT_OFFSET. If you know that, you can figure out an offset to apply to
VAs to convert them to PAs when loading.

What am I missing?

Thanks,
Mark.
