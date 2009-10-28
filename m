From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 28 Oct 2009 15:51:38 +0000
Subject: [RFC 10/11] ARM: arrange for flush_cache_range() to always
	flush the I-cache
In-Reply-To: <12475bd20f82c3a5e78d5b8e9d3cb266914c4727.1256683230.git.rmk+kernel@arm.linux.org.uk>
References: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
	<12475bd20f82c3a5e78d5b8e9d3cb266914c4727.1256683230.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <1256745098.27121.48.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2009-10-25 at 14:12 +0000, Russell King wrote:
> Dirk Behme reported instability on ARM11 SMP (VIPT non-aliasing cache)
> caused by the dynamic linker changing protection on text pages to write
> GOT entries.  The problem is due to an interaction between the write
> faulting code providing new anonymous pages (which haven't had their
> I-cache cleaned due to no VM_EXEC) and change_protection() not doing
> any kind of I-cache maintainence.
> 
> Work around this by flushing the I-cache in flush_cache_range() for
> VM_EXEC VMAs (which is what we have when the region is being made
> executable again.)  This ensures that the I-cache will be up to date
> with the new COW'd pages.

Are you sure this fixes the problem? IIRC this is mainly caused by the
write-allocate D-cache and that copy_to_user_highpage() doesn't flush
the D-cache. Just an I-cache invalidation wouldn't help much.

-- 
Catalin
