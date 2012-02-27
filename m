From: rlove@google.com (Robert Love)
Date: Mon, 27 Feb 2012 10:20:23 -0500
Subject: elf_set_personality()
In-Reply-To: <20120227150300.GF12917@tbergstrom-lnx.Nvidia.com>
References: <20120227123612.GD12917@tbergstrom-lnx.Nvidia.com>
 <20120227130453.GV22562@n2100.arm.linux.org.uk>
 <20120227150300.GF12917@tbergstrom-lnx.Nvidia.com>
Message-ID: <CAG6tG3y6+B8Si8bUFLK5aGmG2sed6y39V7XMcKZNDJuUbWCCjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 10:03 AM, Peter De Schrijver
<pdeschrijver@nvidia.com> wrote:
> On Mon, Feb 27, 2012 at 02:04:53PM +0100, Russell King - ARM Linux wrote:
> > This sounds like a problem. ?If you have two applications trying to use
> > the ashmem driver, one without READ_IMPLIES_EXEC and one with
> > READ_IMPLIES_EXEC, then it seems that ashmem will prevent the
> > READ_IMPLIES_EXEC one from using such regions. ?That sounds like a
> > (different) bug to me.
>
> Good point. I don't know anything about the design ideas behind ashmem
> though.
> Can anyone from android comment on this?

The problem is this code snippet:

    /* requested protection bits must match our allowed protection mask */
    if (unlikely((vma->vm_flags & ~asma->prot_mask) & PROT_MASK)) {
            ret = -EPERM;
	    goto out;
    }

Coupled with this snippet:

    /* does the application expect PROT_READ to imply PROT_EXEC? */
    if ((prot & PROT_READ) && (current->personality & READ_IMPLIES_EXEC))
            prot |= PROT_EXEC;

One fix is to remove the second snippet altogether. I added it to be
diligent; Android doesn't have a specific use for it afaik.

An alternative is to keep the code as-is. Note the bug isn't quite as
described: It isn't the case that two processes, one with
READ_IMPLIES_EXEC and one without, will always fail to both map an
ashmem region. The failure case is when a process creates a region
PROT_READ & ~PROT_EXEC and then a second process with
READ_IMPLIES_EXEC tries to map the region PROT_READ with the implicit
PROT_EXEC. I'm not sure what to do here. This seems like a legit
reason to fail.

          Robert
