From: pbonzini@redhat.com (Paolo Bonzini)
Date: Mon, 01 Jun 2015 13:34:53 +0200
Subject: [PATCH v2] arm/arm64: KVM: Properly account for guest CPU time
In-Reply-To: <556C0E22.9090401@de.ibm.com>
References: <1432838950-28774-1-git-send-email-christoffer.dall@linaro.org>
 <556C0E22.9090401@de.ibm.com>
Message-ID: <556C435D.3050900@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/06/2015 09:47, Christian Borntraeger wrote:
> 
> 1: "disable", "guest", "disable again and save", "restore to disable", "enable"
> and now it is
> 2: "disable", "guest", "enable"
> and with your patch it is
> 3: "disable", "guest", "enable", "disable, "enable"
> 
> I assume that 3 and 1 are similar in its costs, so this is probably ok.

At least on x86, 3 and 2 are similar, but 3 is much more expensive than
1!  See https://lkml.org/lkml/2015/5/5/835:

Cost of: CLI                         insn  same-IF :     0 cycles
Cost of: CLI                         insn  flip-IF :     0 cycles
Cost of: STI                         insn  same-IF :     0 cycles
Cost of: STI                         insn  flip-IF :     0 cycles
Cost of: PUSHF                       insn          :     0 cycles
Cost of: POPF                        insn  same-IF :    20 cycles
Cost of: POPF                        insn  flip-IF :    28 cycles
Cost of: local_irq_save()            fn            :    20 cycles
Cost of: local_irq_restore()         fn    same-IF :    24 cycles
Cost of: local_irq_restore()         fn    flip-IF :    28 cycles
Cost of: irq_save()+restore()        fn    same-IF :    48 cycles
Cost of: irq_save()+restore()        fn    flip-IF :    48 cycles

Paolo
