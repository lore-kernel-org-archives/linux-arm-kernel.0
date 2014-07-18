From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 18 Jul 2014 14:57:38 +0100
Subject: [PATCHv4 5/5] arm64: cpuinfo: print info for all CPUs
In-Reply-To: <20140718095311.GA1818@arm.com>
References: <CAFEAcA-_GawEimGS4q8=C7BK6gLzSA+xVSUtLFkUS5=Mf8syBw@mail.gmail.com>
 <53C7A980.8050601@arm.com> <20140717105415.GI21153@arm.com>
 <CAFEAcA8wZ9z8+0Q-2D_B3tkuQnksdWFeWEAadkHyB72oS6ae=A@mail.gmail.com>
 <20140717123533.GJ21153@arm.com>
 <CAFEAcA_ZXDDRycNVXmw1FSgRFiPgtB_2qqe-ioj91jMeBJR7PQ@mail.gmail.com>
 <20140717171058.GM18203@arm.com> <20140717172858.GD4844@arm.com>
 <20140718092744.GA19850@arm.com> <20140718095311.GA1818@arm.com>
Message-ID: <20140718135738.GA17328@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 10:53:12AM +0100, Will Deacon wrote:
> On Fri, Jul 18, 2014 at 10:27:44AM +0100, Catalin Marinas wrote:
> > On Thu, Jul 17, 2014 at 06:28:58PM +0100, Will Deacon wrote:
> > > On Thu, Jul 17, 2014 at 06:10:58PM +0100, Catalin Marinas wrote:
> > > > On Thu, Jul 17, 2014 at 02:55:37PM +0100, Peter Maydell wrote:
> > > > > On 17 July 2014 13:35, Will Deacon <will.deacon@arm.com> wrote:
> > > > > > We're not denying the possibility of heterogeneity, we're trying to expose a
> > > > > > consistent view of the system to userspace. Differences between cores should
> > > > > > be dealt with by the kernel (e.g. IKS, HMP scheduling), not blindly
> > > > > > passed off to userspace.
> > > > > 
> > > > > On that basis, why report anything at all about invididual cores?
> > > > > Just have /proc/cpuinfo report "number of processors: 4" and
> > > > > no per-CPU information at all...
> > > > 
> > > > We lost a lot of time on this already (given the internal threads). So
> > > > my proposal is to go ahead with Mark's patch with per-CPU features. They
> > > > currently just include the same elf_hwcap multiple times. If we ever
> > > > need to present different features, the conditions would be:
> > > > 
> > > > 1. Never report more than elf_hwcap
> > > > 2. elf_hwcap can only include non-symmetric features *if* Linux gets a
> > > >    way to transparently handle migration or emulation
> > > 
> > > ... making the point of a per-cpu field entirely pointless ;)
> > 
> > Well, if we can support such features in a transparent way,
> > /proc/cpuinfo becomes more informative (e.g. user wondering why a
> > process runs only on certain CPUs).
> > 
> > But to be clear (and I think we are aligned), I don't trust user space
> > to parse all processors in /proc/cpuinfo and make an informed selection
> > of CPU affinity to avoid SIGILL.
> > 
> > Yet another option would be to have a single features/hwcap line and
> > present the extra features in a human (and only human) readable form
> > (e.g. some haiku that changes with every kernel release ;)).
> 
> Or just have the single features line, then the per-cpu line can be called
> `flags' or something, like Ard suggested. If userspace decides to parse
> flags, it deserves all the pain that it gets.

Ok. I think retaining the current (common) features line makes sense if
it's clearly separated from any particular CPU. If we need per-cpu
information later, this can be in addition to the common line.

That should enable software which only does mildy crazy things with
values from /proc/cpuinfo to work even if we print per-cpu information.
Anything trying to handle per-cpu differences will need rework
regardless, and that discussion can be had when we actually have crazily
heterogeneous systems.

Therefore, how about the below?

Thanks,
Mark.

---->8----
>From 7dc7b5e5c4a54f56a5a7e59d2dd0de009dc9b9d0 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Thu, 26 Jun 2014 16:18:44 +0100
Subject: [PATCH] arm64: cpuinfo: print info for all CPUs

Currently reading /proc/cpuinfo will result in information being read
out of the MIDR_EL1 of the current CPU, and the information is not
associated with any particular logical CPU number.

This is problematic for systems with heterogeneous CPUs (i.e.
big.LITTLE) where MIDR fields will vary across CPUs, and the output will
differ depending on the executing CPU.

This patch reorganises the code responsible for /proc/cpuinfo to print
information per-cpu. In the process, we perform several cleanups:

* Property names are coerced to lower-case (to match "processor" as per
  glibc's expectations).
* Property names are simplified and made to match the MIDR field names.
* Revision is changed to hex as with every other field.
* The meaningless Architecture property is removed.
* The ripe-for-abuse Machine field is removed.

The features field (a human-readable representation of the hwcaps)
remains printed once, as this is expected to remain in use as the
globally support CPU features. To enable the possibility of the addition
of per-cpu HW feature information later, this is printed before any
CPU-specific information.

Comments are added to guide userspace developers in the right direction
(using the hwcaps provided in auxval). Hopefully where userspace
applications parse /proc/cpuinfo rather than using the readily available
hwcaps, they limit themselves to reading said first line.

If CPU features differ from each other, the previously installed sanity
checks will give us some advance notice with warnings and
TAINT_CPU_OUT_OF_SPEC. If we are lucky, we will never see such systems.
Rework will be required in many places to support such systems anyway.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marcus Shawcroft <marcus.shawcroft@arm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/setup.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index edb146d..aaf1ddb 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -450,10 +450,21 @@ static int c_show(struct seq_file *m, void *v)
 {
 	int i;
 
-	seq_printf(m, "Processor\t: %s rev %d (%s)\n",
-		   cpu_name, read_cpuid_id() & 15, ELF_PLATFORM);
+	/*
+	 * Dump out the common processor features in a single line. Userspace
+	 * should read the hwcaps with getauxval(AT_HWCAP) rather than
+	 * attempting to parse this.
+	 */
+	seq_puts(m, "features\t:");
+	for (i = 0; hwcap_str[i]; i++)
+		if (elf_hwcap & (1 << i))
+			seq_printf(m, " %s", hwcap_str[i]);
+	seq_puts(m, "\n\n");
 
 	for_each_online_cpu(i) {
+		struct cpuinfo_arm64 *cpuinfo = &per_cpu(cpu_data, i);
+		u32 midr = cpuinfo->reg_midr;
+
 		/*
 		 * glibc reads /proc/cpuinfo to determine the number of
 		 * online processors, looking for lines beginning with
@@ -462,25 +473,13 @@ static int c_show(struct seq_file *m, void *v)
 #ifdef CONFIG_SMP
 		seq_printf(m, "processor\t: %d\n", i);
 #endif
+		seq_printf(m, "implementer\t: 0x%02x\n",
+			   MIDR_IMPLEMENTOR(midr));
+		seq_printf(m, "variant\t\t: 0x%x\n", MIDR_VARIANT(midr));
+		seq_printf(m, "partnum\t\t: 0x%03x\n", MIDR_PARTNUM(midr));
+		seq_printf(m, "revision\t: 0x%x\n\n", MIDR_REVISION(midr));
 	}
 
-	/* dump out the processor features */
-	seq_puts(m, "Features\t: ");
-
-	for (i = 0; hwcap_str[i]; i++)
-		if (elf_hwcap & (1 << i))
-			seq_printf(m, "%s ", hwcap_str[i]);
-
-	seq_printf(m, "\nCPU implementer\t: 0x%02x\n", read_cpuid_id() >> 24);
-	seq_printf(m, "CPU architecture: AArch64\n");
-	seq_printf(m, "CPU variant\t: 0x%x\n", (read_cpuid_id() >> 20) & 15);
-	seq_printf(m, "CPU part\t: 0x%03x\n", (read_cpuid_id() >> 4) & 0xfff);
-	seq_printf(m, "CPU revision\t: %d\n", read_cpuid_id() & 15);
-
-	seq_puts(m, "\n");
-
-	seq_printf(m, "Hardware\t: %s\n", machine_name);
-
 	return 0;
 }
 
-- 
1.9.1
