From: will.deacon@arm.com (Will Deacon)
Date: Mon, 17 Feb 2014 18:12:10 +0000
Subject: [PATCH v3 1/6] arm64: Add ftrace support
In-Reply-To: <1391768336-5642-2-git-send-email-takahiro.akashi@linaro.org>
References: <1382598488-13511-1-git-send-email-takahiro.akashi@linaro.org>
 <1391768336-5642-1-git-send-email-takahiro.akashi@linaro.org>
 <1391768336-5642-2-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140217181209.GF26590@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 10:18:51AM +0000, AKASHI Takahiro wrote:
> This patch implements arm64 specific part to support function tracers,
> such as function (CONFIG_FUNCTION_TRACER), function_graph
> (CONFIG_FUNCTION_GRAPH_TRACER) and function profiler
> (CONFIG_FUNCTION_PROFILER).
> 
> With 'function' tracer, all the functions in the kernel are traced with
> timestamps in ${sysfs}/tracing/trace. If function_graph tracer is
> specified, call graph is generated.
> 
> The kernel must be compiled with -pg option so that _mcount() is inserted
> at the beginning of functions. This function is called on every function's
> entry as long as tracing is enabled.
> In addition, function_graph tracer also needs to be able to probe function's
> exit. ftrace_graph_caller() & return_to_handler do this by faking link
> register's value to intercept function's return path.
> 
> More details on architecture specific requirements are described in
> Documentation/trace/ftrace-design.txt.

[...]

> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> new file mode 100644
> index 0000000..0d5dfdb
> --- /dev/null
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -0,0 +1,23 @@
> +/*
> + * arch/arm64/include/asm/ftrace.h
> + *
> + * Copyright (C) 2013 Linaro Limited
> + * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef __ASM_FTRACE_H
> +#define __ASM_FTRACE_H
> +
> +#ifdef CONFIG_FUNCTION_TRACER
> +#define MCOUNT_ADDR            ((unsigned long)_mcount)
> +#define MCOUNT_INSN_SIZE       4 /* sizeof mcount call */

You can use AARCH64_INSN_SIZE here.

> +#include <linux/linkage.h>
> +#include <asm/ftrace.h>
> +
> +/*
> + * Gcc with -pg will put the following code in the beginning of each function:
> + *      mov x0, x30
> + *      bl _mcount
> + *     [function's body ...]
> + * "bl _mcount" may be replaced to "bl ftrace_caller" or NOP if dynamic
> + * ftrace is enabled.
> + *
> + * Please note that x0 as an argument will not be used here because we can
> + * get lr(x30) of insturmented function at any time by winding up call stack

instrumented

> + * as long as the kernel is compiled without -fomit-frame-pointer.
> + * (or CONFIG_FRAME_POINTER, this is forced on arm64)
> + *
> + * stack layout after mcount_enter:
> + *
> + *   0 ---------------------------------------- sp of _mcount()
> + *      x29: fp of instrumented function       fp is not winded
> + *     --------------------
> + *      x30: lr of _mcount() (= instrumented function's pc)
> + * +16 ---------------------------------------- sp of instrumented function
> + *
> + *     ....
> + *
> + * +xx ---------------------------------------- fp of instrumented function
> + *      x29: fp of parent
> + *     --------------------
> + *      x30: lr of insturmented function (= parent's pc)
> + *     --------------------
> + *      xxx
> + */
> +
> +       .macro mcount_enter
> +       stp     x29, x30, [sp, #-48]!
> +       .endm

Can you elaborate in your comment about where this 48 comes from please? I
can't join it up with your ascii art.

Will
