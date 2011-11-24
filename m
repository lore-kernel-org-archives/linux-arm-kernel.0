From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 24 Nov 2011 23:37:36 +0100
Subject: [PATCH] ARM : fix /proc/interrupts per online cpu
In-Reply-To: <20111124202138.GQ9581@n2100.arm.linux.org.uk>
References: <1322150719-28243-1-git-send-email-daniel.lezcano@linaro.org>
 <20111124202138.GQ9581@n2100.arm.linux.org.uk>
Message-ID: <4ECEC730.2090802@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/24/2011 09:21 PM, Russell King - ARM Linux wrote:
> On Thu, Nov 24, 2011 at 05:05:19PM +0100, Daniel Lezcano wrote:
>> The loop should look at the online cpus instead of the present cpus
>> in order to hide the offline cpus in procfs like it is done on the
>> other architectures.
> 
> And what happens if you're reading /proc/interrupts while a CPU is
> changing state?

> Given that it's just user presentation, whether its online or present
> makes little odds - and having it as present CPUs makes the output
> 100% stable with the effects of hotplug.

IMO, there is no problem to read /proc/interrupts while a CPU is
changing its state. In the worst case, we will show an obsolete
information to the userspace. The same happens when we do 'ps', we have
no guarantee a process still exists when the information is displayed.
But I may be wrong and in this case, the other arch have a bug.

The procfs is used as an API from the userspace and AFAICS the other
architectures display their arch specific interrupts for the online
cpus, not the present cpus.

Other non-arch dependant informations are per online cpus, so while
looking at the /proc/interrupts we have column shift for the IPI on ARM.

I don't know if it is worth to fix that but that may be more consistent.

Thanks

  -- Daniel



./sparc/kernel/irq_64.c:int arch_show_interrupts(struct seq_file *p, int
prec)
./sparc/kernel/irq_64.c-{
./sparc/kernel/irq_64.c-	int j;
./sparc/kernel/irq_64.c-
./sparc/kernel/irq_64.c-	seq_printf(p, "NMI: ");
./sparc/kernel/irq_64.c-	for_each_online_cpu(j)
./sparc/kernel/irq_64.c-		seq_printf(p, "%10u ", cpu_data(j).__nmi_count);
./sparc/kernel/irq_64.c-	seq_printf(p, "     Non-maskable interrupts\n");
./sparc/kernel/irq_64.c-	return 0;
./sparc/kernel/irq_64.c-}

- -----------------------------------------------------------------------

