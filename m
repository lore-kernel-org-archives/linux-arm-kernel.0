From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 10 Jan 2013 12:05:32 +0000
Subject: [PATCH 15/16] ARM: vexpress/dcscb: handle platform coherency
 exit/setup and CCI
In-Reply-To: <1357777251-13541-16-git-send-email-nicolas.pitre@linaro.org>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-16-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20130110120532.GC29952@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 09, 2013 at 07:20:50PM -0500, Nicolas Pitre wrote:
> From: Dave Martin <dave.martin@linaro.org>
> 
> Add the required code to properly handle race free platform coherency exit
> to the DCSCB power down method.
> 
> The power_up_setup callback is used to enable the CCI interface for
> the cluster being brought up.  This must be done in assembly before
> the kernel environment is entered.
> 
> Thanks to Achin Gupta and Nicolas Pitre for their help and
> contributions.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>  arch/arm/mach-vexpress/Kconfig       |  1 +
>  arch/arm/mach-vexpress/Makefile      |  2 +-
>  arch/arm/mach-vexpress/dcscb.c       | 90 +++++++++++++++++++++++++++---------
>  arch/arm/mach-vexpress/dcscb_setup.S | 77 ++++++++++++++++++++++++++++++
>  4 files changed, 146 insertions(+), 24 deletions(-)
>  create mode 100644 arch/arm/mach-vexpress/dcscb_setup.S

[...]

> diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c

[...]

> @@ -179,6 +219,8 @@ static void __init dcscb_usage_count_init(void)
>  	dcscb_use_count[cpu][cluster] = 1;
>  }
>  
> +extern void dcscb_power_up_setup(void);

The following change can be folded in to match the prototype to the
underlying function.

Cheers
---Dave

diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
index 95a2d0d..4057f8b 100644
--- a/arch/arm/mach-vexpress/dcscb.c
+++ b/arch/arm/mach-vexpress/dcscb.c
@@ -219,7 +219,7 @@ static void __init dcscb_usage_count_init(void)
 	dcscb_use_count[cpu][cluster] = 1;
 }
 
-extern void dcscb_power_up_setup(void);
+extern void dcscb_power_up_setup(unsigned int affinity_level);
 
 static int __init dcscb_init(void)
 {
