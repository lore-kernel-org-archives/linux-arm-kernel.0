From: sundar.iyer@stericsson.com (Sundar R IYER)
Date: Fri, 16 Apr 2010 15:37:23 +0200
Subject: [PATCH] ARM: Fix "BUG: scheduling while atomic:
	swapper/0/0x00000002"
Message-ID: <33A307AF30D7BF4F811B1568FE7A9B18033BCFF3@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh/Russell,


>Hmm, I don't think this is how we should be solving this problem.

>x86 calls init_idle() on the idle task when it's re-used, and this

>resets the preempt count amongst other things.  So maybe we want to

>do this instead in the __cpu_up path:

The following patch fixes the dump messages at my end during re-onlining the offline CPU.

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 577543f..ee1d608 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -86,6 +86,9 @@ int __cpuinit __cpu_up(unsigned int cpu)
                                                return PTR_ERR(idle);
                                }
                                ci->idle = idle;
+              } else {
+                              /* fix any preempt leaks whilst going down */
+                              init_idle(idle, cpu);
                }

Please let me know if this is alright.

Thanx!
Sundar
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100416/51e730a4/attachment.htm>
