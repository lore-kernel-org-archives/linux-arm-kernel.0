From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 8 Jul 2011 11:48:12 +0100
Subject: [RFC PATCH 14/17] ARM: kernel: save/restore 1:1 page tables
In-Reply-To: <4E166A66.3020001@ti.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-15-git-send-email-lorenzo.pieralisi@arm.com>
	<4E166A66.3020001@ti.com>
Message-ID: <20110708104812.GB32592@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 03:24:38AM +0100, Santosh Shilimkar wrote:
> On 7/7/2011 8:50 AM, Lorenzo Pieralisi wrote:
> > This patch adds the code required to allocate and populate page tables
> > that are needed by save/restore code to deal with MMU off/on
> > transactions.
> >
> > MMU is enabled early in the resume path which allows to call into
> > Linux subsystems with init_mm virtual mappings (cloned at boot).
> >
> > Current thread page table pointer and context id is saved on power
> > down from active_mm and restored on warm boot.
> > Currently the translation tables contains 1:1 mappings of the Linux
> > kernel code and data, and 1:1 UNCACHED mapping of control code required when MMU
> > is turned off in the restore code path.
> >
> > Signed-off-by: Lorenzo Pieralisi<lorenzo.pieralisi@arm.com>
> > ---
> >   arch/arm/kernel/sr_mapping.c |   78 ++++++++++++++++++++++++++++++++++++++++++
> >   1 files changed, 78 insertions(+), 0 deletions(-)
> >   create mode 100644 arch/arm/kernel/sr_mapping.c
> >
> > diff --git a/arch/arm/kernel/sr_mapping.c b/arch/arm/kernel/sr_mapping.c
> > new file mode 100644
> > index 0000000..32640dc
> > --- /dev/null
> > +++ b/arch/arm/kernel/sr_mapping.c
> > @@ -0,0 +1,78 @@
> > +/*
> > + * Copyright (C) 2008-2011 ARM Limited
> 
> This is more of question so don't beat me if I am wrong here.
> Above file doesn't exist in k.org from 2008 right ?
> I noticed this in your other patches too.

Yes you are right, I will updated the whole set.
