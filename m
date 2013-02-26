From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Feb 2013 10:18:28 +0000
Subject: [PATCH 02/08] ARM: shmobile: Rework SH73A0_SCU_BASE IOMEM() usage
In-Reply-To: <CANqRtoSU9xqhTCv31CskYN8bu4H7gwz93fQcvuyLQx=hdRk2MA@mail.gmail.com>
References: <20130218134648.17303.97576.sendpatchset@w520>
 <201302181444.21717.arnd@arndb.de>
 <CANqRtoSU9xqhTCv31CskYN8bu4H7gwz93fQcvuyLQx=hdRk2MA@mail.gmail.com>
Message-ID: <201302261018.28463.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 February 2013, Magnus Damm wrote:
> For mach-shmobile the three major components that rely on entity
> mapped memory maps are SMP, clocks and power domains. The clocks
> should really be moved in the common direction and I intend to get
> people to focus on that in the not too distant future (next 6 months).
> Power domains should be rather easy to convert. SMP tends to be a bit
> of a headache because last time I checked I couldn't use ioremap() at
> ->smp_init_cpus() time. What I recall is that ioremap() hanged instead
> of returning something.
> 
> Anyway, if I track down the ioremap() issue, would it be possible for
> you to check if it can be reproduced on some other sub-architecture?

You are right that ioremap cannot be used from ->smp_init_cpus() and any
code called from there needs to use a static mapping for accessing
MMIO registers. There is nothing wrong with that. There are in fact
three distinct reasons why people use static MMIO mappings with
iotable_init():

1. For MMIO registers that need to be accessed before ioremap works.
   This usually means the SMP startup and the early printk (which I
   believe shmobile is not using).

2. For getting hugetlb mappings of MMIO registers into the kernel
   address space. If you have a lot of registers in the same area,
   using a single TLB to map them is more efficient, even when 
   accessing the registers through ioremap from a device driver.

3. For hardcoding the virtual address to a location that is passed
   to device drivers as compile-time constants.

The first two are absolutely fine, there are no objections to those.
The third one is tradtitionally used on a lot of the older platforms,
but with the multiplatform work, we are moving away from it, towards
passing resources in the platform device (ideally from DT, but that
is an orthogonal question here). AFAICT, shmobile is the only "modern"
platform that still relies on fixed virtual addresses, and it is the
only one I know that uses a mapping where the virtual address equals
the physical address.

	Arnd
