From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 7 Oct 2013 17:25:48 +0100
Subject: [GIT PULL] ARM: NEON accelerated AES
In-Reply-To: <1381151998-7936-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1381151998-7936-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20131007162548.GB12030@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 03:19:58PM +0200, Ard Biesheuvel wrote:
> !! NOTE !!: this series build-depends on patch a62b01cd (crypto: create generic
> version of ablk_helper) which is in linux-next but not yet in mainline.
> 
> The following changes since commit 15c03dd4859ab16f9212238f29dd315654aa94f6:
> 
>   Linux 3.12-rc3 (2013-09-29 15:02:38 -0700)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/ardbiesheuvel/linux-arm.git arm-aesbs
> 
> for you to fetch changes up to e4e7f10bfc4069925e99cc4b428c3434e30b6c3f:
> 
>   ARM: add support for bit sliced AES using NEON instructions (2013-10-04 20:48:38 +0200)

Since nobody has stepped up to review this in detail, it appears there
may be nobody on the relvant lists who is sufficiently expert in AES and
NEON/v8 to review it.

To trust the openssl community on this doubtless makes sense (I notice
that, by an astonishing coincidence, the relevant changes to that project
have been made a certain Ard Biesheuvel).

How do you propose this code should be maintained in the kernel?

Adding a script which automatically diffs the files in the kernel
against openssl might be a good idea -- not every time the kernel is
built, but as a maintainer activity someone can script up.  This has the
advantage that ordinary kernel developers will be able to comprehend,
review, and use it, unlike the AES code itself.

Otherwise, important upstream fixes may not reach the kernel, or the
two codebases might diverge, especially if a significant code refactoring
occurs in openssl.  (I don't know whether that's likely or not)

Cheers
---Dave


> 
> ----------------------------------------------------------------
> Ard Biesheuvel (3):
>       ARM: pull in <asm/simd.h> from asm-generic
>       ARM: move AES typedefs and function prototypes to separate header
>       ARM: add support for bit sliced AES using NEON instructions
> 
>  arch/arm/crypto/Makefile             |   14 +-
>  arch/arm/crypto/aes_glue.c           |   22 +-
>  arch/arm/crypto/aes_glue.h           |   19 +
>  arch/arm/crypto/aesbs-core.S_shipped | 2544 ++++++++++++++++++++++++++++++++++
>  arch/arm/crypto/aesbs-glue.c         |  434 ++++++
>  arch/arm/crypto/bsaes-armv7.pl       | 2467 +++++++++++++++++++++++++++++++++
>  arch/arm/include/asm/Kbuild          |    1 +
>  crypto/Kconfig                       |   16 +
>  8 files changed, 5499 insertions(+), 18 deletions(-)
>  create mode 100644 arch/arm/crypto/aes_glue.h
>  create mode 100644 arch/arm/crypto/aesbs-core.S_shipped
>  create mode 100644 arch/arm/crypto/aesbs-glue.c
>  create mode 100644 arch/arm/crypto/bsaes-armv7.pl
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
