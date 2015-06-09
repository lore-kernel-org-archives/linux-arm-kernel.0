From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Jun 2015 14:09:48 +0100
Subject: [PATCH 1/1] ARM : missing corrupted reg in __do_div_asm
In-Reply-To: <1433225609-7148-1-git-send-email-gangchen@rdamicro.com>
References: <1433225609-7148-1-git-send-email-gangchen@rdamicro.com>
Message-ID: <20150609130948.GD7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 02, 2015 at 02:13:29PM +0800, Chen Gang wrote:
> __xl (r0 in little endian system, or R1 in big endian system) is corrupted
> after calling __do_div64 and compiler is not informed about this in
> macro __do_div_asm. If n is used again afterwards, __xl won't be
> reloaded and n will contain incorrect value.
> ---

This commit message needs improving.  Please either upper case both r0
and r1 in the first line, or lower case them both.  Secondly, the Linux
kernel has a requirement that all contributions are signed-off.  Please
read Documentation/SubmittingPatches for information, particularly
section 11.

Other than that, the patch looks fine, thanks.

>  arch/arm/include/asm/div64.h | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
> index 662c7bd..fa9489e 100644
> --- a/arch/arm/include/asm/div64.h
> +++ b/arch/arm/include/asm/div64.h
> @@ -34,12 +34,14 @@
>  	register unsigned long long __n   asm("r0") = n;	\
>  	register unsigned long long __res asm("r2");		\
>  	register unsigned int __rem       asm(__xh);		\
> +	register unsigned int __clobber   asm(__xl);		\
>  	asm(	__asmeq("%0", __xh)				\
> -		__asmeq("%1", "r2")				\
> -		__asmeq("%2", "r0")				\
> -		__asmeq("%3", "r4")				\
> +		__asmeq("%1", __xl)				\
> +		__asmeq("%2", "r2")				\
> +		__asmeq("%3", "r0")				\
> +		__asmeq("%4", "r4")				\
>  		"bl	__do_div64"				\
> -		: "=r" (__rem), "=r" (__res)			\
> +		: "=r" (__rem), "=r" (__clobber), "=r" (__res)  \
>  		: "r" (__n), "r" (__base)			\
>  		: "ip", "lr", "cc");				\
>  	n = __res;						\
> -- 
> 1.9.1
> 
> 

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
