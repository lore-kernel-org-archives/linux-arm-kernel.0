From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 30 Apr 2013 16:26:35 +0100
Subject: [Question] flush_dcache_page() need to flush icache?
In-Reply-To: <CACVXFVPz-rMiPyW2EE==v58LF6uTD1M1fKTNcF5a5+Z6-5u+Gg@mail.gmail.com>
References: <CACVXFVMz3jLEPDYFM-_S_t5TiqikVSRiKf9cBNocH3QhVexwZg@mail.gmail.com>
 <20130430090502.GC29766@arm.com>
 <CACVXFVPz-rMiPyW2EE==v58LF6uTD1M1fKTNcF5a5+Z6-5u+Gg@mail.gmail.com>
Message-ID: <20130430152635.GH29766@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 30, 2013 at 11:02:36AM +0100, Ming Lei wrote:
> On Tue, Apr 30, 2013 at 5:05 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Tue, Apr 30, 2013 at 09:16:16AM +0100, Ming Lei wrote:
> >> Looks flush_dcache_page() need to deal with both dcache alias and I/D
> >> cache coherency, but set_pte_at() has already run __sync_icache_dcache()
> >> to make I/D cache coherency in the path of executable page fault.
> >>
> >> So could the flushing icache be removed in flush_dcache_page()?
> >
> > That's the case for (mapping && mapping_mapped(mapping)) where the
> > kernel modifies a page cache page which is already mapped in user space
> > and we won't get a subsequent set_pte_at() call.
> 
> OK, I got it, so looks it is only needed in self-modifying-code case,
> but I am wondering why it is always done for all cases of (mapping &&
> mapping_mapped(mapping))......

It's not self-modifying code, this would be code running in user space
which modifies some other code and it would invoke the ARM-specific
syscall for flushing.

Here it is about kernel modifying a page which is already mapped in user
space, hence the check for mapping && mapping_mapped.

-- 
Catalin
