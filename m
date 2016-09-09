From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 9 Sep 2016 13:40:07 +0100
Subject: [PATCH 1/6] arm64: sysreg: replace open-coded mrs_s/msr_s with
 {read,write}_sysreg_s
In-Reply-To: <1473419765-3437-2-git-send-email-will.deacon@arm.com>
References: <1473419765-3437-1-git-send-email-will.deacon@arm.com>
 <1473419765-3437-2-git-send-email-will.deacon@arm.com>
Message-ID: <20160909124007.GD10562@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2016 at 12:16:00PM +0100, Will Deacon wrote:
> Similar to our {read,write}_sysreg accessors for architected, named
> system registers, this patch introduces {read,write}_sysreg_s variants
> that can take arbitrary sys_reg output and therefore access IMPDEF
> registers or registers that unsupported by binutils.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/cputype.h |  6 +-----
>  arch/arm64/include/asm/sysreg.h  | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+), 5 deletions(-)

> +#define write_sysreg_s(v, r) do {					\
> +	u64 __val = (u64)v;					\
> +	asm volatile("msr_s " __stringify(r) ", %0"		\
> +		     : : "r" (__val));				\
> +} while (0)

As with my patches, can we please make write_sysreg_s allow the zero
register? i.e. use the "%x0" tempate and "rZ" constraint. The mrs_s asm
template should handle that correctly.

With that:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
