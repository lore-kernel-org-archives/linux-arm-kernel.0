From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Mar 2010 19:41:11 +0000
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267611877.15025.59.camel@mulgrave.site>
References: <20100302211049V.fujita.tomonori@lab.ntt.co.jp>
	<1267549527.15401.78.camel@e102109-lin.cambridge.arm.com>
	<1267572594.2173.25.camel@pasglop>
	<20100303124624Z.fujita.tomonori@lab.ntt.co.jp>
	<1267593032.16696.1.camel@pasglop>
	<1267594809.4383.27.camel@mulgrave.site>
	<20100303093650.GA22482@n2100.arm.linux.org.uk>
	<1267611877.15025.59.camel@mulgrave.site>
Message-ID: <20100303194111.GC4302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 03, 2010 at 03:54:37PM +0530, James Bottomley wrote:
> On Wed, 2010-03-03 at 09:36 +0000, Russell King - ARM Linux wrote:
> > James, that's a pipedream.  If you have a processor which doesn't support
> > NX, then the kernel marks all regions executable, even if the app only
> > asks for RW protection.
> 
> I'm not talking about what the processor supports ... I'm talking about
> what the user sets on the VMA.  My point is that the kernel only has
> responsibility in specific situations ... it's those paths we do the I/D
> coherency on.

You may not be talking about what the processor supports, but it is
directly relevant.

> > You end up with the protection masks always having VM_EXEC set in them,
> > so there's no way to distinguish from the kernel POV which pages are
> > going to be executed and those which aren't.
> 
> I think you're talking about the pte page flags, I'm talking about the
> VMA ones above.

No, I'm talking about the VMA ones.

        if ((prot & PROT_READ) && (current->personality & READ_IMPLIES_EXEC))
                if (!(file && (file->f_path.mnt->mnt_flags & MNT_NOEXEC)))
                        prot |= PROT_EXEC;
...
        /* Do simple checking here so the lower-level routines won't have
         * to. we assume access permissions have been handled by the open
         * of the memory object, so we don't do any here.
         */
        vm_flags = calc_vm_prot_bits(prot) | calc_vm_flag_bits(flags) |
                        mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;

calc_vm_prot_bits(unsigned long prot)
{
        return _calc_vm_trans(prot, PROT_READ,  VM_READ ) |
               _calc_vm_trans(prot, PROT_WRITE, VM_WRITE) |
               _calc_vm_trans(prot, PROT_EXEC,  VM_EXEC) |
               arch_calc_vm_prot_bits(prot);
}

So, if you have a CPU which does not support NX, then READ_IMPLIES_EXEC
is set in the personality.  That forces PROT_EXEC for anything with
PROT_READ, which in turn forces VM_EXEC.

> I'm not saying the common path (faulting in text sections) is the
> responsibility of user space.  I'm saying the uncommon path, write
> modification of binaries, is.  So the kernel only needs to worry about
> the ordinary text fault path.

What I'm saying is that you can't always tell the difference between
what's an executable page and what isn't in the kernel.  On NX-incapable
CPUs, the kernel treats *all* readable pages as executable, and there's
no way to tell from the VMA or page protection flags that this isn't
the case.
