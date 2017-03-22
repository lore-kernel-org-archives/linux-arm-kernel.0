From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 22 Mar 2017 11:38:54 +0000
Subject: [PATCH 12/14] arm64: kill acpi_set_mailbox_entry()
In-Reply-To: <20170321185310.GG29116@leverpostej>
References: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
 <1489143891-11596-13-git-send-email-mark.rutland@arm.com>
 <20170321180040.GA4849@red-moon>
 <20170321181554.GF29116@leverpostej>
 <20170321183755.GA2976@red-moon>
 <20170321185310.GG29116@leverpostej>
Message-ID: <20170322113854.GA2977@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 06:53:10PM +0000, Mark Rutland wrote:
> On Tue, Mar 21, 2017 at 06:37:55PM +0000, Lorenzo Pieralisi wrote:
> > On Tue, Mar 21, 2017 at 06:15:54PM +0000, Mark Rutland wrote:
> > > On Tue, Mar 21, 2017 at 06:00:40PM +0000, Lorenzo Pieralisi wrote:
> > > > On Fri, Mar 10, 2017 at 11:04:49AM +0000, Mark Rutland wrote:
> > > 
> > > > > +static struct parking_protocol_mailbox __iomem *mailboxes[NR_CPUS];
> > > > 
> > > > Nit: If I am not mistaken it can be made a percpu pointer.
> > > 
> > > Unfortunately, we don't set up the percpu areas until we know how many
> > > CPUs are possible (i.e. after we've parsed the MADT).
> > > 
> > > The flow looks like:
> > > 
> > > start_kernel()
> > >   setup_arch()
> > >     smp_init_cpus()
> > >       acpi_table_parse_madt()
> > >         acpi_parse_gic_cpu_interface()
> > >           acpi_map_gic_cpu_interface() // setup cpu mailbox here
> > 
> > The mailbox data yes, not the pointer at which it is mapped (which
> > is what gets stashed in mailboxes[]).
> 
> Sorry, I got myself confused here between this and the MADT GICC
> stashing to which the above does apply.
> 
> You are correct that this can and should be a percpu pointer.
> 
> I'll fix this up. I just need to figure out where the __iomem attribute
> is supposed to live on a percpu definition.

I gave sparse a go and figured that out.

In the process I found another issue, so I'm gonig to add the below to
the series.

Thanks,
Mark.

--->8----
>From 3045f18e798a37b4956f837ed264704500ca45b9 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Wed, 22 Mar 2017 11:23:20 +0000
Subject: [PATCH] arm64: parking: fix type endianness

The read*{,_relaxed}() return a value of native CPU endianness,
swizzling the LE value they read from an __iomem pointer.

Thus it isn't correct to treat their return values as __le32 or __le64,
and we should use u32 and u64 respectively instead.

This makes sparse much happier, but should have no functional impact.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/acpi_parking_protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/acpi_parking_protocol.c b/arch/arm64/kernel/acpi_parking_protocol.c
index e2c7399..b878b15 100644
--- a/arch/arm64/kernel/acpi_parking_protocol.c
+++ b/arch/arm64/kernel/acpi_parking_protocol.c
@@ -56,7 +56,7 @@ static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
 {
 	struct acpi_madt_generic_interrupt *p = acpi_cpu_get_madt_gicc(cpu);
 	struct parking_protocol_mailbox __iomem *mailbox;
-	__le32 cpu_id;
+	u32 cpu_id;
 
 	/*
 	 * Map mailbox memory with attribute device nGnRE (ie ioremap -
@@ -107,7 +107,7 @@ static void acpi_parking_protocol_cpu_postboot(void)
 {
 	int cpu = smp_processor_id();
 	struct parking_protocol_mailbox __iomem *mailbox;
-	__le64 entry_point;
+	u64 entry_point;
 
 	mailbox = per_cpu(mailboxes, cpu);
 
-- 
1.9.1
