From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Jun 2017 16:56:10 +0200
Subject: [GIT PULL v3] updates to qbman (soc drivers) to support arm/arm64
In-Reply-To: <HE1PR0401MB17071A7853695DB6546FE28C8FC50@HE1PR0401MB1707.eurprd04.prod.outlook.com>
References: <HE1PR0401MB17071A7853695DB6546FE28C8FC50@HE1PR0401MB1707.eurprd04.prod.outlook.com>
Message-ID: <CAK8P3a2EvCvs57hE_X9J5jg6jW8jPh6gxaTOUYntbnHdb_cMZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 7:27 PM, Leo Li <leoyang.li@nxp.com> wrote:
>
> v2: Removed the patches for MAINTAINERS file as they are already picked
> up by powerpc tree.
>
> v3: Added signed tag to the pull request.
>
> Hi arm-soc maintainers,
>
> As Scott has left NXP, he agreed to transfer the maintainership of
> drivers/soc/fsl to me.  Previously most of the soc drivers were going
> through the powerpc tree as they were only used/tested on Power-based
> SoCs.  Going forward new changes will be mostly related to arm/arm64
> SoCs, and I would prefer them to go through the arm-soc tree.
>
> This pull request includes updates to the QMAN/BMAN drivers to make
> them work on the arm/arm64 architectures in addition to the power
> architecture.
>
> DPAA (Data Path Acceleration Architecture) is a set of hardware
> components used on some FSL/NXP QorIQ Networking SoCs, it provides the
> infrastructure to support simplified sharing of networking interfaces
> and accelerators by multiple CPU cores, and the accelerators
> themselves.  The QMan(Queue Manager) and BMan(Buffer Manager) are
> infrastructural components within the DPAA framework.  They are used to
> manage queues and buffers for various I/O interfaces, hardware
> accelerators.
>
> More information can be found via link:
> http://www.nxp.com/products/microcontrollers-and-processors/power-architecture-processors/qoriq-platforms/data-path-acceleration:QORIQ_DPAA

Hi Leo,

sorry for taking you through yet another revision, but I have two
more points here:

1. Please add a tag description whenever you create a signed tag. The
description is what ends up in the git history, and if there is none, I have
to think of something myself. In this case, the text above seems
roughly appropriate, so I first copied it into the commit log, but then
noticed the second issue:

2. I know we have discussed the unusual way this driver accesses MMIO
registers in the past, using ioremap_wc() to map them and the manually
flushing the caches to store the cache contents into the MMIO registers.
What I don't know is whether there was any conclusion on this topic whether
this is actually allowed by the architecture or at least the chip, based on
implementation-specific features that make it work even when the architecture
doesn't guarantee it.

Can I have an Ack from the architecture maintainers (Russell, Catalin,
Will) on the use of these architecture specific interfaces?

static inline void dpaa_flush(void *p)
{
#ifdef CONFIG_PPC
        flush_dcache_range((unsigned long)p, (unsigned long)p+64);
#elif defined(CONFIG_ARM32)
        __cpuc_flush_dcache_area(p, 64);
#elif defined(CONFIG_ARM64)
        __flush_dcache_area(p, 64);
#endif
}
#define dpaa_invalidate(p) dpaa_flush(p)
#define dpaa_zero(p) memset(p, 0, 64)
static inline void dpaa_touch_ro(void *p)
{
#if (L1_CACHE_BYTES == 32)
        prefetch(p+32);
#endif
        prefetch(p);
}

As described by Leo, the code is already there and is actively used
on powerpc, his pull request is merely for enabling the driver on ARM
and ARM64.

      Arnd
