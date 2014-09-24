From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 24 Sep 2014 09:25:28 +0200
Subject: [PATCH 0/5] pinctrl: samsung: Data structure clean-up
In-Reply-To: <1411499141-26551-1-git-send-email-tomasz.figa@gmail.com>
References: <1411499141-26551-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <542271E8.4020606@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-09-23 21:05, Tomasz Figa wrote:
> This series intends to clean up data structures used by pinctrl-samsung driver.
> More specifically, it separates initial compile time constants from data used
> at runtime, allowing unused variant data to be dropped and selected structures
> constified to improve safety.
>
> As a side effect, size of vmlinux built from multi_v7_defconfig was reduced
> from:
>
>   text     data    bss    dec      hex    filename
>   10296708 1227100 313544 11837352 b49fa8 vmlinux
>
> to:
>
>   text     data    bss    dec      hex    filename
>   10296740 1176860 313544 11787144 b3db88 vmlinux
>
> and quite a bit of data were moved from normal data sections to .init.data:
>
> pre:
>
> Idx Name          Size      VMA       LMA       File off  Algn
>    3 .rodata       0026c080  c0881000  c0881000  00681000  2**6
>   23 .init.data    0003ff7c  c0bdb830  c0bdb830  009e3830  2**3
>   24 .data..percpu 00002100  c0c1c000  c0c1c000  00a24000  2**6
>   25 .data         000e98e0  c0c20000  c0c20000  00a28000  2**6
>
> post:
>
> Idx Name          Size      VMA       LMA       File off  Algn
>    3 .rodata       0026bf20  c0881000  c0881000  00681000  2**6
>   23 .init.data    00041bbc  c0bdb830  c0bdb830  009e3830  2**3
>   24 .data..percpu 00002100  c0c1e000  c0c1e000  00a26000  2**6
>   25 .data         000db860  c0c22000  c0c22000  00a2a000  2**6
>
> This series should not introduce any functional changes.
>
> Tested on S3C6410-based Mini6410 board, booting with device tree.
>
> Marek, Bart, could you do some testing on Exynos-based boards,
> just to make sure?

Works fine on Exynos4412 based OdroidU3+ and Exynos4210 Universal C210.

For the whole patchset:
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> Tomasz Figa (5):
>    pinctrl: samsung: Make samsung_pinctrl_get_soc_data use ERR_PTR()
>    pinctrl: samsung: Drop unused label field in samsung_pin_ctrl struct
>    pinctrl: samsung: Constify samsung_pin_bank_type struct
>    pinctrl: samsung: Constify samsung_pin_ctrl struct
>    pinctrl: samsung: Separate per-bank init and runtime data
>
>   drivers/pinctrl/samsung/pinctrl-exynos.c  | 113 +++++++++++----------------
>   drivers/pinctrl/samsung/pinctrl-s3c24xx.c |  30 +++----
>   drivers/pinctrl/samsung/pinctrl-s3c64xx.c |  31 ++++----
>   drivers/pinctrl/samsung/pinctrl-samsung.c | 126 ++++++++++++++++--------------
>   drivers/pinctrl/samsung/pinctrl-samsung.h |  78 ++++++++++++------
>   5 files changed, 193 insertions(+), 185 deletions(-)
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
