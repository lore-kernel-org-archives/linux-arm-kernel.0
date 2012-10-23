From: josh.cartwright@ni.com (Josh Cartwright)
Date: Tue, 23 Oct 2012 15:53:04 -0500
Subject: [PATCH v2 2/4] zynq: move static peripheral mappings
In-Reply-To: <5086F973.6050309@gmail.com>
References: <20121022211219.GC31538@beefymiracle.amer.corp.natinst.com>
 <201210231450.11540.arnd@arndb.de> <5086F973.6050309@gmail.com>
Message-ID: <20121023205304.GJ20593@beefymiracle.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 03:09:23PM -0500, Rob Herring wrote:
> On 10/23/2012 09:50 AM, Arnd Bergmann wrote:
> > On Monday 22 October 2012, Josh Cartwright wrote:
> >> -#define SCU_PERIPH_PHYS			0xF8F00000
> >> -#define SCU_PERIPH_VIRT			SCU_PERIPH_PHYS
> >> +#define SCU_PERIPH_PHYS		0xF8F00000
> >> +#define SCU_PERIPH_SIZE		SZ_8K
> >> +#define SCU_PERIPH_VIRT		(PL310_L2CC_VIRT - SCU_PERIPH_SIZE)
> >
> > And your patch 3 already obsoletes this mapping.
>
> Actually, it's probably still needed. The smp platform code typically
> reads the number of cores from the SCU and the mapping has to be in
> place before ioremap is up. I don't think there is an architected way to
> get the number of cores, but it would be nice to avoid this early SCU
> access. We could also mandate getting the core count from DT instead.
>
> Also, the physical address can be read with this on A9's:
>
>         asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (base));

For the sake of the zynq cleanups, I think it may still make sense to
remove the SCU peripheral mappings for now.  By the time we're ready to
push in SMP support for zynq, maybe we can tackle the problem of how to
solve the SCU mapping problem generically.

If we're already considering a architecture-agnostic way to maintain the
early uart mapping, would it make sense to handle this in a similar way?

Thanks,

  Josh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121023/518ac82a/attachment.sig>
