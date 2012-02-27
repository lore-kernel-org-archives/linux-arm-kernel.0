From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Feb 2012 16:41:30 +0000
Subject: elf_set_personality()
In-Reply-To: <CAG6tG3y6+B8Si8bUFLK5aGmG2sed6y39V7XMcKZNDJuUbWCCjQ@mail.gmail.com>
References: <20120227123612.GD12917@tbergstrom-lnx.Nvidia.com>
 <20120227130453.GV22562@n2100.arm.linux.org.uk>
 <20120227150300.GF12917@tbergstrom-lnx.Nvidia.com>
 <CAG6tG3y6+B8Si8bUFLK5aGmG2sed6y39V7XMcKZNDJuUbWCCjQ@mail.gmail.com>
Message-ID: <20120227164130.GB2440@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 10:20:23AM -0500, Robert Love wrote:
> On Mon, Feb 27, 2012 at 10:03 AM, Peter De Schrijver
> <pdeschrijver@nvidia.com> wrote:
> > On Mon, Feb 27, 2012 at 02:04:53PM +0100, Russell King - ARM Linux wrote:
> > > This sounds like a problem. ?If you have two applications trying to use
> > > the ashmem driver, one without READ_IMPLIES_EXEC and one with
> > > READ_IMPLIES_EXEC, then it seems that ashmem will prevent the
> > > READ_IMPLIES_EXEC one from using such regions. ?That sounds like a
> > > (different) bug to me.
> >
> > Good point. I don't know anything about the design ideas behind ashmem
> > though.
> > Can anyone from android comment on this?
> 
> The problem is this code snippet:
> 
>     /* requested protection bits must match our allowed protection mask */
>     if (unlikely((vma->vm_flags & ~asma->prot_mask) & PROT_MASK)) {
>             ret = -EPERM;
> 	    goto out;
>     }
> 
> Coupled with this snippet:
> 
>     /* does the application expect PROT_READ to imply PROT_EXEC? */
>     if ((prot & PROT_READ) && (current->personality & READ_IMPLIES_EXEC))
>             prot |= PROT_EXEC;

You're missing another place - mm/mmap.c:

        /*
         * Does the application expect PROT_READ to imply PROT_EXEC?
         *
         * (the exception is when the underlying filesystem is noexec
         *  mounted, in which case we dont add PROT_EXEC.)
         */
        if ((prot & PROT_READ) && (current->personality & READ_IMPLIES_EXEC))
                if (!(file && (file->f_path.mnt->mnt_flags & MNT_NOEXEC)))
                        prot |= PROT_EXEC;

So, a thread with READ_IMPLIES_EXEC with a mmap() containing PROT_READ
will always appear with PROT_READ | PROT_EXEC, which then gets
translated to VM_READ | VM_EXEC.

> One fix is to remove the second snippet altogether. I added it to be
> diligent; Android doesn't have a specific use for it afaik.
> 
> An alternative is to keep the code as-is. Note the bug isn't quite as
> described: It isn't the case that two processes, one with
> READ_IMPLIES_EXEC and one without, will always fail to both map an
> ashmem region. The failure case is when a process creates a region
> PROT_READ & ~PROT_EXEC and then a second process with
> READ_IMPLIES_EXEC tries to map the region PROT_READ with the implicit
> PROT_EXEC. I'm not sure what to do here. This seems like a legit
> reason to fail.

It seems that vanilla mmap() of a file does not deny a mapping containing
PROT_EXEC of a file with read-write-noexec permissions - it permits it,
but it does fail mapping a file PROT_WRITE which wasn't opened for write.

Moreover, it's not actually possible to prevent execution of code if
you have read permission - if you can read a mapping, you can copy it
into an executable mapping and then execute copied code.

So, I don't think there's any reason to prevent PROT_EXEC in a hard and
fast manner.  If you don't want to go that far, what about:

	prot_mask = PROT_MASK;
	if (current->personality & READ_IMPLIES_EXEC)
		prot_mask &= ~PROT_EXEC;
	if (vma->vm_flags & ~asma->prot_mask & prot_mask) {
		ret = -EPERM;
		goto out;
	}

which would mean !READ_IMPLIES_EXEC threads would get the full permission
checking, but a READ_IMPLIES_EXEC thread would still be able to attach
to a r/w only shared mapping.
