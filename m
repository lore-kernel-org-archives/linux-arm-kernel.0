From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 30 Dec 2009 16:50:47 +0800
Subject: [PATCH 2/2] pxa: enable L2 if present in XSC3
In-Reply-To: <771cded00912292328j459b5218r64703d59165fe98f@mail.gmail.com>
References: <771cded00912292328j459b5218r64703d59165fe98f@mail.gmail.com>
Message-ID: <f17812d70912300050p24c0fb2ayd6f68ffc01a67529@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 30, 2009 at 3:28 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> From 2c4a7d0e907df9a762c5c9f0ec48b3b7860e1f7c Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Wed, 30 Dec 2009 10:02:57 -0500
> Subject: [PATCH] [ARM] pxa: enable L2 if present in XSC3
>
> Check whether L2 is present or not in XSC3. If it's present, enable L2
> immediately.
>
> Disabling L2 after L2 is enabled that would result in unpredicatable behavior
> of XSC3 processor.
>

You may want to enclose this with #ifdef CONFIG_CACHE_XSC3L2 .. #endif
at least, to allow L2 to remain disabled even if L2 is present.

> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
> ?arch/arm/mm/proc-xsc3.S | ? ?5 +++++
> ?1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mm/proc-xsc3.S b/arch/arm/mm/proc-xsc3.S
> index 33515c2..8fbe21f 100644
> --- a/arch/arm/mm/proc-xsc3.S
> +++ b/arch/arm/mm/proc-xsc3.S
> @@ -406,6 +406,11 @@ __xsc3_setup:
>
> ? ? ? ?adr ? ? r5, xsc3_crval
> ? ? ? ?ldmia ? r5, {r5, r6}
> +
> + ? ? ? mrc ? ? p15, 1, r0, c0, c0, 1 ? ? ? ? ? @ get L2 present information
> + ? ? ? ands ? ?r0, r0, #0xf8
> + ? ? ? orrne ? r6, r6, #(1 << 26) ? ? ? ? ? ? ?@ enable L2 if present
> +
> ? ? ? ?mrc ? ? p15, 0, r0, c1, c0, 0 ? ? ? ? ? @ get control register
> ? ? ? ?bic ? ? r0, r0, r5 ? ? ? ? ? ? ? ? ? ? ?@ ..V. ..R. .... ..A.
> ? ? ? ?orr ? ? r0, r0, r6 ? ? ? ? ? ? ? ? ? ? ?@ ..VI Z..S .... .C.M (mmu)
> --
> 1.5.6.5
>
