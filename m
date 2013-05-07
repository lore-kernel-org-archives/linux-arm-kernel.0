From: holt@sgi.com (Robin Holt)
Date: Tue,  7 May 2013 09:39:44 -0500
Subject: [PATCH -v8 00/11] Shutdown from reboot_cpuid without stopping other
 cpus.
Message-ID: <1367937595-32241-1-git-send-email-holt@sgi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We recently noticed that reboot of a 1024 cpu machine takes approx 16
minutes of just stopping the cpus.  The slowdown was tracked to commit
f96972f.

The current implementation does all the work of hot removing the cpus
before halting the system.  We are switching to just migrating to the
reboot_cpu and then continuing with shutdown/reboot.

The patch set is broken into eleven parts.  The first two are planned for
the stable release.  The others move the halt/shutdown/reboot related
functions to their own kernel/reboot.c file and then move the handling
of the kernel reboot= kernel parameter to generic kernel code.


Changes since -v7.
 - Fixed authorship for first patch.

 - Rebased to Linus' current tree (51a26ae7a).

Changes since -v6.
 - Cross compiled all arm architectures (using v3.9 kernel.  Fails with
   current).

 - Added a #define for non-hotplug case.

 - Add #define for PF_THREAD_BOUND as compatibility to make stable easier.

 - Fixup s/reboot_cpu_id/reboot_cpu/

 - Add include of linux/uaccess.h to allow building on arm.

 - Removed last remaining checkpatch.pl line length warning on
   kernel/reboot.c.

 - Fixed the duplicate handling or the reboot= kernel parameter.

Changes since -v5.
 - Moved the arch/x86 reboot= up to the generic kernel code.

Changes since -v4.
 - Integrated Srivatsa S. Bhat creating cpu_hotplug_disable()
   function

 - Integrated comments by Srivatsa S. Bhat.

 - Made one more comment consistent with others in function.

Changes since -v3.
 - Added a tested-by for the original reporter.

 - Fix compile failure found by Joe Perches.

 - Integrated comments by Joe Perches.


To: Andrew Morton <akpm@linux-foundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Russ Anderson <rja@sgi.com>
Cc: Robin Holt <holt@sgi.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: the arch/x86 maintainers <x86@kernel.org>
Cc: Arm Mailing List <linux-arm-kernel@lists.infradead.org>
