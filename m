From: achandran@mvista.com (Arun Chandran)
Date: Thu, 21 Aug 2014 19:04:46 +0530
Subject: [PATCH] Arm64: convert soft_restart() to assembly code
In-Reply-To: <20140820141623.GF21734@leverpostej>
References: <1407847365-10873-1-git-send-email-achandran@mvista.com>
 <1408123221.22761.38.camel@smoke>
 <20140815182157.GD21908@leverpostej>
 <CAFdej01kDMSTpzdGiRmX8g=E4mZU2_5oiiKzyQ_z7z1jxeCF-A@mail.gmail.com>
 <20140820105408.GG21174@leverpostej>
 <CAFdej00s9ZYXnE4AfU0vUqTb4dmUg4U=fOhc3KS1_JK+0=+mdw@mail.gmail.com>
 <20140820141623.GF21734@leverpostej>
Message-ID: <CAFdej023ABj=xstTS_vddr2PMoqE4Fe1qBN9Gr0P69hW+u=YBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, Aug 20, 2014 at 7:46 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> [...]
>
>> I am trying to kexec a UP-LE kernel from and SMP-LE kernel.
>>
>> > As I mentioned we do need to ensure that the CPUs are in the mode they
>> > started in, though I'm not sure I follow what you mean by "not waiting".
>> > This could be an orthogonal issue.
>>
>> If I verify the secondary CPUs from u-boot I can see that
>> they are all looping at
>>
>>     Core number       : 1
>>     Core state        : debug (AArch64 EL2)
>>     Debug entry cause : External Debug Request
>>     Current PC        : 0x0000000000000238
>>     Current CPSR      : 0x200003c9 (EL2h)
>>
>> But after the kexec calls soft_restar(0) for all secondary CPUs
>> they are looping at
>>
>>     Core number       : 1
>>     Core state        : debug (AArch64 EL1)
>>     Debug entry cause : External Debug Request
>>     Current PC        : 0xffffffc000083200
>>     Current CPSR      : 0x600003c5 (EL1h)
>>
>> This is what I mean by they are not waiting for
>> the secondary start-up address to jump.
>
> Ok.
>
>> >
>> > What exactly do you see, do the CPUs leave the spin-table, are they
>> > taking exceptions, are they getting stuck in the spin-table, etc?
>> >
>> They all are clearly resetting to address "0"(Put a breakpoint and
>> verified) but somehow they end up @0xffffffc000083200.
>> I still don't know why.
>>
>> ########
>> ffffffc00008319c:       d503201f        nop
>>         ...
>> ffffffc000083200:       14000260        b       ffffffc000083b80 <el1_sync>
>> ffffffc000083204:       d503201f        nop
>> ffffffc000083208:       d503201f        nop
>> ########
>
> That's the EL1 exception vector table.
>
> What looks to be happening is that something causes the CPUs to take an
> exception (at EL1). Because translation isn't enabled and the vector
> address doesn't map to anything, they'll take some sort of exception.
> Because the vectors aren't mapped that will go recursive.
>
> Your spin-table implementation might be poking something that's not
> accessible at EL1, in which case you require the jump to EL2 for
> correctness. I can't say for certain either way.
>

Yes you are right I needed a jump to EL2 for putting the
secondary CPUs at correct spinning loop.

I made some progress with the below changes.

###########
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 607d4bb..8969922 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -343,6 +343,11 @@ CPU_LE(    movk    x0, #0x30d0, lsl #16    )
 // Clear EE and E0E on LE systems
                      PSR_MODE_EL1h)
        msr     spsr_el2, x0
        msr     elr_el2, lr
+       mov     x0, #0x33ff
+       movk    x0, #0x801f, lsl #16
+       msr     cptr_el2, x0                    // Enable traps to el2
when CPACR or CPACR_EL1 is accessed
+       mov     x0, #3 << 20
+       msr     cpacr_el1, x0                   // Enable FP/ASIMD
        mov     w20, #BOOT_CPU_MODE_EL2         // This CPU booted in EL2
        eret
 ENDPROC(el2_setup)
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index a272f33..d8e806c 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -66,6 +66,14 @@ ENDPROC(el1_sync)

 .macro invalid_vector  label
 \label:
+       mov     x1, #0x33ff
+       msr     cptr_el2, x1                    // Disable copro. traps to EL2
+
+       ic      ialluis
+       isb
+       dsb     sy
+
+       br  x0
        b \label
 ENDPROC(\label)
 .endm
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 64733d4..8ca929c 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -65,6 +65,12 @@ void soft_restart(unsigned long addr)
 //     smp_secondary_shutdown();
 #endif

+       /* Delay primary cpu; allow enough time for
+        * secondaries to enter spin loop
+        */
+       if (smp_processor_id() == 0)
+               mdelay(1000);
+
        cpu_soft_restart(virt_to_phys(cpu_reset), addr);

        /* Should never get here */
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 3cb6dec..f6ab468 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -76,6 +76,10 @@ ENTRY(cpu_reset)
 #if defined(CONFIG_SMP)
 /*     bl      secondary_shutdown */
 #endif
+
+       /* Trap to EL2 */
+       mov     x1, #3 << 20
+       msr     cpacr_el1, x1                   // Enable FP/ASIMD
        ret     x0
 ENDPROC(cpu_reset)

@@ -200,8 +204,6 @@ ENTRY(__cpu_setup)
        tlbi    vmalle1is                       // invalidate I + D TLBs
        dsb     ish

-       mov     x0, #3 << 20
-       msr     cpacr_el1, x0                   // Enable FP/ASIMD
        msr     mdscr_el1, xzr                  // Reset mdscr_el1
        /*
         * Memory region attributes for LPAE:
#########

With the above code I was able to manually kexec
an SMP kernel (With the help of debugger).

Basically the branch instruction (br x0) is not working
in the el2 vector.
------------------
CPU#0>h
    Core number       : 0
    Core state        : debug (AArch64 EL2)
    Debug entry cause : External Debug Request
    Current PC        : 0x0000004000089800
    Current CPSR      : 0x600003c9 (EL2h)
CPU#0>rd
GPR00: 00000043eb891000 0000000000000018 0000000000000006 0000000000000004
GPR04: 000000000000001f 000000000000001b 0000000000000000 ffffffffffffffff
GPR08: ffffffc3ffe80614 ffffffffffffffff 0000000000000000 0000000000000002
GPR12: ffffffc0000968f0 00000040008c0000 00000043eb949002 ffffffffffffffff
GPR16: ffffffc0000c1244 0000000000435260 0000007ff9c5d490 00000040000968c0
GPR20: 00000043eb891000 ffffffc3eb891000 ffffffc3eb973c00 0000000000000110
GPR24: ffffffc000094000 ffffffc000094cd8 000000000000008e ffffffc00082f000
GPR28: ffffffc3e9888000 ffffffc3e988bd00 ffffffc000095d88 00000043efb24430
CPU#0>go 0x00000043eb891000
--------------------

I had to use the debugger  to make cpu0 jump to kexec-boot code.
Similarly I had to manually put other CPUs to spinning code
using debugger. Could you please throw some light here?

--Arun











> Thanks,
> Mark.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
