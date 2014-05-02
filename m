From: will.deacon@arm.com (Will Deacon)
Date: Fri, 2 May 2014 19:07:07 +0100
Subject: [PATCH] arm64: Introduce execute-only page access permissions
In-Reply-To: <20140502171336.GA5341@arm.com>
References: <1399045792-5490-1-git-send-email-catalin.marinas@arm.com>
 <20140502170027.GE20642@arm.com> <20140502171336.GA5341@arm.com>
Message-ID: <20140502180706.GB14645@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 02, 2014 at 06:13:37PM +0100, Catalin Marinas wrote:
> On Fri, May 02, 2014 at 06:00:28PM +0100, Will Deacon wrote:
> > On Fri, May 02, 2014 at 04:49:52PM +0100, Catalin Marinas wrote:
> > > The ARMv8 architecture allows execute-only user permissions by clearing
> > > the PTE_UXN and PTE_USER bits. The kernel, however, can still access
> > > such page.
> > > 
> > > This patch changes the arm64 __P100 and __S100 protection_map[] macros
> > > to the new __PAGE_EXECONLY attributes. A side effect is that
> > > pte_valid_user() no longer triggers for __PAGE_EXECONLY since PTE_USER
> > > isn't set. To work around this, the check is done on the PTE_NG bit via
> > > the pte_valid_ng() macro. VM_READ is also checked now for page faults.
> > 
> > How does this interact with things like ptrace and pipes? Can I get the
> > kernel to read my text for me?
> 
> access_process_vm() would work fine since this is done using the kernel
> linear mapping (and get_user_pages). Also, if you get_user etc. it would
> still work since LDR/STR in EL1 mode would not be restricted (only
> LDRT/STRT but we don't use them).

Depends on how you define `work fine'!

> But note that this is only for pages explicitly marked PROT_EXEC only.
> Standard user apps just use r-x mappings, so not affected.

Ok, but it does mean that any task being subjected to --x permissions can
trivially read from that mapping via a syscall, so this patch only makes
sense in the context of something like seccomp, where you additionally
restrict the set of syscalls available to the target.

> > Also: do we really want to differ from x86 here?
> 
> x86 has a hardware limitation IIUC, same as ARMv7. This was a request
> from security people and they claim it's a feature they would like
> (apparently on Chrome OS). Of course, they have to adapt their tools/JIT
> to avoid literal pools on such mappings but there is ongoing work
> already.
> 
> We could make it configurable, though assume that it doesn't break any
> user ABI (so far OK but it needs more testing), we could make it the
> default.

Why not make it depend on SECCOMP or AUDIT? I don't think it's at all
useful without them.

Will
