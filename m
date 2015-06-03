From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 3 Jun 2015 14:16:48 +0800
Subject: [PATCH v2 05/12] ARM: imx: setup tctl register in device
 specific function
In-Reply-To: <CAMAWPa-BYPnsqSxQ_VTa37a=Xg8xgrSQkzQgX+_65koZCNxBEg@mail.gmail.com>
References: <1432308599-28643-1-git-send-email-shawn.guo@linaro.org>
 <1432308599-28643-6-git-send-email-shawn.guo@linaro.org>
 <CAMAWPa-1MPgzT1GJQx4SjmfQpj9zdwsAw-qvLWZjVhoM66nHsQ@mail.gmail.com>
 <20150602011139.GP16165@dragon>
 <CAMAWPa-BYPnsqSxQ_VTa37a=Xg8xgrSQkzQgX+_65koZCNxBEg@mail.gmail.com>
Message-ID: <20150603061648.GA20344@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 02, 2015 at 08:56:02AM -0700, Kevin Hilman wrote:
> I'm just using multi_v7_defconfig, and BROKEN is not set, but that
> driver is still built because it's explicitly selected by ARCH_MXC:
> 
> $ git describe
> next-20150601
> $ rm build/.config
> $ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- O=build multi_v7_defconfig
> make[1]: Entering directory `/work/kernel/next/build'
>   GEN     ./Makefile
> arch/arm/configs/multi_v7_defconfig:603:warning: override: reassigning
> to symbol COMMON_CLK_QCOM
> warning: (ARCH_MXC) selects CLKSRC_IMX_GPT which has unmet direct
> dependencies (OF && BROKEN)
> warning: (ARCH_MXC) selects CLKSRC_IMX_GPT which has unmet direct
> dependencies (OF && BROKEN)
> #
> # configuration written to .config
> #
> make[1]: Leaving directory `/work/kernel/next/build'
> $ grep CLKSRC_IMX_GPT build/.config
> CONFIG_CLKSRC_IMX_GPT=y
> $

Yes, you're right.  It's broken on i.MX6DL/S indeed.  The cause is that
i.MX6DL/S DTBs are using the same GPT compatible string as i.MX6Q.  It
effectively makes kernel select an incorrect GPT device type on
i.MX6DL/S.  We will need to update i.MX6DL/S device tree to use
a correct compatible string.  But to keep the existing DTBs continue
working, we need the following change.  As I'm asked by Arnd to rebase
my branch, I would like fold the changes into the original patch to
save the git bisect issue.

Thanks for the bug report, and sorry for the breakage.

Shawn

-----8<------------------

diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
index a98d1104b3fd..e41b021b9d62 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -508,7 +508,18 @@ static void __init imx21_timer_init_dt(struct device_node *np)
 
 static void __init imx31_timer_init_dt(struct device_node *np)
 {
-       mxc_timer_init_dt(np, GPT_TYPE_IMX31);
+       enum imx_gpt_type type = GPT_TYPE_IMX31;
+
+       /*
+        * We were using the same compatible string for i.MX6Q/D and i.MX6DL/S
+        * GPT device, while they actually have different programming model.
+        * This is a workaround to keep the existing i.MX6DL/S DTBs continue
+        * working with the new kernel.
+        */
+       if (of_machine_is_compatible("fsl,imx6dl"))
+               type = GPT_TYPE_IMX6DL;
+
+       mxc_timer_init_dt(np, type);
 }
 
 static void __init imx6dl_timer_init_dt(struct device_node *np)
