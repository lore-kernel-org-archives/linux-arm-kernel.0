From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 30 Mar 2010 02:31:32 +0100
Subject: [PATCH] ARM: Implement copy_to_user_page() for noMMU
In-Reply-To: <20100329132457.1967.3394.stgit@e102109-lin.cambridge.arm.com>
References: <20100329132457.1967.3394.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100330013132.GA15598@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> +void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
> +		       unsigned long uaddr, void *dst, const void *src,
> +		       unsigned long len)
> +{
> +	memcpy(dst, src, len);
> +	if (vma->vm_flags & VM_EXEC)
> +		__cpuc_coherent_user_range(uaddr, uaddr + len);
> +}

Does that do the right thing with uaddr + len == 0?

Since this is debugging, it would be unfortunate if something was
mapped !VM_EXEC but executed anyway (because it works, or because of a
bug), and setting a breakpoint failed to be effective because of
entries in the i-cache.  It's forbidden semantically, and code which
wrote _itself_ to code without flushing i-cache on nommu gets what it
deserves.  But it may occur that it's executing, even if just due to
an application bug, and I'm thinking tracing under the debugger is one
time it's good to be more reliable.

Other variations such as writing when a mapping is !VM_EXEC and later
mapping or mprotecting the same shmem VM_EXEC, but it's even more
forbidden semantically to write to a read-only mapping (and just as
unchecked on nommu), and conversion of writable to VM_EXEC ought to
flush i-cache at mprotect time.

-- Jamie
