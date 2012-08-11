From: cyril@ti.com (Cyril Chemparathy)
Date: Sat, 11 Aug 2012 10:28:51 -0400
Subject: [PATCH v2 1/2] ARM: arch_timers: enable the use of the virtual
 timer
In-Reply-To: <1344681091-12652-2-git-send-email-marc.zyngier@arm.com>
References: <1344681091-12652-1-git-send-email-marc.zyngier@arm.com>
 <1344681091-12652-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <50266C23.7040802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/11/2012 6:31 AM, Marc Zyngier wrote:
> At the moment, the arch_timer driver only uses the physical timer,
> which can cause problem if PL2 hasn't enabled PL1 access in CNTHCTL,
> which is likely in a virtualized environment. Instead, the virtual
> timer is always available.
>
> This patch enables the use of both the virtual timer, unless no
> interrupt is provided in the DT for it, in which case is falls
> back to the physical timer.
>

I'm curious about the cost of the added pointer chasing introduced by 
this patch.

The original code gets nicely inlined by the compiler, and this hides 
all the switch-case register index stuff.  For instance:

  10797 c001288c <arch_timer_set_next_event>:
  10798 c001288c:       ee1e3f32        mrc     15, 0, r3, cr14, cr2, {1}
  10799 c0012890:       e3c33002        bic     r3, r3, #2
  10800 c0012894:       ee0e0f12        mcr     15, 0, r0, cr14, cr2, {0}
  10801 c0012898:       f57ff06f        isb     sy
  10802 c001289c:       e3833001        orr     r3, r3, #1
  10803 c00128a0:       ee0e3f32        mcr     15, 0, r3, cr14, cr2, {1}
  10804 c00128a4:       f57ff06f        isb     sy
  10805 c00128a8:       e3a00000        mov     r0, #0
  10806 c00128ac:       e12fff1e        bx      lr

With the added pointer chasing, we unfortunately lose out on all the 
work that the compiler used to do for us.  We now end up having to snake 
our way through the following:

  10852 c0012958 <arch_timer_set_next_event>:
  10853 c0012958:       e92d4070        push    {r4, r5, r6, lr}
  10854 c001295c:       e3054400        movw    r4, #21504      ; 0x5400
  10855 c0012960:       e34c401f        movt    r4, #49183      ; 0xc01f
  10856 c0012964:       e1a06000        mov     r6, r0
  10857 c0012968:       e3a00000        mov     r0, #0
  10858 c001296c:       e5943000        ldr     r3, [r4]
  10859 c0012970:       e5933004        ldr     r3, [r3, #4]
  10860 c0012974:       e12fff33        blx     r3
  10861 c0012978:       e5943000        ldr     r3, [r4]
  10862 c001297c:       e3c05002        bic     r5, r0, #2
  10863 c0012980:       e1a01006        mov     r1, r6
  10864 c0012984:       e3a00002        mov     r0, #2
  10865 c0012988:       e5933000        ldr     r3, [r3]
  10866 c001298c:       e12fff33        blx     r3
  10867 c0012990:       e5943000        ldr     r3, [r4]
  10868 c0012994:       e3851001        orr     r1, r5, #1
  10869 c0012998:       e3a00000        mov     r0, #0
  10870 c001299c:       e5933000        ldr     r3, [r3]
  10871 c00129a0:       e12fff33        blx     r3
  10872 c00129a4:       e3a00000        mov     r0, #0
  10873 c00129a8:       e8bd8070        pop     {r4, r5, r6, pc}

  10908 c0012a18 <arch_timer_phys_reg_read>:
  10909 c0012a18:       e3500000        cmp     r0, #0
  10910 c0012a1c:       e92d4008        push    {r3, lr}
  10911 c0012a20:       1a000001        bne     c0012a2c
  10912 c0012a24:       ee1e0f32        mrc     15, 0, r0, cr14, cr2, {1}
  10913 c0012a28:       e8bd8008        pop     {r3, pc}
  10914 c0012a2c:       e3500002        cmp     r0, #2
  10915 c0012a30:       0a000002        beq     c0012a40
  10916 c0012a34:       e3500001        cmp     r0, #1
  10917 c0012a38:       0a000002        beq     c0012a48
  10918 c0012a3c:       eb053afb        bl      c0161630
  10919 c0012a40:       ee1e0f12        mrc     15, 0, r0, cr14, cr2, {0}
  10920 c0012a44:       e8bd8008        pop     {r3, pc}
  10921 c0012a48:       ee1e0f10        mrc     15, 0, r0, cr14, cr0, {0}
  10922 c0012a4c:       e8bd8008        pop     {r3, pc}

  10768 c0012840 <arch_timer_phys_reg_write>:
  10769 c0012840:       e3500000        cmp     r0, #0
  10770 c0012844:       1a000002        bne     c0012854
  10771 c0012848:       ee0e1f32        mcr     15, 0, r1, cr14, cr2, {1}
  10772 c001284c:       f57ff06f        isb     sy
  10773 c0012850:       e12fff1e        bx      lr
  10774 c0012854:       e3500002        cmp     r0, #2
  10775 c0012858:       1afffffb        bne     c001284c
  10776 c001285c:       ee0e1f12        mcr     15, 0, r1, cr14, cr2, {0}
  10777 c0012860:       f57ff06f        isb     sy
  10778 c0012864:       e12fff1e        bx      lr


I think we'd be better off separating between these (virt, phys, ...) 
implementations at a higher level of operations (set_mode, 
set_next_event, ...) rather than separating at a register operations 
level as you have in this patch.

-- 
Thanks
- Cyril
