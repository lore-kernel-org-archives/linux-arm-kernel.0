From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 30 Mar 2010 12:50:17 +0100
Subject: [PATCH] ARM: Implement copy_to_user_page() for noMMU
In-Reply-To: <20100330112554.GA27463@shareable.org>
References: <20100329132457.1967.3394.stgit@e102109-lin.cambridge.arm.com>
	<20100330013132.GA15598@shareable.org>
	<1269941435.17138.36.camel@e102109-lin.cambridge.arm.com>
	<20100330112554.GA27463@shareable.org>
Message-ID: <1269949817.17138.69.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-03-30 at 12:25 +0100, Jamie Lokier wrote:
> Catalin Marinas wrote:
> > > Other variations such as writing when a mapping is !VM_EXEC and later
> > > mapping or mprotecting the same shmem VM_EXEC, but it's even more
> > > forbidden semantically to write to a read-only mapping (and just as
> > > unchecked on nommu), and conversion of writable to VM_EXEC ought to
> > > flush i-cache at mprotect time.
> >
> > ARM Linux doesn't do any cache maintenance for mprotect on VIPT or noMMU
> > hardware (not sure about VIVT). We discussed this in the past and it
> > wasn't clear whether it is required or not.
> 
> I still think it ought to happen on mprotect, but maybe that's a
> linux-arch discussion.  I saw IRIX actually has two PROT_EXEC flavours
> for mprotect so you can choose.

You can search some discussions a few months ago with COW pages and
cache coherency. This is where mprotect was discussed as well. I think
without additional kernel API, we just end up with too much flushing on
VIPT hardware (by implementing flush_cache_page).

> Back to this, just to double check, what about mapping?  E.g. where a
> shmem is mapped writable (but not executable), has executable code
> written to it by ptrace, and is later mapped in another process and
> executed.  Will the act of making the second mapping flush i-cache for
> that range?  (No-MMU doesn't need to flush caches on task switch)

ptrace writes to user pages via copy_to_user_page() which does the
flushing if it's a text page (VM_EXEC). In the case you describe above
with shared mappings, you would not get any flushing. Is this a real
situation?

-- 
Catalin
