From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Fri, 08 Nov 2013 23:17:32 +0100
Subject: [patch] [media] exynos4-is: cleanup a define
In-Reply-To: <20131108095224.GJ27977@elgon.mountain>
References: <20131108095224.GJ27977@elgon.mountain>
Message-ID: <527D62FC.3010001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


(dropping some unrelated e-mail addresses from Cc)

On 11/08/2013 10:52 AM, Dan Carpenter wrote:
> This define is only used in s5pcsis_irq_handler():
>
> 	if ((status&  S5PCSIS_INTSRC_NON_IMAGE_DATA)&&  pktbuf->data) {
>
> The problem is that "status" is a 32 bit and (0xff<<  28) is larger than
> 32 bits and that sets off a static checker warning.  I consulted with
> Sylwester Nawrocki and the define should actually be (0xf<<  28).
>
> Signed-off-by: Dan Carpenter<dan.carpenter@oracle.com>

Thanks for the fix, patch added to my tree for v3.14.

> diff --git a/drivers/media/platform/exynos4-is/mipi-csis.c b/drivers/media/platform/exynos4-is/mipi-csis.c
> index 9fc2af6..31dfc50 100644
> --- a/drivers/media/platform/exynos4-is/mipi-csis.c
> +++ b/drivers/media/platform/exynos4-is/mipi-csis.c
> @@ -91,7 +91,7 @@ MODULE_PARM_DESC(debug, "Debug level (0-2)");
>   #define S5PCSIS_INTSRC_ODD_BEFORE	(1<<  29)
>   #define S5PCSIS_INTSRC_ODD_AFTER	(1<<  28)
>   #define S5PCSIS_INTSRC_ODD		(0x3<<  28)
> -#define S5PCSIS_INTSRC_NON_IMAGE_DATA	(0xff<<  28)
> +#define S5PCSIS_INTSRC_NON_IMAGE_DATA	(0xf<<  28)
>   #define S5PCSIS_INTSRC_FRAME_START	(1<<  27)
>   #define S5PCSIS_INTSRC_FRAME_END	(1<<  26)
>   #define S5PCSIS_INTSRC_ERR_SOT_HS	(0xf<<  12)

--
Regards,
Sylwester
