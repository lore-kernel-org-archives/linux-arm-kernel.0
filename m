From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 May 2010 15:02:24 +0100
Subject: [PATCH 1/4] ARM: Remove the domain switching on ARMv6k/v7 CPUs
In-Reply-To: <20100524135948.GD21117@n2100.arm.linux.org.uk>
References: <20100520142715.22202.33516.stgit@e102109-lin.cambridge.arm.com>
	<20100520143004.22202.71701.stgit@e102109-lin.cambridge.arm.com>
	<20100524114546.GB21117@n2100.arm.linux.org.uk>
	<1274707518.4720.53.camel@e102109-lin.cambridge.arm.com>
	<1274709172.4720.57.camel@e102109-lin.cambridge.arm.com>
	<20100524135948.GD21117@n2100.arm.linux.org.uk>
Message-ID: <1274709744.4720.61.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-05-24 at 14:59 +0100, Russell King - ARM Linux wrote:
> On Mon, May 24, 2010 at 02:52:52PM +0100, Catalin Marinas wrote:
> > @@ -77,7 +78,11 @@ int show_fiq_list(struct seq_file *p, void *v)
> > 
> >  void set_fiq_handler(void *start, unsigned int length)
> >  {
> > +#if defined(CONFIG_CPU_USE_DOMAINS)
> >       memcpy((void *)0xffff001c, start, length);
> > +#else
> > +     memcpy(vectors_page + 0x1c, start, length);
> > +#endif
> >       flush_icache_range(0xffff001c, 0xffff001c + length);
> 
> This is clearly buggy from an I/D coherency point of view.

As I said, it only works on VIPT non-aliasing caches, which would be
fine give the CPUs that this patch targets. If you think it's safer, we
can restrict this patch for ARMv7 onwards.

-- 
Catalin
