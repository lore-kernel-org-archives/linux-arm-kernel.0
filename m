From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Aug 2010 00:05:41 +0100
Subject: hotplug and init section
In-Reply-To: <4C5898AD.9020300@codeaurora.org>
References: <989bc3c9f8d8ce1d51c480a0dbdce07e.squirrel@www.codeaurora.org>
	<20100722205753.GU31293@n2100.arm.linux.org.uk>
	<4C5898AD.9020300@codeaurora.org>
Message-ID: <20100803230541.GA30769@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 03, 2010 at 03:31:09PM -0700, Jeff Ohlstein wrote:
> So I've been looking into this, and it does look like I need to change  
> the linker script. I need the secondary_startup function to be around at  
> hotplug time, and it appears that the whole head section gets freed with  
> the init section. Does it seem sane to make it so the head section isn't  
> freed when hotplug is configured? Or should I move the secondary startup  
> function out of the head section?

Try this - I've only build-tested this so far:

diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index b9505aa..98949b2 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -143,7 +143,7 @@ __error:
 	b	1b
 ENDPROC(__error)
 
-
+	__CPUINIT
 /*
  * Read processor ID register (CP#15, CR0), and look up in the linker-built
  * supported processor list.  Note that we can't use the absolute addresses
@@ -235,6 +235,7 @@ ENTRY(lookup_machine_type)
 	ldmfd	sp!, {r4 - r6, pc}
 ENDPROC(lookup_machine_type)
 
+	__HEAD
 /* Determine validity of the r2 atags pointer.  The heuristic requires
  * that the pointer be aligned, in the first 16k of physical RAM and
  * that the ATAG_CORE marker is first and present.  Future revisions
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index eb62bf9..7e0a673 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -104,6 +104,7 @@ ENTRY(stext)
 ENDPROC(stext)
 
 #if defined(CONFIG_SMP)
+	__CPUINIT
 ENTRY(secondary_startup)
 	/*
 	 * Common entry point for secondary CPUs.
@@ -202,7 +203,7 @@ __turn_mmu_on:
 	mov	pc, r3
 ENDPROC(__turn_mmu_on)
 
-
+	__HEAD
 /*
  * Setup the initial page tables.  We only setup the barest
  * amount which are required to get the kernel running, which
