From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Thu, 7 Jul 2011 20:51:02 +0400
Subject: [PATCH] ARM: cns3xxx: Add support for L2 Cache Controller
In-Reply-To: <CAK1hUK-gFwcHzEqFz8+T8Vm7CL5GnHAXureVizfNOBm=8h2mRw@mail.gmail.com>
References: <20110706140832.GA15946@oksana.dev.rtsoft.ru>
	<CAK1hUK-gFwcHzEqFz8+T8Vm7CL5GnHAXureVizfNOBm=8h2mRw@mail.gmail.com>
Message-ID: <20110707165102.GA7749@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 07:57:11AM +0800, Lin Mac wrote:
> 2011/7/6 Anton Vorontsov <avorontsov@mvista.com>:
> > CNS3xxx SOCs have L310-compatible cache controller, so let's use it.
> >
> > With this patch benchmarking with 'gzip' shows that performance is
> > doubled, and I'm still able to boot full-fledged userland over NFS
> > (using PCIe NIC), so the support should be pretty robust.
> >
> > Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
> 
> CNS3xxx have PL310. Would you mind to enable CONFIG_CACHE_PL310 by
> default as well? It is default disabled by !CPU_V6 of CACHE_PL310.
> 
> @@ -795,6 +795,7 @@ config CACHE_L2X0
>         default y
>         select OUTER_CACHE
>         select OUTER_CACHE_SYNC
> +       select CACHE_PL310 if ARCH_CNS3XXX
>         help
>           This option enables the L2x0 PrimeCell.

Well, while CNS3xxx reports that it has PL310, it still needs
to wait on cache line operations, but 'CACHE_PL310' removes
these waits. So, CNS3xxx is special.

With CACHE_PL310 enabled I'm getting random 'illegal instruction'
and 'segmentation fault's when userland loads via NFS.

So no, we don't want to enable CACHE_PL310, at least yet. Maybe
we should rename CACHE_PL310 to CACHE_L2X0_NO_CACHE_WAIT (which
we don't want for CNS3xxx).

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
