From: zyxsjl@126.com (zyxsjl)
Date: Tue, 27 Oct 2009 11:54:24 +0800 (CST)
Subject: abt kernel 2.6 compressed/head.s
Message-ID: <18250270.157661256615664391.JavaMail.coremail@bj126app51.126.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
 hi anyone, 
I have not understood some code in this file below: 
    #ifndef CONFIG_ZBOOT_ROM
  /*
* If we're running fully PIC === CONFIG_ZBOOT_ROM = n,
* we need to fix up pointers into the BSS region.
  * r2 - BSS start
  * r3 - BSS end
  * sp - stack pointer
  */
  add r2, r2, r0
  add r3, r3, r0
  add sp, sp, r0
  /*
  * Relocate all entries in the GOT table.
  */
1: ldr r1, [r6, #0] @ relocate entries in the GOT
add r1, r1, r0 @ table. This fixes up the
  str r1, [r6], #4 @ C references.
  cmp r6, ip
  blo 1b
#else
  /*
* Relocate entries in the GOT table. We only relocate
* the entries that are outside the (relocated) BSS region.
  */
1: ldr r1, [r6, #0] @ relocate entries in the GOT
  cmp r1, r2 @ entry < bss_start ||
  cmphs r3, r1   @ _end < entry
addlo r1, r1, r0 @ table. This fixes up the
  str r1, [r6], #4 @ C references.
  cmp r6, ip
  blo 1b
#endif
my question is:what is the different between the both CONFIG_ZBOOT_ROM=y or n, and so led to the different tackles from the above code on relocation?
 thanks ahead
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091027/78b61379/attachment-0001.htm>
