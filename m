From: parkch98@gmail.com (Chanho Park)
Date: Mon, 18 May 2015 10:52:14 +0900
Subject: [PATCH v1 1/1] ARM: EXYNOS: fix DEBUG_LL on Cortex-A7.
In-Reply-To: <1431844923-4654-2-git-send-email-t.dakhran@gmail.com>
References: <1431844923-4654-1-git-send-email-t.dakhran@gmail.com>
 <1431844923-4654-2-git-send-email-t.dakhran@gmail.com>
Message-ID: <CAPTzV17YWyTiFU4wGs=Wy9quC_NzguXuqrheY_JoqAWN=VRniA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tarek,

On Sun, May 17, 2015 at 3:42 PM, Tarek Dakhran <t.dakhran@gmail.com> wrote:
> Cortex-A7 has EXYNOS5_PA_UART base address for UART.
> If system boots from Cortex-A7 CPU addruart loads wrong
> address. This patch fixex this.
>
> Signed-off-by: Tarek Dakhran <t.dakhran@gmail.com>
> ---
>  arch/arm/include/debug/exynos.S | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/include/debug/exynos.S b/arch/arm/include/debug/exynos.S
> index b17fdb7..a61b3ea 100644
> --- a/arch/arm/include/debug/exynos.S
> +++ b/arch/arm/include/debug/exynos.S
> @@ -24,6 +24,7 @@
>                 mrc     p15, 0, \tmp, c0, c0, 0
>                 and     \tmp, \tmp, #0xf0
>                 teq     \tmp, #0xf0             @@ A15
> +               teqne   \tmp, #0x70             @@ A7
>                 ldreq   \rp, =EXYNOS5_PA_UART
>                 movne   \rp, #EXYNOS4_PA_UART   @@ EXYNOS4
>                 ldr     \rv, =S3C_VA_UART
> --
> 1.9.1
>

Please see previous Joonyoung's patch. Your patch could break
exynos3250 because it has not only two cortex-a7 cpus but also uses
EXYOS4_PA_UART.

http://www.spinics.net/lists/linux-samsung-soc/msg37318.html

-- 
Best Regards,
Chanho Park
