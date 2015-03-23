From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 23 Mar 2015 19:26:03 +0100
Subject: [PATCHv2] arm: crypto: Add optimized SHA-256/224
In-Reply-To: <20150323135009.GB820@google.com>
References: <20150316154835.GA31336@google.com>
 <20150323135009.GB820@google.com>
Message-ID: <CAKv+Gu8qcVVTqy6Fd8PMA8ZTxiMssKz+TbMQW=fAhCBpUH2jTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(resending due to size bounce)

On 23 March 2015 at 14:50, Sami Tolvanen <samitolvanen@google.com> wrote:
> Add Andy Polyakov's optimized assembly and NEON implementations for
> SHA-256/224.
>
> The sha256-armv4.pl script for generating the assembly code is from
> OpenSSL commit 2ecd32a1f8f0643ae7b38f59bbaf9f0d6ef326fe.
>
> Compared to sha256-generic these implementations have the following
> tcrypt speed improvements on Motorola Nexus 6 (Snapdragon 805):
>
>   bs    b/u      sha256-neon  sha256-asm
>   16    16       x1.32        x1.19
>   64    16       x1.27        x1.15
>   64    64       x1.36        x1.20
>   256   16       x1.22        x1.11
>   256   64       x1.36        x1.19
>   256   256      x1.59        x1.23
>   1024  16       x1.21        x1.10
>   1024  256      x1.65        x1.23
>   1024  1024     x1.76        x1.25
>   2048  16       x1.21        x1.10
>   2048  256      x1.66        x1.23
>   2048  1024     x1.78        x1.25
>   2048  2048     x1.79        x1.25
>   4096  16       x1.20        x1.09
>   4096  256      x1.66        x1.23
>   4096  1024     x1.79        x1.26
>   4096  4096     x1.82        x1.26
>   8192  16       x1.20        x1.09
>   8192  256      x1.67        x1.23
>   8192  1024     x1.80        x1.26
>   8192  4096     x1.85        x1.28
>   8192  8192     x1.85        x1.27
>
> Where bs refers to block size and b/u to bytes per update.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Cc: Andy Polyakov <appro@openssl.org>
>

This builds fine and passes the tcrypt.ko tests in ARM and Thumb2 and
even in big-endian (ARM) mode, so

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Nice work!

Ard.

> ---
> Changes since v1:
>   Rebased to Herbert's cryptodev tree
>   Include sha256-armv4.pl and use it to generate sha256-core.S
>   Add integer-only assembly version as sha256-asm
>   Add support for SHA-224 to the glue code
>   Change priority for sha256/224-ce to 300
>
> ---
>  arch/arm/crypto/Kconfig               |    7
>  arch/arm/crypto/Makefile              |    8
>  arch/arm/crypto/sha2-ce-glue.c        |    4
>  arch/arm/crypto/sha256-armv4.pl       |  713 ++++++
>  arch/arm/crypto/sha256-core.S_shipped | 2775 ++++++++++++++++++++++++
>  arch/arm/crypto/sha256_glue.c         |  246 ++
>  arch/arm/crypto/sha256_glue.h         |   23
>  arch/arm/crypto/sha256_neon_glue.c    |  172 +
>  8 files changed, 3945 insertions(+), 3 deletions(-)
>
