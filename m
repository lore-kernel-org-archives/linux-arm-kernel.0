From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 10 May 2016 15:54:41 +0100
Subject: [PATCH] arm64: cpuinfo: Missing NULL terminator in
 compat_hwcap_str
In-Reply-To: <1462891231-17605-1-git-send-email-julien.grall@arm.com>
References: <1462891231-17605-1-git-send-email-julien.grall@arm.com>
Message-ID: <20160510145441.GC10785@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2016 at 03:40:31PM +0100, Julien Grall wrote:
> The loop that browses the array compat_hwcap_str will stop when a NULL
> is encountered, however NULL is missing at the end of array. This will
> result to overrun until one NULL is found somewhere in the memory.

Probably worth adding something like:

Note for backporting: commit 12d11817eaafa414 ("arm64: Move
/proc/cpuinfo handling code") moved this code. Prior to that commit, the
same change should be made in arch/arm64/kernel/setup.c.

> Fixes: 44b82b7700d0 "arm64: Fix up /proc/cpuinfo"
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> Cc: stable at vger.kernel.org
> 
> ---
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Suzuki K. Poulose <suzuki.poulose@arm.com>
> ---

Wierd middle '---' between the Cc lines above.

Otherwise:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks for fixing this, sorry for introducing it in the first place!

Mark.

>  arch/arm64/kernel/cpuinfo.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index 84c8684..f0c3fb7 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -87,7 +87,8 @@ static const char *const compat_hwcap_str[] = {
>  	"idivt",
>  	"vfpd32",
>  	"lpae",
> -	"evtstrm"
> +	"evtstrm",
> +	NULL
>  };
>  
>  static const char *const compat_hwcap2_str[] = {
> -- 
> 1.9.1
> 
