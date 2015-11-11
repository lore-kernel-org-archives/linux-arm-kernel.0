From: alexei.starovoitov@gmail.com (Alexei Starovoitov)
Date: Tue, 10 Nov 2015 16:47:17 -0800
Subject: Failed to build arm64 bpf samples with LLVM 3.7 on 4.3 kernel
In-Reply-To: <56427972.5000004@linaro.org>
References: <564244B6.9050202@linaro.org>
 <CAADnVQJ+4maNAbMgTwJAHka0jX8ut5v9Nxh=4tOnhJdAbOm2hQ@mail.gmail.com>
 <56427972.5000004@linaro.org>
Message-ID: <20151111004716.GB47378@ast-mbp.thefacebook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 10, 2015 at 03:10:42PM -0800, Shi, Yang wrote:
> 
> >Try hacking it by adding #define __ASM_SYSREG_H to prevent inclusion
> >of that file? all those asms are unused anyway.
> >tracing samples include kernel headers to have exact struct layout.
> >and #include skbuff.h can be removed from almost all samples.
> >In-kernel 'struct sk_buff' only used inside tracex1_kern.c
> 
> The below change works:
> 
>         clang $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS) \
> -               -D__KERNEL__ -Wno-unused-value -Wno-pointer-sign \
> +               -D__KERNEL__ -D__ASM_SYSREG_H -Wno-unused-value
> -Wno-pointer-sign \
>                 -O2 -emit-llvm -c $< -o -| $(LLC) -march=bpf -filetype=obj
> -o $@
> 
> Is it ok for upstream too?

It's fragile and ugly, but I don't see a cleaner way for arm64,
so yes, please submit it officially.

Thanks!
