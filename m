From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 2 May 2017 09:31:24 +0100
Subject: [PATCH] ARM: V7M: Set cacheid iff DminLine or IminLine is nonzero
In-Reply-To: <1493201074-35472-1-git-send-email-vladimir.murzin@arm.com>
References: <1493201074-35472-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <6c933cd2-bfaf-e7d3-b868-9d9955a1a105@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/04/17 11:04, Vladimir Murzin wrote:
> Cache support is optional feature in M-class cores, thus DminLine or
> IminLine of Cache Type Register is zero if caches are not implemented,
> but we check the whole CTR which has other features encoded there.
> Let's be more precise and check for DminLine and IminLine of CTR
> before we set cacheid.
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  arch/arm/kernel/setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index f4e5450..231a1d83 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -315,7 +315,7 @@ static void __init cacheid_init(void)
>  	if (arch >= CPU_ARCH_ARMv6) {
>  		unsigned int cachetype = read_cpuid_cachetype();
>  
> -		if ((arch == CPU_ARCH_ARMv7M) && !cachetype) {
> +		if ((arch == CPU_ARCH_ARMv7M) && !(cachetype & 0xf000f)) {
>  			cacheid = 0;
>  		} else if ((cachetype & (7 << 29)) == 4 << 29) {
>  			/* ARMv7 register format */
> 

Ok for patch tracker?

Vladimir
