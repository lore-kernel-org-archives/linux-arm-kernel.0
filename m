From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 24 Feb 2016 14:18:32 +0000
Subject: [PATCH v3] ARM64: kernel: implement ACPI parking protocol
In-Reply-To: <20160203161834.GB26487@MBP.local>
References: <1453806638-23167-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20160202182657.GC15706@e104818-lin.cambridge.arm.com>
 <20160203112112.GA18387@red-moon>
 <20160203161834.GB26487@MBP.local>
Message-ID: <20160224141832.GA26630@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+ Itaru]

On Wed, Feb 03, 2016 at 04:18:36PM +0000, Catalin Marinas wrote:
> On Wed, Feb 03, 2016 at 11:21:12AM +0000, Lorenzo Pieralisi wrote:
> > On Tue, Feb 02, 2016 at 06:26:58PM +0000, Catalin Marinas wrote:
> > > On Tue, Jan 26, 2016 at 11:10:38AM +0000, Lorenzo Pieralisi wrote:
> > > > The SBBR and ACPI specifications allow ACPI based systems that do not
> > > > implement PSCI (eg systems with no EL3) to boot through the ACPI parking
> > > > protocol specification[1].
> > > > 
> > > > This patch implements the ACPI parking protocol CPU operations, and adds
> > > > code that eases parsing the parking protocol data structures to the
> > > > ARM64 SMP initializion carried out at the same time as cpus enumeration.
> > > > 
> > > > To wake-up the CPUs from the parked state, this patch implements a
> > > > wakeup IPI for ARM64 (ie arch_send_wakeup_ipi_mask()) that mirrors the
> > > > ARM one, so that a specific IPI is sent for wake-up purpose in order
> > > > to distinguish it from other IPI sources.
> > > > 
> > > > Given the current ACPI MADT parsing API, the patch implements a glue
> > > > layer that helps passing MADT GICC data structure from SMP initialization
> > > > code to the parking protocol implementation somewhat overriding the CPU
> > > > operations interfaces. This to avoid creating a completely trasparent
> > > > DT/ACPI CPU operations layer that would require creating opaque
> > > > structure handling for CPUs data (DT represents CPU through DT nodes, ACPI
> > > > through static MADT table entries), which seems overkill given that ACPI
> > > > on ARM64 mandates only two booting protocols (PSCI and parking protocol),
> > > > so there is no need for further protocol additions.
> > > > 
> > > > Based on the original work by Mark Salter <msalter@redhat.com>
> > > > 
> > > > [1] https://acpica.org/sites/acpica/files/MP%20Startup%20for%20ARM%20platforms.docx
> > > > 
> > > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > Cc: Will Deacon <will.deacon@arm.com>
> > > > Cc: Hanjun Guo <hanjun.guo@linaro.org>
> > > > Cc: Loc Ho <lho@apm.com>
> > > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: Mark Salter <msalter@redhat.com>
> > > > Cc: Al Stone <ahs3@redhat.com>
> > > 
> > > Applied, with a minor addition just to warn people from not using it in
> > > other configurations (#ifdef still needed otherwise the
> > > acpi_parking_protocol_valid symbol is not available; but I prefer uglier
> > > code than people starting to use this IPI in their firmware):
> > 
> > It makes sense, we could include asm/acpi.h in smp.c (which is not
> > included by linux/acpi.h if !CONFIG_ACPI) to pull in the symbol and
> > remove the ifdef if you think it is cleaner.
> 
> I don't think it's worth.
> 
> BTW, the acpi_parking_protocol_valid() definition has an __init
> annotation while the declaration does not. I removed the __init
> altogether since I get a section mismatch warning when being called from
> handle_IPI.

Catalin,

Itaru spotted an issue related to ioremapping the mailbox in the
cpu_postboot method where I can't really use ioremap since irqs
are disabled on the secondaries coming up at that point, I missed
that, apologies (I wanted to avoid leaving the mailboxes mapped
after boot).

So, options to fix it:

(1) we leave the mailboxes mapped
(2) we remove the FW check in the postboot method (running on
    secondaries)
(3) I add a cpu_ops method to clean-up resources used for
    booting secondaries and there I can unmap the mailboxes

Frankly, they are all unappealing, I would go for (1), patch below, Itaru
can you give it a go please on Mustang against arm64 for-next/core ?

Thanks,
Lorenzo

-- >8 --
diff --git a/arch/arm64/kernel/acpi_parking_protocol.c b/arch/arm64/kernel/acpi_parking_protocol.c
index 4b1e5a7..b56fc0d 100644
--- a/arch/arm64/kernel/acpi_parking_protocol.c
+++ b/arch/arm64/kernel/acpi_parking_protocol.c
@@ -21,7 +21,14 @@
 
 #include <asm/cpu_ops.h>
 
+struct parking_protocol_mailbox {
+	__le32 cpu_id;
+	__le32 reserved;
+	__le64 entry_point;
+};
+
 struct cpu_mailbox_entry {
+	struct parking_protocol_mailbox __iomem *mailbox;
 	phys_addr_t mailbox_addr;
 	u8 version;
 	u8 gic_cpu_id;
@@ -59,12 +66,6 @@ static int acpi_parking_protocol_cpu_prepare(unsigned int cpu)
 	return 0;
 }
 
-struct parking_protocol_mailbox {
-	__le32 cpu_id;
-	__le32 reserved;
-	__le64 entry_point;
-};
-
 static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
 {
 	struct cpu_mailbox_entry *cpu_entry = &cpu_mailbox_entries[cpu];
@@ -107,7 +108,11 @@ static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
 
 	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
 
-	iounmap(mailbox);
+	/*
+	 * stash the mailbox address mapping to use it for checks
+	 * in post boot method
+	 */
+	cpu_entry->mailbox = mailbox;
 
 	return 0;
 }
@@ -116,32 +121,15 @@ static void acpi_parking_protocol_cpu_postboot(void)
 {
 	int cpu = smp_processor_id();
 	struct cpu_mailbox_entry *cpu_entry = &cpu_mailbox_entries[cpu];
-	struct parking_protocol_mailbox __iomem *mailbox;
+	struct parking_protocol_mailbox __iomem *mailbox = cpu_entry->mailbox;
 	__le64 entry_point;
 
-	/*
-	 * Map mailbox memory with attribute device nGnRE (ie ioremap -
-	 * this deviates from the parking protocol specifications since
-	 * the mailboxes are required to be mapped nGnRnE; the attribute
-	 * discrepancy is harmless insofar as the protocol specification
-	 * is concerned).
-	 * If the mailbox is mistakenly allocated in the linear mapping
-	 * by FW ioremap will fail since the mapping will be prevented
-	 * by the kernel (it clashes with the linear mapping attributes
-	 * specifications).
-	 */
-	mailbox = ioremap(cpu_entry->mailbox_addr, sizeof(*mailbox));
-	if (!mailbox)
-		return;
-
 	entry_point = readl_relaxed(&mailbox->entry_point);
 	/*
 	 * Check if firmware has cleared the entry_point as expected
 	 * by the protocol specification.
 	 */
 	WARN_ON(entry_point);
-
-	iounmap(mailbox);
 }
 
 const struct cpu_operations acpi_parking_protocol_ops = {
