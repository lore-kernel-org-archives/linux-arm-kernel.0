From: will.deacon@arm.com (Will Deacon)
Date: Sat, 12 Nov 2016 22:15:20 +0000
Subject: [PATCH v3] crypto: arm64/sha2: integrate OpenSSL implementations
 of SHA256/SHA512
In-Reply-To: <1478953953-11523-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1478953953-11523-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20161112221520.GD24127@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Sat, Nov 12, 2016 at 01:32:33PM +0100, Ard Biesheuvel wrote:
> This integrates both the accelerated scalar and the NEON implementations
> of SHA-224/256 as well as SHA-384/512 from the OpenSSL project.
> 
> Relative performance compared to the respective generic C versions:
> 
>                  |  SHA256-scalar  | SHA256-NEON* |  SHA512  |
>      ------------+-----------------+--------------+----------+
>      Cortex-A53  |      1.63x      |     1.63x    |   2.34x  |
>      Cortex-A57  |      1.43x      |     1.59x    |   1.95x  |
>      Cortex-A73  |      1.26x      |     1.56x    |     ?    |
> 
> The core crypto code was authored by Andy Polyakov of the OpenSSL
> project, in collaboration with whom the upstream code was adapted so
> that this module can be built from the same version of sha512-armv8.pl.
> 
> The version in this patch was taken from OpenSSL commit
> 
>    866e505e0d66 sha/asm/sha512-armv8.pl: add NEON version of SHA256.
> 
> * The core SHA algorithm is fundamentally sequential, but there is a
>   secondary transformation involved, called the schedule update, which
>   can be performed independently. The NEON version of SHA-224/SHA-256
>   only implements this part of the algorithm using NEON instructions,
>   the sequential part is always done using scalar instructions.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> v3: at Will's request, the generated assembly files are now included
>     as .S_shipped files, for which generic build rules are defined
>     already. Note that this has caused issues in the past with
>     patchwork, so for Herbert's convenience, the patch can be pulled
>     from http://git.kernel.org/cgit/linux/kernel/git/ardb/linux.git,
>     branch arm64-sha256 (based on today's cryptodev)

Thanks.

Looking at the generated code, I see references to __ARMEB__ and __ILP32__.
The former is probably a bug, whilst the second is not required. There are
also some commented out instructions, which is weird.

Will
