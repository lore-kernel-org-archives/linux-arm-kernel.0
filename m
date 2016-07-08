From: pmladek@suse.com (Petr Mladek)
Date: Fri, 8 Jul 2016 16:58:00 +0200
Subject: [PATCH v2 1/2] arm64: implement FTRACE_WITH_REGS
In-Reply-To: <20160627151717.BD25468D26@newverein.lst.de>
References: <20160627151500.2247A68D20@newverein.lst.de>
 <20160627151717.BD25468D26@newverein.lst.de>
Message-ID: <20160708145800.GE3556@pathway.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2016-06-27 17:17:17, Torsten Duwe wrote:
> Once gcc is enhanced to optionally generate NOPs at the beginning
> of each function, like the concept proven in
> https://gcc.gnu.org/ml/gcc-patches/2016-04/msg01671.html
> (sans the "fprintf (... pad_size);", which spoils the data structure
> for kernel use), the generated pads can nicely be used to reroute
> function calls for tracing/profiling, or live patching.
> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> index ebecf9a..917065c 100644
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -39,6 +39,12 @@ static int ftrace_modify_code(unsigned long pc, u32 old, u32 new,
>  		if (aarch64_insn_read((void *)pc, &replaced))
>  			return -EFAULT;
>  
> +		/* If we already have what we'll finally want,
> +		 * report success. This is needed on startup.
> +		 */
> +		if (replaced == new)
> +			return 0;

This looks strange. I wonder if it actually hides a real bug that we
modify the code twice or so.

I wanted to try it myself but I haven't succeeded with creating an ARM test
system yet.

Best Regards,
Petr
