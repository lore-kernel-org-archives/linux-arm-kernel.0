From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 24 Feb 2015 17:46:32 +0900
Subject: [RESEND PATCH] ARM: EXYNOS: Fix failed second suspend on Exynos4
In-Reply-To: <1424256325-16659-1-git-send-email-k.kozlowski@samsung.com>
References: <1424256325-16659-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <54EC3A68.3030207@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2015 07:45 PM, Krzysztof Kozlowski wrote:
> On Exynos4412 boards (Trats2, Odroid U3) after enabling L2 cache in
> 56b60b8bce4a ("ARM: 8265/1: dts: exynos4: Add nodes for L2 cache
> controller") the second suspend to RAM failed. First suspend worked fine
> but the next one hang just after powering down of secondary CPUs (system
> consumed energy as it would be running but was not responsive).
> 
> The issue was caused by enabling delayed reset assertion for CPU0 just
> after issuing power down of cores. This was introduced for Exynos4 in
> 13cfa6c4f7fa ("ARM: EXYNOS: Fix CPU idle clock down after CPU off").
> 
> The whole behavior is not well documented but after checking with vendor
> code this should be done like this (on Exynos4):
> 1. Enable delayed reset assertion when system is running (for all CPUs).
> 2. Disable delayed reset assertion before suspending the system.
>    This can be done after powering off secondary CPUs.
> 3. Re-enable the delayed reset assertion when system is resumed.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Fixes: 13cfa6c4f7fa ("ARM: EXYNOS: Fix CPU idle clock down after CPU off")
> Cc: <stable@vger.kernel.org>
> ---
>  arch/arm/mach-exynos/common.h  |  2 ++
>  arch/arm/mach-exynos/exynos.c  | 27 +++++++++++++++++++++++++++
>  arch/arm/mach-exynos/platsmp.c | 39 ++-------------------------------------
>  arch/arm/mach-exynos/suspend.c |  3 +++
>  4 files changed, 34 insertions(+), 37 deletions(-)

Tested-by: Chanwoo Choi <cw00.choi@samsung.com>

I tested this patch on Exynos4412-baed TRATS2 board.

Thanks,
Chanwoo Choi
