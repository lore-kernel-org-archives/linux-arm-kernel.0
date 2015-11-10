From: alexei.starovoitov@gmail.com (Alexei Starovoitov)
Date: Tue, 10 Nov 2015 14:42:06 -0800
Subject: Failed to build arm64 bpf samples with LLVM 3.7 on 4.3 kernel
In-Reply-To: <564244B6.9050202@linaro.org>
References: <564244B6.9050202@linaro.org>
Message-ID: <CAADnVQJ+4maNAbMgTwJAHka0jX8ut5v9Nxh=4tOnhJdAbOm2hQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 10, 2015 at 11:25 AM, Shi, Yang <yang.shi@linaro.org> wrote:
> Hi guys,
>
> I just tried to build arm64 bpf samples on 4.3 kernel, but LLVM complain:
>
> LLVM ERROR: Inline asm not supported by this streamer because we don't have
> an asm parser for this target
>
> I took some time to bisect it, then found it is caused by sysreg.h
>
> There is inline assembly macro defined in sysreg.h:
>
> asm(
> "       .irp
> num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30\n"
> "       .equ    __reg_num_x\\num, \\num\n"
> "       .endr\n"
> "       .equ    __reg_num_xzr, 31\n"
> "\n"
> "       .macro  mrs_s, rt, sreg\n"
> "       .inst   0xd5200000|(\\sreg)|(__reg_num_\\rt)\n"
> "       .endm\n"
> "\n"
> "       .macro  msr_s, sreg, rt\n"
> "       .inst   0xd5000000|(\\sreg)|(__reg_num_\\rt)\n"
> "       .endm\n"
> );
>
> sysreg.h was not included by any other arm64 header files in 4.2, but in 4.3
> it is included by futex.h and uaccess.h, which are included by bpf samples
> via skbuff.h.
>
> But, it sounds LLVM can't recognize it. I'm not familiar with LLVM, so any
> suggestion?
>
> Could it be worked around by some LLVM compile flags?

hmm this used to work. I don't have arm64 setup anymore.
Try hacking it by adding #define __ASM_SYSREG_H to prevent inclusion
of that file? all those asms are unused anyway.
tracing samples include kernel headers to have exact struct layout.
and #include skbuff.h can be removed from almost all samples.
In-kernel 'struct sk_buff' only used inside tracex1_kern.c
