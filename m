From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 24 Feb 2016 19:33:40 +0000
Subject: [PATCH v12 1/5] efi: ARM/arm64: ignore DT memory nodes instead
 of removing them
In-Reply-To: <56CDFE6C.4020600@gmail.com>
References: <1456192703-2274-1-git-send-email-ddaney.cavm@gmail.com>
 <1456192703-2274-2-git-send-email-ddaney.cavm@gmail.com>
 <20160223115805.GB4989@leverpostej> <56CDFE6C.4020600@gmail.com>
Message-ID: <20160224193339.GB9003@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2016 at 11:03:08AM -0800, Frank Rowand wrote:
> On 2/23/2016 3:58 AM, Mark Rutland wrote:
> > Hi,
> > 
> > On Mon, Feb 22, 2016 at 05:58:19PM -0800, David Daney wrote:
> >> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >>
> >> There are two problems with the UEFI stub DT memory node removal
> >> routine:
> >> - it deletes nodes as it traverses the tree, which happens to work
> >>   but is not supported, as deletion invalidates the node iterator;
> >> - deleting memory nodes entirely may discard annotations in the form
> >>   of additional properties on the nodes.
> >>
> >> Since the discovery of DT memory nodes occurs strictly before the
> >> UEFI init sequence, we can simply clear the memblock memory table
> >> before parsing the UEFI memory map. This way, it is no longer
> >> necessary to remove the nodes, so we can remove that logic from the
> >> stub as well.
> > 
> > This is a little bit scary, but I guess this works.
> > 
> > My only concern is that when we get kexec, a subsequent kernel must also
> > have EFI memory map support, or things go bad for the next EFI-aware
> > kernel after that (as things like the runtime services may have been
> > corrupted by the kernel in the middle). It's difficult to fix the
> > general case later.
> > 
> > A different option would be to support status="disabled" for the memory
> > nodes, and ignore these in early_init_dt_scan_memory. That way a kernel
> > cannot use memory without first having parsed the EFI memory map, and we
> > can still get NUMA info from the disabled nodes.
> 
> Please do not play games of treating nodes with status="disabled" as
> valid nodes.  The mindset should be if it is disabled, it does not exist.

I completely agree with this generally.

The only possible wiggle room is ePAPR's decription of the precise
meaning of the status property being binding-specific (and there may be
some way to later "enable" the node or otehrwise make use of it). As
with above, we'd only be extracting some information in the presence of
a UEFI memory map.

I agree that this is not a great pattern, and we don't necessarily want
that even for "safe" cases like NUMA.

> There have been two bugs reported in the last week where code should
> have been ignoring disabled nodes and failed to.  An audit of code
> scanning all nodes instead of all enabled nodes is now on my todo list.

That would be great!

Mark.
