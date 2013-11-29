From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Fri, 29 Nov 2013 13:55:22 +0200
Subject: [PATCH 4/9] ARM: kprobes-test: Use <asm/opcodes.h> for ARM
 instruction building
In-Reply-To: <1383935832-20865-5-git-send-email-ben.dooks@codethink.co.uk>
References: <1383935832-20865-1-git-send-email-ben.dooks@codethink.co.uk>
 <1383935832-20865-5-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <CAArO44t7043wbVJkMDKzDU+xunB__0t8z4oE2s8AR7A8Mr9zoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 November 2013 20:37, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> The kprobes test will build certain instructions incorrectly if building
> big endian as .word output gets endian-swapped by the linker. Change to
> using <asm/opcodes.h> and __inst_arm() to produce instructions.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/kernel/kprobes-test-arm.c | 581 +++++++++++++++++++------------------
>  1 file changed, 291 insertions(+), 290 deletions(-)
>
> diff --git a/arch/arm/kernel/kprobes-test-arm.c b/arch/arm/kernel/kprobes-test-arm.c
> index 8393129..74ed733 100644
> --- a/arch/arm/kernel/kprobes-test-arm.c
> +++ b/arch/arm/kernel/kprobes-test-arm.c

[ snip ]

> @@ -434,21 +435,21 @@ void kprobe_arm_test_cases(void)
>         TEST_R( "swpvs  r0, r",1,VAL1,", [sp]")
>         TEST_RP("swp    sp, r",14,VAL2,", [r",12,13*4,"]")
>  #else
> -       TEST_UNSUPPORTED(".word 0xe108e097 @ swp        lr, r7, [r8]")
> -       TEST_UNSUPPORTED(".word 0x610d0091 @ swpvs      r0, r1, [sp]")
> -       TEST_UNSUPPORTED(".word 0xe10cd09e @ swp        sp, r14 [r12]")
> +       TEST_UNSUPPORTED(__inst_arm(0xe108e097) " @ swp lr, r7, [r8]")
> +       TEST_UNSUPPORTED(__inst_arm(0x610d0091) " @ swpvs       r0, r1, [sp]")
> +       TEST_UNSUPPORTED(__inst_arm(0xe10cd09e) " @ swp sp, r14 [r12]")
>  #endif
> -       TEST_UNSUPPORTED(".word 0xe102f091 @ swp pc, r1, [r2]")
> -       TEST_UNSUPPORTED(".word 0xe102009f @ swp r0, pc, [r2]")
> -       TEST_UNSUPPORTED(".word 0xe10f0091 @ swp r0, r1, [pc]")
> +       TEST_UNSUPPORTED(__inst_arm(0xe102f091) " @ swp pc, r1, [r2]")
> +       TEST_UNSUPPORTED(__inst_arm(0xe102009f) " @ swp r0, pc, [r2]")
> +       TEST_UNSUPPORTED(__inst_arm(0xe10f0091) " @ swp r0, r1, [pc]")
>  #if __LINUX_ARM_ARCH__ < 6
>         TEST_RP("swpb   lr, r",7,VAL2,", [r",8,0,"]")
>         TEST_R( "swpvsb r0, r",1,VAL1,", [sp]")
>  #else
> -       TEST_UNSUPPORTED(".word 0xe148e097 @ swpb       lr, r7, [r8]")
> -       TEST_UNSUPPORTED(".word 0x614d0091 @ swpvsb     r0, r1, [sp]")
> +       TEST_UNSUPPORTED(__inst_arm(0xe148e097) " @ swpb        lr, r7, [r8]")
> +       TEST_UNSUPPORTED(__inst_arm(0x614d0091) " @ swpvsb      r0, r1, [sp]")
>  #endif
> -       TEST_UNSUPPORTED(".word 0xe142f091 @ swpb pc, r1, [r2]")
> +       TEST_UNSUPPORTED(__inst_arm(0xe142f091) " @ swpb pc, r1, [r2]")
>
>         TEST_UNSUPPORTED(".word 0xe1100090") /* Unallocated space */
>         TEST_UNSUPPORTED(".word 0xe1200090") /* Unallocated space */

Two tests above and four below (not in the diff) are not converted.

> @@ -475,9 +476,9 @@ void kprobe_arm_test_cases(void)
>         TEST_RPR(  "strneh      r",12,VAL2,", [r",11,48,", -r",10,24,"]!")
>         TEST_RPR(  "strh        r",2, VAL1,", [r",3, 24,"], r",4, 48,"")
>         TEST_RPR(  "strh        r",10,VAL2,", [r",9, 48,"], -r",11,24,"")
> -       TEST_UNSUPPORTED(".word 0xe1afc0ba      @ strh r12, [pc, r10]!")
> -       TEST_UNSUPPORTED(".word 0xe089f0bb      @ strh pc, [r9], r11")
> -       TEST_UNSUPPORTED(".word 0xe089a0bf      @ strh r10, [r9], pc")
> +       TEST_UNSUPPORTED(__inst_arm(0xe1afc0ba) "       @ strh r12, [pc, r10]!")
> +       TEST_UNSUPPORTED(__inst_arm(0xe089f0bb) "       @ strh pc, [r9], r11")
> +       TEST_UNSUPPORTED(__inst_arm(0xe089a0bf) "       @ strh r10, [r9], pc")

-- 
Regards,
Taras Kondratiuk
