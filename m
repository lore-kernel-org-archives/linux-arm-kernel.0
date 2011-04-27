From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Apr 2011 13:49:52 +0100
Subject: [PATCH] ARM: cache-l2x0: fix wrong print of AUX_CTRL register
In-Reply-To: <1303907194-3121-1-git-send-email-srinidhi.kasagar@stericsson.com>
References: <1303907194-3121-1-git-send-email-srinidhi.kasagar@stericsson.com>
Message-ID: <BANLkTimv1VqAaSLhV82g+MCGHUiLf8yhGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 April 2011 13:26, srinidhi kasagar
<srinidhi.kasagar@stericsson.com> wrote:
> On platforms where l2x0 is already enabled and configured
> by the secure code, printing the masked value of the
> AUX_CTRL register seems to be wrong and differ from the
> programmed value.
>
> Fix it by reading the AUX_CTRL register again.
>
> Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> Signed-off-by: Vijaya Kumar Kilari <vijay.kilari@stericsson.com>
> ---
> ?arch/arm/mm/cache-l2x0.c | ? ?2 ++
> ?1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index ef59099..d07f8cb 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -340,6 +340,8 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
> ? ? ? ?outer_cache.disable = l2x0_disable;
> ? ? ? ?outer_cache.set_debug = l2x0_set_debug;
>
> + ? ? ? aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
> +
> ? ? ? ?printk(KERN_INFO "%s cache controller enabled\n", type);
> ? ? ? ?printk(KERN_INFO "l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%08x, Cache size: %d B\n",
> ? ? ? ? ? ? ? ? ? ? ? ?ways, cache_id, aux, l2x0_size);

Rather than re-reading it, you could actually move the masking to the
'if' block that writes that value. I have a patch in Russell's system
that does this together with setting bit 22 but it hasn't been merged
(I still think it should be):

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6529/1

-- 
Catalin
