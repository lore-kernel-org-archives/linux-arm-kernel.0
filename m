From: mel@csn.ul.ie (Mel Gorman)
Date: Mon, 10 May 2010 16:40:30 +0100
Subject: Suspicious compilation warning
In-Reply-To: <20100420155122.6f2c26eb.akpm@linux-foundation.org>
References: <k2ncecb6d8f1004191627w3cd36450xf797f746460abb09@mail.gmail.com>
	<20100420155122.6f2c26eb.akpm@linux-foundation.org>
Message-ID: <20100510154029.GK26611@csn.ul.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 20, 2010 at 03:51:22PM -0700, Andrew Morton wrote:
> On Mon, 19 Apr 2010 20:27:43 -0300
> Marcelo Jimenez <mroberto@cpti.cetuc.puc-rio.br> wrote:
> 
> > I get this warning while compiling for ARM/SA1100:
> > 
> > mm/sparse.c: In function '__section_nr':
> > mm/sparse.c:135: warning: 'root' is used uninitialized in this function
> > 
> > With a small patch in fs/proc/meminfo.c, I find that NR_SECTION_ROOTS
> > is zero, which certainly explains the warning.
> > 
> > # cat /proc/meminfo
> > NR_SECTION_ROOTS=0
> > NR_MEM_SECTIONS=32
> > SECTIONS_PER_ROOT=512
> > SECTIONS_SHIFT=5
> > MAX_PHYSMEM_BITS=32
> 
> hm, who owns sparsemem nowadays? Nobody identifiable.
> 

The closest entity to a SPARSEMEM owner was Andy Whitcroft but I don't
believe he is active in mainline at the moment. I used to know SPARSEMEM to
some extent but my memory is limited at the best of times.

> Does it make physical sense to have SECTIONS_PER_ROOT > NR_MEM_SECTIONS?
> 

Yes. NR_MEM_SECTIONS depends on MAX_PHYSMEM_BITS but SECTIONS_PER_ROOT is based
on PAGE_SIZE. If MAX_PHYSMEM_BITS is particularly small due to architectural
limitations, it's perfectly possible there are fewer sections that can be
active (NR_MEM_SECTIONS) than is possible to fit within one root. While
not physicaly impossible, it was probably not expected.

Using DIV_ROUND_UP on SECTIONS_PER_ROOT to ensure NR_MEM_SECTIONS is
aligned to SECTIONS_PER_ROOT should be a fix for this.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
