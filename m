From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Fri, 10 Jan 2014 17:49:44 +0200
Subject: [PATCH 3/5] ARM: kprobes-test: use <asm/opcodes.h> for ARM
 instruction building
In-Reply-To: <1387815579-15677-4-git-send-email-taras.kondratiuk@linaro.org>
References: <1387815579-15677-1-git-send-email-taras.kondratiuk@linaro.org>
 <1387815579-15677-4-git-send-email-taras.kondratiuk@linaro.org>
Message-ID: <CAArO44uuHoTjb9TJAXJLmp88GeY+kEGp+nom8LMt8-KoF0isYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 December 2013 18:19, Taras Kondratiuk <taras.kondratiuk@linaro.org> wrote:
> From: Ben Dooks <ben.dooks@codethink.co.uk>
>
> The kprobes test will build certain instructions incorrectly if building
> big endian as .word output gets endian-swapped by the linker. Change to
> using <asm/opcodes.h> and __inst_arm() to produce instructions.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> [taras.kondratiuk at linaro.org: fixed a few missed instructions]
> Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
> ---
>  arch/arm/kernel/kprobes-test-arm.c |  595 ++++++++++++++++++------------------
>  1 file changed, 298 insertions(+), 297 deletions(-)
>
> diff --git a/arch/arm/kernel/kprobes-test-arm.c b/arch/arm/kernel/kprobes-test-arm.c
> index 8393129..56be041 100644
> --- a/arch/arm/kernel/kprobes-test-arm.c
> +++ b/arch/arm/kernel/kprobes-test-arm.c

[snip]

> @@ -1180,43 +1181,43 @@ void kprobe_arm_test_cases(void)
>                                                                                 \
>         TEST_COPROCESSOR( "stc"two"     0, cr0, [r15, #4]")                     \
>         TEST_COPROCESSOR( "stc"two"     0, cr0, [r15, #-4]")                    \
> -       TEST_UNSUPPORTED(".word 0x"cc"daf0001   @ stc"two"      0, cr0, [r15, #4]!")    \
> -       TEST_UNSUPPORTED(".word 0x"cc"d2f0001   @ stc"two"      0, cr0, [r15, #-4]!")   \
> -       TEST_UNSUPPORTED(".word 0x"cc"caf0001   @ stc"two"      0, cr0, [r15], #4")     \
> -       TEST_UNSUPPORTED(".word 0x"cc"c2f0001   @ stc"two"      0, cr0, [r15], #-4")    \
> +       TEST_UNSUPPORTED(__inst_arm(0x##ccdaf0001) "    @ stc"two"      0, cr0, [r15, #4]!")    \
> +       TEST_UNSUPPORTED(__inst_arm(0x##ccd2f0001) "    @ stc"two"      0, cr0, [r15, #-4]!")   \
> +       TEST_UNSUPPORTED(__inst_arm(0x##cccaf0001) "    @ stc"two"      0, cr0, [r15], #4")     \
> +       TEST_UNSUPPORTED(__inst_arm(0x##ccc2f0001) "    @ stc"two"      0, cr0, [r15], #-4")    \

Oops. Should be something like __inst_arm(0x##cc##c2f0001).
My compiler truncated it to 32 bits, so these tests passed anyway.
I'll repost a fixed series.

-- 
Regards,
Taras Kondratiuk
