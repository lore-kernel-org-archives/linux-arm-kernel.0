From: will.deacon@arm.com (Will Deacon)
Date: Tue, 4 Feb 2014 09:38:44 +0000
Subject: [PATCH] security: select correct default LSM_MMAP_MIN_ADDR on
 arm on arm64
In-Reply-To: <1391480133-27149-1-git-send-email-ccross@android.com>
References: <1391480133-27149-1-git-send-email-ccross@android.com>
Message-ID: <20140204093843.GB16708@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 02:15:32AM +0000, Colin Cross wrote:
> Binaries compiled for arm may run on arm64 if CONFIG_COMPAT is
> selected.  Set LSM_MMAP_MIN_ADDR to 32768 if ARM64 && COMPAT to
> prevent selinux failures launching 32-bit static executables that
> are mapped at 0x8000.
> 
> Signed-off-by: Colin Cross <ccross@android.com>
> ---
>  security/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/Kconfig b/security/Kconfig
> index e9c6ac724fef..beb86b500adf 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -103,7 +103,7 @@ config INTEL_TXT
>  config LSM_MMAP_MIN_ADDR
>  	int "Low address space for LSM to protect from user allocation"
>  	depends on SECURITY && SECURITY_SELINUX
> -	default 32768 if ARM
> +	default 32768 if ARM || (ARM64 && COMPAT)
>  	default 65536
>  	help
>  	  This is the portion of low virtual memory which should be protected

Since ARM64 && COMPAT implies 4k pages, this change looks ok to me.

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
