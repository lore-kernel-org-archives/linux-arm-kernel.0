From: rlove@google.com (Robert Love)
Date: Mon, 27 Feb 2012 12:09:00 -0500
Subject: elf_set_personality()
In-Reply-To: <20120227164130.GB2440@n2100.arm.linux.org.uk>
References: <20120227123612.GD12917@tbergstrom-lnx.Nvidia.com>
 <20120227130453.GV22562@n2100.arm.linux.org.uk>
 <20120227150300.GF12917@tbergstrom-lnx.Nvidia.com>
 <CAG6tG3y6+B8Si8bUFLK5aGmG2sed6y39V7XMcKZNDJuUbWCCjQ@mail.gmail.com>
 <20120227164130.GB2440@n2100.arm.linux.org.uk>
Message-ID: <CAG6tG3zwfhZXw5M_kk4ry4H6NhTuKyenP-6UUm+XwyxbBbcG9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 11:41 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> It seems that vanilla mmap() of a file does not deny a mapping containing
> PROT_EXEC of a file with read-write-noexec permissions - it permits it,
> but it does fail mapping a file PROT_WRITE which wasn't opened for write.
>
> Moreover, it's not actually possible to prevent execution of code if
> you have read permission - if you can read a mapping, you can copy it
> into an executable mapping and then execute copied code.
>
> So, I don't think there's any reason to prevent PROT_EXEC in a hard and
> fast manner. ?If you don't want to go that far, what about:
>
> ? ? ? ?prot_mask = PROT_MASK;
> ? ? ? ?if (current->personality & READ_IMPLIES_EXEC)
> ? ? ? ? ? ? ? ?prot_mask &= ~PROT_EXEC;
> ? ? ? ?if (vma->vm_flags & ~asma->prot_mask & prot_mask) {
> ? ? ? ? ? ? ? ?ret = -EPERM;
> ? ? ? ? ? ? ? ?goto out;
> ? ? ? ?}
>
> which would mean !READ_IMPLIES_EXEC threads would get the full permission
> checking, but a READ_IMPLIES_EXEC thread would still be able to attach
> to a r/w only shared mapping.

ashmem should behave however vanilla mmap behaves. There is no reason
to be different and I'd prefer to consolidate or at least copy the
code.

It is unfortunate that each implementer of fops->mmap needs to
manually handle the READ_IMPLIES_EXEC case.

        Robert
