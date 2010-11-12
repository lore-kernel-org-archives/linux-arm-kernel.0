From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 12 Nov 2010 16:34:56 +0800
Subject: [PATCH 04/11] ARM: pxa: update to read ICHP
In-Reply-To: <1289546260-6208-4-git-send-email-haojian.zhuang@marvell.com>
References: <1289546260-6208-1-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-2-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-3-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-4-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <AANLkTinn2=G35motQoQhGbw+rk7cQ9trBxqPQKBcj+af@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 12, 2010 at 3:17 PM, Haojian Zhuang
<haojian.zhuang@marvell.com> wrote:
> ICHP records the highest priority interrupt occured. In PXA27x/PXA3xx, we
> can read ICHP via cooprocessor. In PJ4, we can only read ICHP via bus
> register. So use the same method to read ICHP via bus register.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> ---
> ?arch/arm/mach-pxa/include/mach/entry-macro.S | ? ?6 +++++-
> ?1 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/include/mach/entry-macro.S b/arch/arm/mach-pxa/include/mach/entry-macro.S
> index a73bc86..91457dd 100644
> --- a/arch/arm/mach-pxa/include/mach/entry-macro.S
> +++ b/arch/arm/mach-pxa/include/mach/entry-macro.S
> @@ -41,11 +41,15 @@
> ? ? ? ? ? ? ? ?b ? ? ? 1001f
> ?1002:
> ? ? ? ? ? ? ? ?@ Core Generation 2 (PXA27x) or Core Generation 3 (PXA3xx)
> - ? ? ? ? ? ? ? mrc ? ? p6, 0, \irqstat, c5, c0, 0 ? ? ?@ ICHP
> + ? ? ? ? ? ? ? @ or Core PJ4
> + ? ? ? ? ? ? ? mov ? ? \base, #io_p2v(0x40000000) ? ? ?@ IIR Ctl = 0x40d00000
> + ? ? ? ? ? ? ? add ? ? \base, \base, #0x00d00000
> + ? ? ? ? ? ? ? ldr ? ? \irqstat, [\base, #0x18] ? ? ? ?@ ICHP offset

Accessing from co-processor is supposed to be faster than MMIO.

BTW, this could be addressed by MULTI_IRQ_HANDLER as in patch:

http://www.spinics.net/lists/arm-kernel/msg88817.html

Once it gets merged.

> ? ? ? ? ? ? ? ?tst ? ? \irqstat, #0x80000000
> ? ? ? ? ? ? ? ?beq ? ? 1001f
> ? ? ? ? ? ? ? ?bic ? ? \irqstat, \irqstat, #0x80000000
> ? ? ? ? ? ? ? ?mov ? ? \irqnr, \irqstat, lsr #16
> ? ? ? ? ? ? ? ?add ? ? \irqnr, \irqnr, #(PXA_IRQ(0))
> +
> ?1001:
> ? ? ? ? ? ? ? ?.endm
> --
> 1.5.6.5
>
>
