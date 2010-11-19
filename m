From: h-kanigeri2@ti.com (Kanigeri, Hari)
Date: Fri, 19 Nov 2010 05:30:14 -0600
Subject: [PATCH] ARM: l2x0: Check the correct address range
In-Reply-To: <20101119014029.GA26429@july>
References: <20101119014029.GA26429@july>
Message-ID: <AANLkTikpAPLSTAzm2iPSV1_LL=B+zPbWzTPdhne3XFVc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Boojin Kim <boojin.kim@samsung.com>
>
> When flush or clean the 1MiB, it doesn't flush or clean all since it doesn't check the correct address. So Check the correct address range.

I saw this before but then I thought that the individual callers of
cache functions have to call with  +1 to the end address.

>
> Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index 170c9bb..50599d9 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -195,7 +195,7 @@ static void l2x0_clean_range(unsigned long start, unsigned long end)
> ? ? ? ?void __iomem *base = l2x0_base;
> ? ? ? ?unsigned long flags;
>
> - ? ? ? if ((end - start) >= l2x0_size) {
> + ? ? ? if ((end - start + 1) >= l2x0_size) {

nitpick: probably will look more obvious if it is coded as  if ((end +
1) - start) >= l2x0_size)

> ? ? ? ? ? ? ? ?l2x0_clean_all();
> ? ? ? ? ? ? ? ?return;
> ? ? ? ?}
> @@ -225,7 +225,7 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
> ? ? ? ?void __iomem *base = l2x0_base;
> ? ? ? ?unsigned long flags;
>
> - ? ? ? if ((end - start) >= l2x0_size) {
> + ? ? ? if ((end - start + 1) >= l2x0_size) {

same as above.


Thank you,
Best regards,
Hari Kanigeri
