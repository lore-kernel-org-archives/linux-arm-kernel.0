From: robh@kernel.org (Rob Herring)
Date: Tue, 23 Feb 2016 16:12:02 -0600
Subject: [PATCH v12 1/5] efi: ARM/arm64: ignore DT memory nodes instead
 of removing them
In-Reply-To: <20160223115805.GB4989@leverpostej>
References: <1456192703-2274-1-git-send-email-ddaney.cavm@gmail.com>
 <1456192703-2274-2-git-send-email-ddaney.cavm@gmail.com>
 <20160223115805.GB4989@leverpostej>
Message-ID: <20160223221202.GA32031@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2016 at 11:58:05AM +0000, Mark Rutland wrote:
> Hi,
> 
> On Mon, Feb 22, 2016 at 05:58:19PM -0800, David Daney wrote:
> > From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > 
> > There are two problems with the UEFI stub DT memory node removal
> > routine:
> > - it deletes nodes as it traverses the tree, which happens to work
> >   but is not supported, as deletion invalidates the node iterator;
> > - deleting memory nodes entirely may discard annotations in the form
> >   of additional properties on the nodes.
> > 
> > Since the discovery of DT memory nodes occurs strictly before the
> > UEFI init sequence, we can simply clear the memblock memory table
> > before parsing the UEFI memory map. This way, it is no longer
> > necessary to remove the nodes, so we can remove that logic from the
> > stub as well.
> 
> This is a little bit scary, but I guess this works.

The way it is worded/implemented is, I agree. But if we simply say both 
can be present and the kernel will default to UEFI memory map, that 
seems sufficient to me.
 
> My only concern is that when we get kexec, a subsequent kernel must also
> have EFI memory map support, or things go bad for the next EFI-aware
> kernel after that (as things like the runtime services may have been
> corrupted by the kernel in the middle). It's difficult to fix the
> general case later.
> 
> A different option would be to support status="disabled" for the memory
> nodes, and ignore these in early_init_dt_scan_memory. That way a kernel
> cannot use memory without first having parsed the EFI memory map, and we
> can still get NUMA info from the disabled nodes.

That would be a bit strange that the node is disabled, but still used. 

What if DT and UEFI tables are out of sync somehow? RAM is multiple 
mapped and different addresses were picked for example.

> You'd still need a new kernel to take into account status, but at least
> we'd know all kernels would avoid using RAM that potentially needs to be
> preserved.
> 
> Ard, Rob, thoughts?
