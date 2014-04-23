From: liu.h.jason@gmail.com (Jason Liu)
Date: Wed, 23 Apr 2014 17:15:54 +0800
Subject: Perf top always show 0.00
In-Reply-To: <CAHrpEqQZ_0G-rmwfaeEzHOFVckyRRSUpYrPdMUgPjRZ1JYyy6g@mail.gmail.com>
References: <CAHrpEqQZ_0G-rmwfaeEzHOFVckyRRSUpYrPdMUgPjRZ1JYyy6g@mail.gmail.com>
Message-ID: <CAB4PhKdP_gXiB56DPLC3DxdjW2Epr_RTghW_VL1X84Ux1U+bLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Frank,

2014-04-19 1:00 GMT+08:00 Frank Li <lznuaa@gmail.com>:
> I use mx6dq platform. Found below problem.
>
> Run Perf top. First column always 0, but order look like correct.
>
>    0.00%  perf          [.] 0x00049420
>      0.00%  [kernel]      [k] kallsyms_expand_symbol.constprop.5
>      0.00%  [kernel]      [k] vsnprintf
>      0.00%  [kernel]      [k] arch_cpu_idle
>      0.00%  [kernel]      [k] format_decode
>      0.00%  [kernel]      [k] number.isra.2
>      0.00%  libc-2.19.so  [.] strstr
>      0.00%  libc-2.19.so  [.] 0x00072498
>      0.00%  libc-2.19.so  [.] memchr
>      0.00%  [kernel]      [k] _raw_spin_unlock_irqrestore
>      0.00%  [kernel]      [k] string.isra.4
>      0.00%  [kernel]      [k] strnlen
>      0.00%  libc-2.19.so  [.] getdelim
>      0.00%  libc-2.19.so  [.] memcpy
>      0.00%  [kernel]      [k] lock_acquire
>      0.00%  libc-2.19.so  [.] strchr
>      0.00%  libc-2.19.so  [.] strcmp
>      0.00%  [kernel]      [k] _raw_spin_unlock_irq
>      0.00%  libc-2.19.so  [.] __libc_calloc
>      0.00%  libc-2.19.so  [.] _IO_feof
>      0.00%  [kernel]      [k] pointer.isra.15

This issue has been resolved by the following commit:

commit 9dfd005a3f4e1c648cb4aa1dc70604bb370c5e7b
Author: Michael Hudson-Doyle <michael.hudson@linaro.org>
Date:   Thu Oct 31 16:47:45 2013 -0700

    perf tools: Remove cast of non-variadic function to variadic

    commit 53805eca3d89b095062c11a6798689bb0af09216 upstream.

    The 4fb71074a570 (perf ui/hist: Consolidate hpp helpers) cset introduced
    a cast of percent_color_snprintf to a function pointer type with
    varargs.  Change percent_color_snprintf to be variadic and remove the
    cast.

    The symptom of this was all percentages being reported as 0.00% in perf
    report --stdio output on the armhf arch.

    Signed-off-by: Michael Hudson-Doyle <michael.hudson@linaro.org>
    Acked-by: Namhyung Kim <namhyung@kernel.org>
    Acked-by: Will Deacon <will.deacon@arm.com>
    Cc: Jean Pihet <jean.pihet@linaro.org>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Will Deacon <will.deacon@arm.com>
    Link: http://lkml.kernel.org/r/87zjppvw7y.fsf at canonical.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


Jason Liu
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
