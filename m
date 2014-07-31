From: will.deacon@arm.com (Will Deacon)
Date: Thu, 31 Jul 2014 10:57:36 +0100
Subject: [PATCH] arm64: defconfig: enable crypto drivers as modules
In-Reply-To: <1406797002-21015-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1406797002-21015-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140731095736.GH26853@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Thu, Jul 31, 2014 at 09:56:42AM +0100, Ard Biesheuvel wrote:
> This changes the arm64 defconfig to build the ARMv8 Crypto Extensions
> and NEON based crypto drivers as modules rather than as built-ins. The
> reason is that the ARMv8 Crypto Extensions based modules will be probed
> for automatically through udev upon detecting the availability of the
> respective crypto instructions (AES, PMULL, SHA1, SHA256), and similarly,
> the NEON alternatives will be probed for upon request (i.e., at first use
> of the algorithm) if no hardware acceleration is available.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index c1071268c912..3310b4166dd0 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -127,10 +127,10 @@ CONFIG_LOCKUP_DETECTOR=y
>  CONFIG_SECURITY=y
>  CONFIG_CRYPTO_ANSI_CPRNG=y
>  CONFIG_ARM64_CRYPTO=y
> -CONFIG_CRYPTO_SHA1_ARM64_CE=y
> -CONFIG_CRYPTO_SHA2_ARM64_CE=y
> -CONFIG_CRYPTO_GHASH_ARM64_CE=y
> -CONFIG_CRYPTO_AES_ARM64_CE=y
> -CONFIG_CRYPTO_AES_ARM64_CE_CCM=y
> -CONFIG_CRYPTO_AES_ARM64_CE_BLK=y
> -CONFIG_CRYPTO_AES_ARM64_NEON_BLK=y
> +CONFIG_CRYPTO_SHA1_ARM64_CE=m
> +CONFIG_CRYPTO_SHA2_ARM64_CE=m
> +CONFIG_CRYPTO_GHASH_ARM64_CE=m
> +CONFIG_CRYPTO_AES_ARM64_CE=m
> +CONFIG_CRYPTO_AES_ARM64_CE_CCM=m
> +CONFIG_CRYPTO_AES_ARM64_CE_BLK=m
> +CONFIG_CRYPTO_AES_ARM64_NEON_BLK=m

Whilst I'm usually fairly open to defconfig updates if they make things more
useful to people, I think building these as modules is going to be a pain
for those not using udev (i.e. using busybox and/or simple filesystems for a
VM). This seems more like something a distro might choose to do as opposed
to something that is a good idea to have enabled by default.

There could be an argument for a distroconfig, but I don't have high hopes
that anybody would actually use it in practice.

Will
