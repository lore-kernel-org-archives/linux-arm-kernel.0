From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 Jun 2013 19:10:30 +0100
Subject: [PATCH v2 1/2] ARM PJ4B: Add support for errata 4742
In-Reply-To: <alpine.LFD.2.03.1306041348400.1200@syhkavp.arg>
References: <1370354598-12920-1-git-send-email-gregory.clement@free-electrons.com>
 <1370354598-12920-2-git-send-email-gregory.clement@free-electrons.com>
 <20130604145958.GY18614@n2100.arm.linux.org.uk>
 <51AE21A7.5080907@free-electrons.com>
 <20130604173737.GZ18614@n2100.arm.linux.org.uk>
 <alpine.LFD.2.03.1306041348400.1200@syhkavp.arg>
Message-ID: <20130604181030.GA18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 04, 2013 at 02:07:29PM -0400, Nicolas Pitre wrote:
> It could be nicer on the symbol table especially when debugging if the 
> pj4b was made into a separate branch table e.g.:
> 
> ENTRY(cpu_pj4b_switch_mm)
> 	b	cpu_v7_switch_mm
> ENDPROC(cpu_pj4b_switch_mm)
> 
> Otherwise the objdump output will always select the first symbol for any 
> given address in alphabetical order, masking away cpu_v7_switch_mm.

That adds unnecessary runtime expense.

> Alternatively, the following could be done:
> 
> #ifdef CONFIG_CPU_PJ4B
> 
> 	.equ	cpu_pj4b_switch_mm,	cpu_v7_switch_mm
> 	.equ	cpu_pj4b_set_pte_ex,	cpu_v7_set_pte_ex

No, that doesn't work.  I did forget a hunk from my patch though, which
needs the pj4b symbols to be global:

diff --git a/arch/arm/include/asm/glue-proc.h b/arch/arm/include/asm/glue-proc.h
index ac1dd54..8017e94 100644
--- a/arch/arm/include/asm/glue-proc.h
+++ b/arch/arm/include/asm/glue-proc.h
@@ -230,6 +230,15 @@
 # endif
 #endif
 
+#ifdef CONFIG_CPU_PJ4B
+# ifdef CPU_NAME
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+# else
+#  define CPU_NAME cpu_pj4b
+# endif
+#endif
+
 #ifndef MULTI_CPU
 #define cpu_proc_init			__glue(CPU_NAME,_proc_init)
 #define cpu_proc_fin			__glue(CPU_NAME,_proc_fin)
