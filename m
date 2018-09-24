From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 24 Sep 2018 15:03:38 +0100
Subject: [PATCH v5 1/6] arm64/mm: Introduce the init_pg_dir.
In-Reply-To: <20180924130137.re3nftpsi2dx2da2@lakrids.cambridge.arm.com>
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
 <20180917044333.30051-2-yaojun8558363@gmail.com>
 <20180924130137.re3nftpsi2dx2da2@lakrids.cambridge.arm.com>
Message-ID: <20180924140338.nu7jn3hfcwwoztnt@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2018 at 02:01:37PM +0100, Mark Rutland wrote:
> On Mon, Sep 17, 2018 at 12:43:28PM +0800, Jun Yao wrote:
> > To make the swapper_pg_dir read only, we will move it to the rodata
> > section. And force the kernel to set up the initial page table in
> > the init_pg_dir. After generating all levels page table, we copy
> > only the top level into the swapper_pg_dir during paging_init().

> > +#define INIT_PG_TABLES					\
> > +	. = ALIGN(PAGE_SIZE);				\
> > +	init_pg_dir = .;				\
> > +	. += SWAPPER_DIR_SIZE;				\
> > +	init_pg_end = .;
> 
> This will allocate a full set of PGD + PUD + PMD (+ PTE) levels, but the
> commit message says we only copy the top level table.
> 
> The memory for otjher levels of table can be re-allocated once the
> kernel init phase is over, so that seems a bit worrying.
> 
> Do we switch over to new copies of those levels, or do we continue using
> the entries from INIT_PG_TABLES?

I now see that we already allocate copies of those levels of table (and
free the originals in paging_init), so this is not a problem.

Sorry for the noise!

Mark.
