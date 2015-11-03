From: will.deacon@arm.com (Will Deacon)
Date: Tue, 3 Nov 2015 11:30:30 +0000
Subject: [RESEND PATCH 0/1] Fix the "hard LOCKUP" when running a heavy
 loading
In-Reply-To: <1446538209-13490-1-git-send-email-wxt@rock-chips.com>
References: <1446538209-13490-1-git-send-email-wxt@rock-chips.com>
Message-ID: <20151103113030.GB14159@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2015 at 04:10:08PM +0800, Caesar Wang wrote:
> As the following log:
> where we experience a CPU hard lockup. The assembly code (disassembled by gdb)
> 
> 0xc06c6e90 <__tcp_select_window+148>:        beq     0xc06c6eb0<__tcp_select_window+180>
> 0xc06c6e94 <__tcp_select_window+152>:        mov     r2, #1008; 0x3f0
> 0xc06c6e98 <__tcp_select_window+156>:        ldr     r5, [r0,#1004] ; 0x3ec
> 0xc06c6e9c <__tcp_select_window+160>:        ldrh    r2, [r0,r2]
> ....
> 
> 0xc06c6ee0 <__tcp_select_window+228>:        addne   r0, r0, #1
> 0xc06c6ee4 <__tcp_select_window+232>:        lslne   r0, r0, r2
> 0xc06c6ee8 <__tcp_select_window+236>:        ldmne   sp, {r4, r5,r11, sp,pc}
> 
> Could either the ?strhi?/?strlo? pair, or the lslne/ldmne pair, be
> tripping over errata 818325, or a similar errata?

No. One of the conditions for #818325 is:

  The second instruction is an UNPREDICTABLE STR or STM (maximum two2
  registers in the list) with write-back and the write-back register is
  in the list of stored registers.

I don't see either of those in your code snippet above, but then I don't
see your strhi/strlo either. What's going on?

> 0xc06c6eec <__tcp_select_window+240>:        b       0xc06c6f40<__tcp_select_window+324>
> 
> This is patch can fix the *hard lock* in some case.
> 
> As the Russell said:
> "in other words, which can be handled by updating a control register in the firmware or
> boot loader"

Russell is completely correct: this should be worked around in firmware.
There are a number of reasons for that:

  (1) You want the workaround enabled for all privilege and security
      levels, which means applying it before you enter the kernel.

  (2) If Linux boots in non-secure, then the workaround may silently
      fail to apply.

  (3) The CPU may have an ECO fix, in which case we wouldn't want to
      enable the workaround.

  (4) Some workarounds (albeit not this one, afaict) require changing
      CPU configuration that can only be done very early on, e.g. whilst
      "the memory system is idle".

Now, I appreciate that doing this in the kernel may be the easiest thing
for your particular SoC, but that doesn't necessarily mean that it's the
best thing to do in the mainline kernel. Whilst there *is* precedent for
this already, we've been trying to move away from setting these bits in
the kernel for the reasons mentioned above.

Will
