From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 07 Jul 2017 10:02:03 +0200
Subject: [PATCH] ARM: mvebu: use __pa_symbol in the mv98dx3236 platform
 SMP code
In-Reply-To: <20170707075928.2938-1-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Fri, 7 Jul 2017 09:59:28 +0200")
References: <20170707075928.2938-1-gregory.clement@free-electrons.com>
Message-ID: <87a84gd69w.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

I forgot to CC you on this patch.

Gregory

 On ven., juil. 07 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> As we already did for Armada XP switch from virt_to_phys() to
> __pa_symbol().
>
> The reason for it was well explained by Mark Rutland so let's quote him:
>
> "virt_to_phys() is intended to operate on the linear/direct mapping of
> RAM.
>
> __pa_symbol() is intended to operate on the kernel mapping, which may
> not be in the linear/direct mapping on all architectures. e.g. arm64 and
> x86_64 map the kernel image and RAM separately.
>
> On 32-bit ARM the kernel image mapping is tied to the linear/direct
> mapping, so that works, but as it's semantically wrong (and broken for
> generic code), the DEBUG_VIRTUAL checks complain."
>
> Fixes: db88977894ab ("arm: mvebu: support for SMP on 98DX3336 SoC")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>
> Hi Chris,
>
> with this patch I don't expect any regression, hover it would be nice
> if you can test it.
>
> Thanks,
>
> Gregory
>
>  arch/arm/mach-mvebu/platsmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
> index e62273aacb43..4ffbbd217e82 100644
> --- a/arch/arm/mach-mvebu/platsmp.c
> +++ b/arch/arm/mach-mvebu/platsmp.c
> @@ -211,7 +211,7 @@ static int mv98dx3236_resume_set_cpu_boot_addr(int hw_cpu, void *boot_addr)
>  		return PTR_ERR(base);
>  
>  	writel(0, base + MV98DX3236_CPU_RESUME_CTRL_REG);
> -	writel(virt_to_phys(boot_addr), base + MV98DX3236_CPU_RESUME_ADDR_REG);
> +	writel(__pa_symbol(boot_addr), base + MV98DX3236_CPU_RESUME_ADDR_REG);
>  
>  	iounmap(base);
>  
> -- 
> 2.13.2
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
