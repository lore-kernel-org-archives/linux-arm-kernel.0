From: msalter@redhat.com (Mark Salter)
Date: Tue, 29 Jul 2014 11:30:24 -0400
Subject: [PATCH 1/3] arm64: spin-table: handle unmapped cpu-release-addrs
In-Reply-To: <2385684.COvj9k7y2z@wuerfel>
References: <1406630950-32432-1-git-send-email-ard.biesheuvel@linaro.org>
 <1406630950-32432-2-git-send-email-ard.biesheuvel@linaro.org>
 <1406646945.753.5.camel@deneb.redhat.com> <2385684.COvj9k7y2z@wuerfel>
Message-ID: <1406647824.753.12.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-07-29 at 17:20 +0200, Arnd Bergmann wrote:
> On Tuesday 29 July 2014 11:15:45 Mark Salter wrote:
> > > -
> > > -     __flush_dcache_area(release_addr, sizeof(release_addr[0]));
> > > +     writeq_relaxed(__pa(secondary_holding_pen), release_addr);
> > > +     __flush_dcache_area(release_addr, sizeof(*release_addr));
> > 
> >        __flush_dcache_area((__force void *)release_addr, ... 
> > 
> > to avoid sparse warning.
> > 
> 
> I think it would be cleaner to drop the __iomem annotation and use vmap()
> rather than ioremap(). That requires having a 'struct page' though, which
> I'm not sure you have.
> 

You won't. If you did have a struct page, then __va() would work.
