From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Jul 2014 17:20:46 +0200
Subject: [PATCH 1/3] arm64: spin-table: handle unmapped cpu-release-addrs
In-Reply-To: <1406646945.753.5.camel@deneb.redhat.com>
References: <1406630950-32432-1-git-send-email-ard.biesheuvel@linaro.org>
 <1406630950-32432-2-git-send-email-ard.biesheuvel@linaro.org>
 <1406646945.753.5.camel@deneb.redhat.com>
Message-ID: <2385684.COvj9k7y2z@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 July 2014 11:15:45 Mark Salter wrote:
> > -
> > -     __flush_dcache_area(release_addr, sizeof(release_addr[0]));
> > +     writeq_relaxed(__pa(secondary_holding_pen), release_addr);
> > +     __flush_dcache_area(release_addr, sizeof(*release_addr));
> 
>        __flush_dcache_area((__force void *)release_addr, ... 
> 
> to avoid sparse warning.
> 

I think it would be cleaner to drop the __iomem annotation and use vmap()
rather than ioremap(). That requires having a 'struct page' though, which
I'm not sure you have.

	Arnd
