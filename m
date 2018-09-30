From: joe@perches.com (Joe Perches)
Date: Sun, 30 Sep 2018 16:48:20 -0700
Subject: [PATCH] ARM: disable ARMv6 for Clang older than 8.0
In-Reply-To: <20180930222230.24167-1-stefan@agner.ch>
References: <20180930222230.24167-1-stefan@agner.ch>
Message-ID: <aa1fbf64fc1190674abb9ecae3ffe1a39e1e60c0.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-10-01 at 00:22 +0200, Stefan Agner wrote:
> The kernel passes the ArmV6K architecture to the compiler when
> using the multi platform selection and enabling ARMv6. Clang
> older than version 8.0 emit assembly with an non-existing CPU,
> which then makes the assembler fail. Prevent the user from
> selecting ARMv6 when using Clang before 8.0.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Link: https://github.com/ClangBuiltLinux/linux/issues/55
> ---
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e8cd55a5b04c..8da160757381 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -671,6 +671,7 @@ config ARCH_MULTI_V4_V5
>  
>  config ARCH_MULTI_V6
>  	bool "ARMv6 based platforms (ARM11)"
> +	depends on !CC_IS_CLANG || CLANG_VERSION>=80000
>  	select ARCH_MULTI_V6_V7
>  	select CPU_V6K
>  

Perhaps it'd be better to avoid this in selection
criteria in Kconfig and instead add this to
include/linux/compiler_clang.h
---
 include/linux/compiler-clang.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index b1ce500fe8b3..90fd16c85359 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -3,6 +3,10 @@
 #error "Please don't include <linux/compiler-clang.h> directly, include <linux/compiler.h> instead."
 #endif
 
+#if defined(CONFIG_ARCH_MULTI_V6) && CLANG_VERSION < 80000
+# error Sorry, your compiler is too old - please upgrade it.
+#endif
+
 /* Some compiler specific definitions are overwritten here
  * for Clang compiler
  */
