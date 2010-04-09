From: pullip@gmail.com (Cho, Kyong Ho)
Date: Fri, 9 Apr 2010 09:45:48 +0900
Subject: Why flush_cache_vmap flushes all levels of the cache?
In-Reply-To: <s2naf12251d1004081743k79760c5p10dfd2d07fcbec94@mail.gmail.com>
References: <t2uaf12251d1004081723sb9ecb044s305a2ba1d08e80d9@mail.gmail.com>
	<s2naf12251d1004081743k79760c5p10dfd2d07fcbec94@mail.gmail.com>
Message-ID: <t2gaf12251d1004081745m34787345i39c4b17ef5c1e87b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.
Even though flush_cache_vmap(arch/arm/include/asm/cacheflush.h), that
is invoked whenever a new VM-PM mapping on the HIMEM is created, does
not flush the entire cache for non-aliasing VIPT caches from 2.6.30, I
am curious why it must flush the entire cache for other caches such as
VIVT or VIPT prior to ARMv7.

static inline void flush_cache_vmap(unsigned long start, unsigned long end)
{
?? ? ? ?if (!cache_is_vipt_nonaliasing())
?? ? ? ? ? ? ? ?flush_cache_all();
?? ? ? ?else
?? ? ? ? ? ? ? ?/*
?? ? ? ? ? ? ? ? * set_pte_at() called from vmap_pte_range() does not
?? ? ? ? ? ? ? ? * have a DSB after cleaning the cache line.
?? ? ? ? ? ? ? ? */
?? ? ? ? ? ? ?dsb();
}
I guess the following situation:
(1) A cache line contains stale, dirty data that is allocated by an
old page mapping and is not flushed when the page mapping is removed
(but as far as I know, flush_cache_vunmap is always invoked whenever a
page mapping is removed)
(2) New page mapping on the HIMEM is created.
(3) Data in the page frame mapped by (2) is modified through the new
page mapping
(4) After a while, the cache line that I mentioned in (1) still
contains stale data by the old page mapping and becomes a victim.
(5) Data in the cache line is flushed into the main memory even though
no page mapping exists

As a result of the above situation, the main memory is modified by an
invalid data and not coherent with the cache.

Is my assumption correct?
