From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Wed, 7 Jul 2010 21:54:06 +0400
Subject: [PATCH RFC 0/4] ARM/KGDB: Some fixes for SMP machines
In-Reply-To: <20100707171222.GA16448@oksana.dev.rtsoft.ru>
References: <20100707171222.GA16448@oksana.dev.rtsoft.ru>
Message-ID: <20100707175406.GA28424@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 07, 2010 at 09:12:22PM +0400, Anton Vorontsov wrote:
[...] 
> 2. The patches are against a heavily patched kernel, and so far
>    I didn't rebase them onto the 'debug core' rework as found
>    in the very latest mainline kernels. I'll rebase the patches
>    soon, so for now this is just an RFC.

BTW, I'm testing with another small fixup applied, I didn't send
it as a patch because this deadlock was already fixed in the
debug_core implementation (which KGDB is using nowadays). But
for the completeness, here it is:

(Don't deadlock if there's a wannabe-master CPUs, which entered
KGDB via exception, not NMI/IPI).

diff --git a/kernel/kgdb.c b/kernel/kgdb.c
index e7a2274..65bf75d 100644
--- a/kernel/kgdb.c
+++ b/kernel/kgdb.c
@@ -1522,7 +1522,9 @@ return_normal:
 		 * from the debugger.
 		 */
 		for_each_online_cpu(i) {
-			while (atomic_read(&cpu_in_kgdb[i]))
+			while (atomic_read(&cpu_in_kgdb[i]) &&
+					!(kgdb_info[i].exception_state &
+						DCPU_WANT_MASTER))
 				cpu_relax();
 		}
 	}
