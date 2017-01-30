From: james.morse@arm.com (James Morse)
Date: Mon, 30 Jan 2017 11:48:01 +0000
Subject: next-20170125 hangs on aarch64
In-Reply-To: <20170129122125.GA20269@yury-N73SV>
References: <20170129101255.GA29415@yury-N73SV>
 <20170129122125.GA20269@yury-N73SV>
Message-ID: <588F27F1.6050907@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yury,

[CC: Andy Gross]

On 29/01/17 12:21, Yury Norov wrote:
> On Sun, Jan 29, 2017 at 03:42:55PM +0530, Yury Norov wrote:
>> Hi all,
>>
>> I pulled next-20170125 kernel, and found it hanged on boot. The exact reason is
>> panic on dereferencing of the 0xffffffc8 address, which is most probably the
>> attempt to dereference the ENOSYS error code as the address. next-20170124 works
>> fine, at least it boots.
>>
>> Does anyone have details on that?

I hit this with next-20170130 too, in /arch/arm64/kernel/smccc-call.S
aabde95fc543 changed the SMCCC macro to check for an optional quirk structure.

A previous patch provided:
> #define arm_smccc_smc(...) __arm_smccc_smc(__VA_ARGS__, NULL)

to handle the 'no quirk' case, but this missed HVC calls.
The following hunk fixes/hides it for me:

----------------------------%<----------------------------
diff --git a/arch/arm64/kernel/smccc-call.S b/arch/arm64/kernel/smccc-call.S
index 72ecdca929b1..9e287a7d1822 100644
--- a/arch/arm64/kernel/smccc-call.S
+++ b/arch/arm64/kernel/smccc-call.S
@@ -15,18 +15,20 @@
 #include <linux/arm-smccc.h>
 #include <asm/asm-offsets.h>

-       .macro SMCCC instr
+       .macro SMCCC instr, maybe_quirk = 0
        .cfi_startproc
        \instr  #0
        ldr     x4, [sp]
        stp     x0, x1, [x4, #ARM_SMCCC_RES_X0_OFFS]
        stp     x2, x3, [x4, #ARM_SMCCC_RES_X2_OFFS]
        ldr     x4, [sp, #8]
+       .if \maybe_quirk != 0
        cbz     x4, 1f /* no quirk structure */
        ldr     x9, [x4, #ARM_SMCCC_QUIRK_ID_OFFS]
        cmp     x9, #ARM_SMCCC_QUIRK_QCOM_A6
        b.ne    1f
        str     x6, [x4, ARM_SMCCC_QUIRK_STATE_OFFS]
+       .endif
 1:     ret
        .cfi_endproc
        .endm
@@ -38,7 +40,7 @@
  *               struct arm_smccc_quirk *quirk)
  */
 ENTRY(__arm_smccc_smc)
-       SMCCC   smc
+       SMCCC   smc, 1
 ENDPROC(__arm_smccc_smc)

 /*
----------------------------%<----------------------------


Thanks,

James
