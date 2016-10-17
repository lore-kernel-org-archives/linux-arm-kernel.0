From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 17 Oct 2016 11:56:05 +0100
Subject: [PATCH] ARM64-cpuinfo: Combine six calls for sequence output
 into one seq_printf() call in c_show()
In-Reply-To: <83d98772-8872-1b75-a9a5-5f08b8462e18@users.sourceforge.net>
References: <83d98772-8872-1b75-a9a5-5f08b8462e18@users.sourceforge.net>
Message-ID: <20161017105605.GB29095@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 16, 2016 at 09:03:52PM +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 16 Oct 2016 20:48:28 +0200
> 
> Some data were printed into a sequence by six separate function calls.
> Print the same data by a single function call instead.

... why?

Beyond simply having fewer function calls, is there an upside?

This makes it harder to see the relationship between the format strings
and their associated data, and makes the code longer.

Thanks,
Mark.

> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/arm64/kernel/cpuinfo.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index b3d5b3e..f22687d 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -148,14 +148,17 @@ static int c_show(struct seq_file *m, void *v)
>  				if (elf_hwcap & (1 << j))
>  					seq_printf(m, " %s", hwcap_str[j]);
>  		}
> -		seq_puts(m, "\n");
> -
> -		seq_printf(m, "CPU implementer\t: 0x%02x\n",
> -			   MIDR_IMPLEMENTOR(midr));
> -		seq_printf(m, "CPU architecture: 8\n");
> -		seq_printf(m, "CPU variant\t: 0x%x\n", MIDR_VARIANT(midr));
> -		seq_printf(m, "CPU part\t: 0x%03x\n", MIDR_PARTNUM(midr));
> -		seq_printf(m, "CPU revision\t: %d\n\n", MIDR_REVISION(midr));
> +		seq_printf(m,
> +			   "\n"
> +			   "CPU implementer\t: 0x%02x\n"
> +			   "CPU architecture: 8\n"
> +			   "CPU variant\t: 0x%x\n"
> +			   "CPU part\t: 0x%03x\n"
> +			   "CPU revision\t: %d\n\n",
> +			   MIDR_IMPLEMENTOR(midr),
> +			   MIDR_VARIANT(midr),
> +			   MIDR_PARTNUM(midr),
> +			   MIDR_REVISION(midr));
>  	}
>  
>  	return 0;
> -- 
> 2.10.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
