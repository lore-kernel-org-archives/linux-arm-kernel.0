From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Feb 2016 12:16:49 +0000
Subject: [PATCH v12 1/5] efi: ARM/arm64: ignore DT memory nodes instead
 of removing them
In-Reply-To: <20160223115805.GB4989@leverpostej>
References: <1456192703-2274-1-git-send-email-ddaney.cavm@gmail.com>
 <1456192703-2274-2-git-send-email-ddaney.cavm@gmail.com>
 <20160223115805.GB4989@leverpostej>
Message-ID: <20160223121648.GI3966@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2016 at 11:58:05AM +0000, Mark Rutland wrote:
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
> 
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

So in that case, the middle, non-EFI kernel would fail to boot?
Realistically, once you've kexec'd a non-EFI payload, I don't think you
can rely on the EFI state remaining intact for future EFI applications.

Is this really something we should be trying to police in the kernel?

Will