./sparc/kernel/irq_32.c:int arch_show_interrupts(struct seq_file *p, int
prec)
./sparc/kernel/irq_32.c-{
./sparc/kernel/irq_32.c-	int j;
./sparc/kernel/irq_32.c-
./sparc/kernel/irq_32.c-#ifdef CONFIG_SMP
./sparc/kernel/irq_32.c-	seq_printf(p, "RES: ");
./sparc/kernel/irq_32.c-	for_each_online_cpu(j)
./sparc/kernel/irq_32.c-		seq_printf(p, "%10u ",
cpu_data(j).irq_resched_count);
./sparc/kernel/irq_32.c-	seq_printf(p, "     IPI rescheduling
interrupts\n");
./sparc/kernel/irq_32.c-	seq_printf(p, "CAL: ");
./sparc/kernel/irq_32.c-	for_each_online_cpu(j)

- -----------------------------------------------------------------------

./powerpc/kernel/irq.c:int arch_show_interrupts(struct seq_file *p, int
prec)
./powerpc/kernel/irq.c-{
./powerpc/kernel/irq.c-	int j;
./powerpc/kernel/irq.c-
./powerpc/kernel/irq.c-#if defined(CONFIG_PPC32) && defined(CONFIG_TAU_INT)
./powerpc/kernel/irq.c-	if (tau_initialized) {
./powerpc/kernel/irq.c-		seq_printf(p, "%*s: ", prec, "TAU");
./powerpc/kernel/irq.c-		for_each_online_cpu(j)
./powerpc/kernel/irq.c-			seq_printf(p, "%10u ", tau_interrupts(j));
./powerpc/kernel/irq.c-		seq_puts(p, "  PowerPC             Thermal
Assist (cpu temp)\n");
./powerpc/kernel/irq.c-	}

- ------------------------------------------------------------------------

./x86/kernel/irq.c:int arch_show_interrupts(struct seq_file *p, int prec)
./x86/kernel/irq.c-{
./x86/kernel/irq.c-	int j;
./x86/kernel/irq.c-
./x86/kernel/irq.c-	seq_printf(p, "%*s: ", prec, "NMI");
./x86/kernel/irq.c-	for_each_online_cpu(j)
./x86/kernel/irq.c-		seq_printf(p, "%10u ", irq_stats(j)->__nmi_count);
./x86/kernel/irq.c-	seq_printf(p, "  Non-maskable interrupts\n");
./x86/kernel/irq.c-#ifdef CONFIG_X86_LOCAL_APIC
./x86/kernel/irq.c-	seq_printf(p, "%*s: ", prec, "LOC");
./x86/kernel/irq.c-	for_each_online_cpu(j)

- ------------------------------------------------------------------------

./mn10300/kernel/irq.c:int arch_show_interrupts(struct seq_file *p, int
prec)
./mn10300/kernel/irq.c-{
./mn10300/kernel/irq.c-#ifdef CONFIG_MN10300_WD_TIMER
./mn10300/kernel/irq.c-	int j;
./mn10300/kernel/irq.c-
./mn10300/kernel/irq.c-	seq_printf(p, "%*s: ", prec, "NMI");
./mn10300/kernel/irq.c-	for (j = 0; j < NR_CPUS; j++)
./mn10300/kernel/irq.c-		if (cpu_online(j))
./mn10300/kernel/irq.c-			seq_printf(p, "%10u ", nmi_count(j));
./mn10300/kernel/irq.c-	seq_putc(p, '\n');
./mn10300/kernel/irq.c-#endif

- ------------------------------------------------------------------------

./alpha/kernel/irq.c:int arch_show_interrupts(struct seq_file *p, int prec)
./alpha/kernel/irq.c-{
./alpha/kernel/irq.c-	int j;
./alpha/kernel/irq.c-
./alpha/kernel/irq.c-#ifdef CONFIG_SMP
./alpha/kernel/irq.c-	seq_puts(p, "IPI: ");
./alpha/kernel/irq.c-	for_each_online_cpu(j)
./alpha/kernel/irq.c-		seq_printf(p, "%10lu ", cpu_data[j].ipi_count);
./alpha/kernel/irq.c-	seq_putc(p, '\n');
./alpha/kernel/irq.c-#endif
./alpha/kernel/irq.c-	seq_puts(p, "PMI: ");

- ------------------------------------------------------------------------

./sh/kernel/irq.c:int arch_show_interrupts(struct seq_file *p, int prec)
./sh/kernel/irq.c-{
./sh/kernel/irq.c-	int j;
./sh/kernel/irq.c-
./sh/kernel/irq.c-	seq_printf(p, "%*s: ", prec, "NMI");
./sh/kernel/irq.c-	for_each_online_cpu(j)
./sh/kernel/irq.c-		seq_printf(p, "%10u ", irq_stat[j].__nmi_count);
./sh/kernel/irq.c-	seq_printf(p, "  Non-maskable interrupts\n");
./sh/kernel/irq.c-
./sh/kernel/irq.c-	seq_printf(p, "%*s: %10u\n", prec, "ERR",
atomic_read(&irq_err_count));
./sh/kernel/irq.c-



- -- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJOzscwAAoJEAKBbMCpUGYA0YgH/jY6R7IxvBqho53Gr5o5N3x6
tH8CWWTAF5qeff7dk++FCq1mfWyGLbEjgXms/0cZ6GgF+3VB80X6uJx/3F3nzeU6
INNua0Z1RtMyJHyNKlcPEd20yikFHVJjLntWsJBLbzS3tMs0CVHM2JUsvivoj0vb
emwb8cUlW1Nvhc21AvFq7xbm+UTGcGbZLJMfOUHvIdfUgU7iV98/DwwRPALFhz51
ojGxOlCT2OZP66HY341RKGNzj60HKvyjaMp3gJXhGWImMr/DREidSq2TJTFsHAMC
Qj8obcE+U/xVNNLeR0VEynxM8TJMhKLph+2wdq3dXDue3/s5mqAsyrp0v2HKNsw=
=st2Y
-----END PGP SIGNATURE-----
