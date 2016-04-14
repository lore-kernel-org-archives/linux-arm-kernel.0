From: bamvor.zhangjian@huawei.com (Zhangjian (Bamvor))
Date: Thu, 14 Apr 2016 11:20:29 +0800
Subject: [PATCH 10/25] arm64: rename COMPAT to AARCH32_EL0 in Kconfig
In-Reply-To: <1459894127-17698-11-git-send-email-ynorov@caviumnetworks.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1459894127-17698-11-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <570F0C7D.8000004@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, yury

I suggest we enable AARCH32_EL0 by default explicitly. I am not sure
if it should be a dedicated commit. I am ok if you merge my commit, add

Reviewed-by: Bamvor Jian Zhang <bamvor.zhangjian@huawei.com>

commit 926ad48847c9fbc665285c49ff823666e145a083
Author: Bamvor Jian Zhang <bamvor.zhangjian@huawei.com>
Date:   Wed Apr 6 17:59:03 2016 +0800

     arm64: enable aarch32 application by default

     After introduce the AARCH32_EL0. The aarch32 application is disabled
     by default which was enabled by default. And the aarch32 application
     could not run on these kernels consequently.

     This commit enable it in Kconfig explicitly.

     Signed-off-by: Bamvor Jian Zhang <bamvor.zhangjian@huawei.com>

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 19d8e31..3b543c7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -934,6 +934,7 @@ config AARCH32_EL0
         select HAVE_UID16
         select OLD_SIGSUSPEND3
         select COMPAT_OLD_SIGACTION
+       default y
         help
           This option enables support for a 32-bit EL0 running under a 64-bit
           kernel at EL1. AArch32-specific components such as system calls,


On 2016/4/6 6:08, Yury Norov wrote:
> From: Andrew Pinski <apinski@cavium.com>
>
> In this patchset  ILP32 ABI support is added. Additionally to AARCH32,
> which is binary-compatible with ARM, ILP32 is (mostly) ABI-compatible.
>
>  From now, AARCH32_EL0 (former COMPAT) config option means the support of
> AARCH32 userspace, ARM64_ILP32 - support of ILP32 ABI (see next patches),
> and COMPAT indicates that one of them, or both, is enabled.
>
> Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> Reviewed-by: David Daney <ddaney@caviumnetworks.com>
> ---
>   arch/arm64/Kconfig | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 4f43622..f923687 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -925,6 +925,10 @@ menu "Userspace binary formats"
>   source "fs/Kconfig.binfmt"
>
>   config COMPAT
> +	def_bool y
> +	depends on AARCH32_EL0
> +
> +config AARCH32_EL0
>   	bool "Kernel support for 32-bit EL0"
>   	depends on ARM64_4K_PAGES || EXPERT
>   	select COMPAT_BINFMT_ELF
>
