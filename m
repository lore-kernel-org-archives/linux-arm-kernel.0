From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 24 Nov 2016 17:32:42 +0000
Subject: [PATCH 4/4] crypto: arm/crct10dif - port x86 SSE implementation
 to ARM
In-Reply-To: <1480002201-1427-5-git-send-email-ard.biesheuvel@linaro.org>
References: <1480002201-1427-1-git-send-email-ard.biesheuvel@linaro.org>
 <1480002201-1427-5-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu8tPfX76ntdQmMz53waE73RHfB11oRs8w=Ufy7d=YqbGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 November 2016 at 15:43, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> This is a straight transliteration of the Intel algorithm implemented
> using SSE and PCLMULQDQ instructions that resides under in the file
> arch/x86/crypto/crct10dif-pcl-asm_64.S.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm/crypto/Kconfig                        |   5 +
>  arch/arm/crypto/Makefile                       |   2 +
>  arch/{arm64 => arm}/crypto/crct10dif-ce-core.S | 457 +++++++++++---------
>  arch/{arm64 => arm}/crypto/crct10dif-ce-glue.c |  23 +-
>  4 files changed, 277 insertions(+), 210 deletions(-)
>

This patch needs the following hunk folded in to avoid breaking the
Thumb2 build:

"""
diff --git a/arch/arm/crypto/crct10dif-ce-core.S
b/arch/arm/crypto/crct10dif-ce-core.S
index 30168b0f8581..4fdbca94dd0c 100644
--- a/arch/arm/crypto/crct10dif-ce-core.S
+++ b/arch/arm/crypto/crct10dif-ce-core.S
@@ -152,7 +152,8 @@ CPU_LE(     vrev64.8        q7, q7                  )
        // XOR the initial_crc value
        veor.8          q0, q0, q10

-       adrl            ip, rk3
+ARM(   adrl            ip, rk3         )
+THUMB( adr             ip, rk3         )
        vld1.64         {q10}, [ip]     // xmm10 has rk3 and rk4
                                        // type of pmull instruction
                                        // will determine which constant to use
"""

Updated patch(es) can be found here
https://git.kernel.org/cgit/linux/kernel/git/ardb/linux.git/log/?h=arm-crct10dif
