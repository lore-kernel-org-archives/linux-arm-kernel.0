From: wxt@rock-chips.com (Caesar Wang)
Date: Tue,  3 Nov 2015 16:10:08 +0800
Subject: [RESEND PATCH 0/1] Fix the "hard LOCKUP" when running a heavy loading
Message-ID: <1446538209-13490-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the following log:
where we experience a CPU hard lockup. The assembly code (disassembled by gdb)

0xc06c6e90 <__tcp_select_window+148>:        beq     0xc06c6eb0<__tcp_select_window+180>
0xc06c6e94 <__tcp_select_window+152>:        mov     r2, #1008; 0x3f0
0xc06c6e98 <__tcp_select_window+156>:        ldr     r5, [r0,#1004] ; 0x3ec
0xc06c6e9c <__tcp_select_window+160>:        ldrh    r2, [r0,r2]
....

0xc06c6ee0 <__tcp_select_window+228>:        addne   r0, r0, #1
0xc06c6ee4 <__tcp_select_window+232>:        lslne   r0, r0, r2
0xc06c6ee8 <__tcp_select_window+236>:        ldmne   sp, {r4, r5,r11, sp,pc}

Could either the ?strhi?/?strlo? pair, or the lslne/ldmne pair, be
tripping over errata 818325, or a similar errata?

0xc06c6eec <__tcp_select_window+240>:        b       0xc06c6f40<__tcp_select_window+324>

This is patch can fix the *hard lock* in some case.

As the Russell said:
"in other words, which can be handled by updating a control register in the firmware or
boot loader"
Maybe the better solution is in firmware.

Others, I'm no sure this workaround patch if can be accepted.

I resend this patch for getting some suggestion from you.

--
Thanks!



Huang Tao (1):
  ARM: errata: Workaround for Cortex-A12 erratum 818325

 arch/arm/Kconfig      | 13 +++++++++++++
 arch/arm/mm/proc-v7.S | 12 ++++++++++++
 2 files changed, 25 insertions(+)

-- 
1.9.1
