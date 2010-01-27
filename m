From: dirk.behme@googlemail.com (Dirk Behme)
Date: Wed, 27 Jan 2010 17:45:06 +0100
Subject: ARM11 MPCore: Adding nop to __delay() doubles the BogoMIPS/lpj
Message-ID: <4B606D92.9020005@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On a 400MHz ARM11 MPCore system (NEC NaviEngine based) with kernel 
2.6.32 we found that BogoMIPS/loops per jiffies ~doubles (see below 
[1]) by adding a nop to __delay():

--- a/arch/arm/lib/delay.S
+++ b/arch/arm/lib/delay.S
@@ -41,6 +41,9 @@ ENTRY(__const_udelay)    @ 0 <= r0 <= 0x
  @ Delay routine
  ENTRY(__delay)
+#if defined(CONFIG_CPU_V6) && defined(CONFIG_SMP)
+        nop
+#endif
          subs    r0, r0, #1
  #if 0
          movls    pc, lr

Any ideas what might happen here?

Many thanks and best regards

Dirk

[1] 2.6.32 without and with additional nop in __delay():

====> Clean 2.6.32 without nop in __delay():

...
Calibrating delay loop... 159.74 BogoMIPS (lpj=798720)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Calibrating local timer... 199.98MHz.
CPU1: Booted secondary processor
Calibrating delay loop... 159.33 BogoMIPS (lpj=796672)
CPU2: Booted secondary processor
Calibrating delay loop... 159.74 BogoMIPS (lpj=798720)
Brought up 3 CPUs
SMP: Total of 3 processors activated (478.82 BogoMIPS).
...

Disassembly:

         |@ Delay routine
         |ENTRY(__delay)
C0940600|E2500001  __delay:  subs    r0,r0,#0x1
C0940604|8AFFFFFD        bhi     0xC0940600       ; __delay
C0940608|E1A0F00E        cpy     pc,r14



====> With an additional nop in __delay():

...
Calibrating delay loop... 398.95 BogoMIPS (lpj=1994752)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Calibrating local timer... 199.97MHz.
CPU1: Booted secondary processor
Calibrating delay loop... 398.95 BogoMIPS (lpj=1994752)
CPU2: Booted secondary processor
Calibrating delay loop... 398.95 BogoMIPS (lpj=1994752)
Brought up 3 CPUs
SMP: Total of 3 processors activated (1196.85 BogoMIPS).
...

Disassembly:

         |@ Delay routine
         |ENTRY(__delay)
         |#if defined(CONFIG_CPU_V6) && defined(CONFIG_SMP)
C0940600|E320F000  __delay:  nop
         |#endif
C0940604|E2500001        subs    r0,r0,#0x1
C0940608|8AFFFFFC        bhi     0xC0940600       ; __delay
C094060C|E1A0F00E        cpy     pc,r14
