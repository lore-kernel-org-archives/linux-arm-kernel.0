From: slash.tmp@free.fr (Mason)
Date: Fri, 13 Mar 2015 17:03:52 +0100
Subject: read_cpuid_id() in arch/arm/kernel/setup.c
Message-ID: <55030A68.6070002@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

As far as I can tell, read_cpuid_id() resolves to read_cpuid(CPUID_ID)
which resolves to mrc 15, 0, rN, cr0, cr0, {0}

Consider this:

/*
  * The CPU ID never changes at run time, so we might as well tell the
  * compiler that it's constant.  Use this function to read the CPU ID
  * rather than directly reading processor_id or read_cpuid() directly.
  */
static inline unsigned int __attribute_const__ read_cpuid_id(void)
{
	return read_cpuid(CPUID_ID);
}

Despite the comment and attribute, my compiler(*) still reloads the
value every time.

(*) gcc version 4.9.3 20141031 (prerelease) (Linaro GCC 2014.11)

e.g.

static int __get_cpu_architecture(void)
{
	int cpu_arch;

	unsigned int id = read_cpuid_id();
	if ((id & 0x0008f000) == 0) {
		cpu_arch = CPU_ARCH_UNKNOWN;
	} else if ((id & 0x0008f000) == 0x00007000) {
		cpu_arch = (id & (1 << 23)) ? CPU_ARCH_ARMv4T : CPU_ARCH_ARMv3;
	} else if ((id & 0x00080000) == 0x00000000) {
		cpu_arch = (id >> 16) & 7;
		if (cpu_arch)
			cpu_arch += CPU_ARCH_ARMv3;
	} else if ((id & 0x000f0000) == 0x000f0000) {

resolves to

c01fec74:       ee10cf10        mrc     15, 0, ip, cr0, cr0, {0}
c01fec78:       e21cca8f        ands    ip, ip, #585728 ; 0x8f000
c01fec7c:       e34c3023        movt    r3, #49187      ; 0xc023
c01fec80:       e5837008        str     r7, [r3, #8]
c01fec84:       e50b304c        str     r3, [fp, #-76]  ; 0x4c
c01fec88:       0a000022        beq     c01fed18 <setup_arch+0xe4>
c01fec8c:       ee103f10        mrc     15, 0, r3, cr0, cr0, {0}
c01fec90:       e2033a8f        and     r3, r3, #585728 ; 0x8f000
c01fec94:       e3530a07        cmp     r3, #28672      ; 0x7000
c01fec98:       1a000004        bne     c01fecb0 <setup_arch+0x7c>
c01fec9c:       ee103f10        mrc     15, 0, r3, cr0, cr0, {0}
c01feca0:       e3130502        tst     r3, #8388608    ; 0x800000
c01feca4:       13a0c003        movne   ip, #3
c01feca8:       03a0c001        moveq   ip, #1
c01fecac:       ea000019        b       c01fed18 <setup_arch+0xe4>
c01fecb0:       ee103f10        mrc     15, 0, r3, cr0, cr0, {0}
c01fecb4:       e3130702        tst     r3, #524288     ; 0x80000


So I thought it would be nice to give the poor compiler a break,
and just stuff the result in a local variable:

--- setup.c	2015-03-03 18:04:59.000000000 +0100
+++ setup.foo.c	2015-03-13 16:26:56.413380663 +0100
@@ -237,15 +237,16 @@
  {
  	int cpu_arch;
  
-	if ((read_cpuid_id() & 0x0008f000) == 0) {
+	unsigned int id = read_cpuid_id();
+	if ((id & 0x0008f000) == 0) {
  		cpu_arch = CPU_ARCH_UNKNOWN;
-	} else if ((read_cpuid_id() & 0x0008f000) == 0x00007000) {
-		cpu_arch = (read_cpuid_id() & (1 << 23)) ? CPU_ARCH_ARMv4T : CPU_ARCH_ARMv3;
-	} else if ((read_cpuid_id() & 0x00080000) == 0x00000000) {
-		cpu_arch = (read_cpuid_id() >> 16) & 7;
+	} else if ((id & 0x0008f000) == 0x00007000) {
+		cpu_arch = (id & (1 << 23)) ? CPU_ARCH_ARMv4T : CPU_ARCH_ARMv3;
+	} else if ((id & 0x00080000) == 0x00000000) {
+		cpu_arch = (id >> 16) & 7;
  		if (cpu_arch)
  			cpu_arch += CPU_ARCH_ARMv3;
-	} else if ((read_cpuid_id() & 0x000f0000) == 0x000f0000) {
+	} else if ((id & 0x000f0000) == 0x000f0000) {
  		unsigned int mmfr0;
  
  		/* Revised CPUID format. Read the Memory Model Feature


which compiles to

c01fec74:       ee102f10        mrc     15, 0, r2, cr0, cr0, {0}
c01fec78:       e212ca8f        ands    ip, r2, #585728 ; 0x8f000
c01fec7c:       e34c3023        movt    r3, #49187      ; 0xc023
c01fec80:       e5837008        str     r7, [r3, #8]
c01fec84:       e50b304c        str     r3, [fp, #-76]  ; 0x4c
c01fec88:       0a00001c        beq     c01fed00 <setup_arch+0xcc>
c01fec8c:       e35c0a07        cmp     ip, #28672      ; 0x7000
c01fec90:       1a000003        bne     c01feca4 <setup_arch+0x70>
c01fec94:       e3120502        tst     r2, #8388608    ; 0x800000
c01fec98:       13a0c003        movne   ip, #3
c01fec9c:       03a0c001        moveq   ip, #1
c01feca0:       ea000016        b       c01fed00 <setup_arch+0xcc>
c01feca4:       e3120702        tst     r2, #524288     ; 0x80000


Is this nano-optimization worth considering?

Regards.
