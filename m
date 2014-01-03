From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 3 Jan 2014 18:04:33 +0100
Subject: [PATCH] arm/smp: Make boot_secondary() static
In-Reply-To: <1388763959-27491-1-git-send-email-geert@linux-m68k.org>
References: <1388763959-27491-1-git-send-email-geert@linux-m68k.org>
Message-ID: <201401031804.34124.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 January 2014, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> 
> After becoming a mandatory function, boot_secondary() is no longer used
> outside arch/arm/kernel/smp.c. Hence make it static.
> The code is reshuffled a bit to avoid a forward declaration.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

How about taking it one step further by removing the function entirely?
Like this:

@@ -92,6 +92,9 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 {
 	int ret;
 
+	if (!smp_ops.smp_boot_secondary)
+		return -ENOSYS;
+
 	/*
 	 * We need to tell the secondary core where to find
 	 * its stack and the page tables.
@@ -111,7 +114,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 	/*
 	 * Now bring the CPU into our world.
 	 */
-	ret = boot_secondary(cpu, idle);
+	ret = smp_ops.smp_boot_secondary(cpu, idle);
 	if (ret == 0) {
 		/*
 		 * CPU was successfully started, wait for it


I guess we could do the same for some of the other operations as well
if everyone likes the approach.

	Arnd
