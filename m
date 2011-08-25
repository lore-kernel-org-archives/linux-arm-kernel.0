From: myungjoo.ham@gmail.com (MyungJoo Ham)
Date: Thu, 25 Aug 2011 16:46:46 +0900
Subject: [PATCH 3/5] ARM: EXYNOS4: Add support PM for EXYNOS4212
In-Reply-To: <1314192352-14911-4-git-send-email-kgene.kim@samsung.com>
References: <1314192352-14911-1-git-send-email-kgene.kim@samsung.com>
	<1314192352-14911-4-git-send-email-kgene.kim@samsung.com>
Message-ID: <CAJ0PZbT1YsiXT9k1FJfOCoU8h_XAYqAX6ECJ_=Q0RjR-D_9yyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 10:25 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> From: Jonghwan Choi <jhbird.choi@samsung.com>
>
> This patch moves regarding clock stuff of PM into clock
> file to support PM on EXYNOS4210 and EXYNOS4212 with one
> single kernel image. Because some clock registers are
> different on each SoCs.
>
> Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> ?arch/arm/mach-exynos4/clock-exynos4210.c ? ? ? ?| ? 38 ++++++++++
> ?arch/arm/mach-exynos4/clock-exynos4212.c ? ? ? ?| ? 34 +++++++++
> ?arch/arm/mach-exynos4/clock.c ? ? ? ? ? ? ? ? ? | ? 89 +++++++++++++++++++++++
> ?arch/arm/mach-exynos4/include/mach/regs-clock.h | ? ?4 +
> ?arch/arm/mach-exynos4/pm.c ? ? ? ? ? ? ? ? ? ? ?| ? 79 ++------------------
> ?5 files changed, 172 insertions(+), 72 deletions(-)
>
> diff --git a/arch/arm/mach-exynos4/clock-exynos4210.c b/arch/arm/mach-exynos4/clock-exynos4210.c
> index fe74b91..a4b00b7 100644
> --- a/arch/arm/mach-exynos4/clock-exynos4210.c
> +++ b/arch/arm/mach-exynos4/clock-exynos4210.c
> +static struct sleep_save exynos4210_clock_save[] = {
> + ? ? ? SAVE_ITEM(S5P_CLKSRC_IMAGE),
> + ? ? ? SAVE_ITEM(S5P_CLKSRC_LCD1),
> + ? ? ? SAVE_ITEM(S5P_CLKDIV_IMAGE),
> + ? ? ? SAVE_ITEM(S5P_CLKDIV_LCD1),
> + ? ? ? SAVE_ITEM(S5P_CLKSRC_MASK_LCD1),
> + ? ? ? SAVE_ITEM(S5P_CLKGATE_IP_IMAGE_4210),
> + ? ? ? SAVE_ITEM(S5P_CLKGATE_IP_LCD1),
> + ? ? ? SAVE_ITEM(S5P_CLKGATE_IP_PERIR_4210),
> +};
> +
> --- a/arch/arm/mach-exynos4/clock-exynos4212.c
> +++ b/arch/arm/mach-exynos4/clock-exynos4212.c
> +static struct sleep_save exynos4212_clock_save[] = {
> + ? ? ? SAVE_ITEM(S5P_CLKSRC_IMAGE),
> + ? ? ? SAVE_ITEM(S5P_CLKDIV_IMAGE),
> + ? ? ? SAVE_ITEM(S5P_CLKGATE_IP_IMAGE_4212),
> + ? ? ? SAVE_ITEM(S5P_CLKGATE_IP_PERIR_4212),
> +};
> +
> --- a/arch/arm/mach-exynos4/clock.c
> +++ b/arch/arm/mach-exynos4/clock.c
> +static struct sleep_save exynos4_clock_save[] = {

Hello,

Is there any reason to have the following two
SAVE_ITEM(S5P_CLKSRC_IMAGE),
SAVE_ITEM(S5P_CLKDIV_IMAGE
defined at both clock-exynos4210.c and clock-exynos4212.c, not defined
at clock.c once?


Also, consider using CONFIG_PM_SLEEP rather than CONFIG_PM for
suspend/resume ops.


Cheers!
MyungJoo

-- 
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab, DMC Business, Samsung Electronics
