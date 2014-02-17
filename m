From: msalter@redhat.com (Mark Salter)
Date: Mon, 17 Feb 2014 08:29:16 -0500
Subject: [PATCH 16/22] arm64: Add function to create identity mappings
In-Reply-To: <20140214174256.GC12304@arm.com>
References: <1391619853-10601-1-git-send-email-leif.lindholm@linaro.org>
 <1391619853-10601-17-git-send-email-leif.lindholm@linaro.org>
 <20140214174256.GC12304@arm.com>
Message-ID: <1392643756.2771.66.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-02-14 at 17:42 +0000, Catalin Marinas wrote:
> On Wed, Feb 05, 2014 at 05:04:07PM +0000, Leif Lindholm wrote:
> > +void __init create_id_mapping(phys_addr_t addr, phys_addr_t size, int map_io)
> > +{
> > +	pgd_t *pgd = &idmap_pg_dir[pgd_index(addr)];
> > +
> > +	if (pgd >= &idmap_pg_dir[ARRAY_SIZE(idmap_pg_dir)]) {
> > +		pr_warn("BUG: not creating id mapping for 0x%016llx\n", addr);
> > +		return;
> > +	}
> > +	__create_mapping(pgd, addr, addr, size, map_io);
> > +}
> 
> I'm a bit worried because I gave some feedback in the past but it didn't
> make to this patch.
> 
> What I said on 22nd of January:
> 
>   The condition above is always false since pgd_index() already ands the
>   index with (PTRS_PER_PGD - 1). Better check addr against something like
>   (PTRS_PER_PGD * PGDIR_SIZE) (for clarity, you could do other shifts,
>   doesn't really matter).
> 
Sorry about that. I remember making this change but I don't know what
happened to it.
