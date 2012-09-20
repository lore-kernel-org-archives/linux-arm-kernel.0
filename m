From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Sep 2012 23:12:15 +0100
Subject: [PATCH 0/4] Fix PROT_NONE page permissions when !CPU_USE_DOMAINS
In-Reply-To: <1348156605-30398-1-git-send-email-will.deacon@arm.com>
References: <1348156605-30398-1-git-send-email-will.deacon@arm.com>
Message-ID: <20120920221215.GA1837@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 04:56:41PM +0100, Will Deacon wrote:
> Hello,
> 
> After laughing at Ben H during LPC when it emerged that the PPC PROT_NONE
> protection bits don't prevent kernel access to the protected pages, I
> looked at the ARM code and, to my dismay, found that we have the same
> problem when not using domains.
> 
> This patch series addresses the issue with the following points worth
> noting:
> 
> 	- We use the last available software bit (11) for 2-level PTEs.
> 	  Whilst this is somewhat of a pity, I can't think of a better
> 	  reason to allocate it than to fix an outstanding bug.

But you don't - you've defined it to be bit 0, which is the same as the
present bit, and clearing the present bit is not a good idea as it turns
the entry into something like a swap entry.

So, let's go back and restart the analysis (and document it).  What
happens is we call pte_modify() on each present page, setting the new
protection - __PAGE_NONE.

__PAGE_NONE is defined as: _L_PTE_DEFAULT | L_PTE_RDONLY | L_PTE_XN

which translates to: present | young | read only | xn - with no user
bit set.  No user bit set means that userspace accesses, get_user()
and put_user() must fail when the page is accessed.

Now, this results in the pages being present (and really are present
in userspace) but with no accessibility allowed for user-mode accesses,
and read-only for kernel-mode accesses.  (The permissions valules
for ARMv7 are: APX=1 AP1=0 AP0=1).

Now, this happens fine when DOMAINS are enabled, because we use the
T-bit operations to ensure that the accesses are checked against
userspace permissions.

However, when DOMAINS are disabled, we use standard loads/stores, which
check against kernel permissions, and so _any_ PROT_NONE mmap() will be
readable by any of the kernel user access functions.

So, on ARMv5 and below, these bits get translated as...

L_PTE_RDONLY	L_PTE_USER	AP
1		0		00	(user n/a, system r/o)
0		0		01	(user n/a, system r/w)
1		1		10	(user r/o, system r/w)
0		1		11	(user r/w, system r/w)

and this is fine because we always use domains (we must _never_ not use
domains here, because the available permissions that the architecture
gives us do not allow it.)

On ARMv6+ with domains:

L_PTE_RDONLY	L_PTE_USER	AP
1		0		101	(user n/a, system r/o)
0		0		001	(user n/a, system r/w)
1		1		010	(user r/o, system r/w)
0		1		011	(user r/w, system r/w)

which is also fine, as user accesses are performed using T-bit loads and
stores.

On ARMv6+ without domains, only one of these changes:

L_PTE_RDONLY	L_PTE_USER	AP
1		0		101	(user n/a, system r/o)
0		0		001	(user n/a, system r/w)
1		1		111	(user r/o, system r/o)
0		1		011	(user r/w, system r/w)

However, now we perform user accesses using kernel-mode loads/stores,
so the access permissions which are checked are the 'system'
permissions, and as we can see from the above, when there is no state
when the kernel is denied access to the page.

Why not make system access permissions reflect user access permissions?
Well, that's easy to answer - you want your kernel data and code to be
protected against reading/writing by userspace... so we need a
combination of permissions to permit those encodings - and not
surprisingly, clearing the L_PTE_USER bit gives us that.

What wasn't thought about properly was the effect of removing domains
and converting the kernel-initiated userspace accesses to use kernel-mode
accesses.  Yes, the obvious was changed (so that user r/o also became
kernel r/o) but that's not enough.

The only solution I can see is to have L_PTE_KERNEL which indicates
whether this is a kernel mapping.  If both L_PTE_KERNEL and L_PTE_USER
are clear, then we zero out the hardware PTE entry - and that would be
the case for a userspace PROT_NONE entry.  Otherwise, we fall back to
our current behaviour.

So, essentially we change from ignoring the PTE value when

	(val & (PRESENT | YOUNG)) != (PRESENT | YOUNG))

to:

	(val & (PRESENT | YOUNG | USER)) != (PRESENT | YOUNG | USER)) &&
	(val & (PRESENT | YOUNG | KERNEL)) != (PRESENT | YOUNG | KERNEL))

That'll make the set_pte assembly more horrid, but I guess that's the
price you pay for removing useful features which architecture folk don't
like from CPUs... and it gets more horrid because you can't encode some
of those bit patterns with the standard 8-bit and shift opcode
representation.

Really fun bug, but it needs more thought about how to solve it.
