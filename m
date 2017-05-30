From: keescook@chromium.org (Kees Cook)
Date: Tue, 30 May 2017 12:11:08 -0700
Subject: [PATCH v2] arm: eBPF JIT compiler
In-Reply-To: <1495754003-21099-1-git-send-email-illusionist.neo@gmail.com>
References: <1495754003-21099-1-git-send-email-illusionist.neo@gmail.com>
Message-ID: <CAGXu5jKhzzgkOSbvgXBmHz1my+r7=PhAzQZHcxb1XUBn+v+cHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 25, 2017 at 4:13 PM, Shubham Bansal
<illusionist.neo@gmail.com> wrote:
> The JIT compiler emits ARM 32 bit instructions. Currently, It supports
> eBPF only. Classic BPF is supported because of the conversion by BPF
> core.
>
> This patch is essentially changing the current implementation of JIT
> compiler of Berkeley Packet Filter from classic to internal with almost
> all instructions from eBPF ISA supported except the following
>         BPF_ALU64 | BPF_DIV | BPF_K
>         BPF_ALU64 | BPF_DIV | BPF_X
>         BPF_ALU64 | BPF_MOD | BPF_K
>         BPF_ALU64 | BPF_MOD | BPF_X
>         BPF_STX | BPF_XADD | BPF_W
>         BPF_STX | BPF_XADD | BPF_DW
>         BPF_JMP | BPF_CALL
>
> Implementation is using scratch space to emulate 64 bit eBPF ISA on 32 bit
> ARM because of deficiency of general purpose registers on ARM. Currently,
> only LITTLE ENDIAN machines are supported in this eBPF JIT Compiler.
>
> Tested on ARMv7 with QEMU by me (Shubham Bansal).
> Tested on ARMv5 by Andrew Lunn (andrew at lunn.ch).
> Expected to work on ARMv6 as well, as its a part ARMv7 and part ARMv5.
> Although, a proper testing is not done for ARMv6.
>
> Both of these testing are done with and without CONFIG_FRAME_POINTER
> separately for LITTLE ENDIAN machine.
>
> For testing:
>
> 1. JIT is enabled with
>         echo 1 > /proc/sys/net/core/bpf_jit_enable
> 2. Constant Blinding can be enabled along with JIT using
>         echo 1 > /proc/sys/net/core/bpf_jit_enable
>         echo 2 > /proc/sys/net/core/bpf_jit_harden
>
> See Documentation/networking/filter.txt for more information.
>
> Result : test_bpf: Summary: 314 PASSED, 0 FAILED, [278/306 JIT'ed]
>
> Signed-off-by: Shubham Bansal <illusionist.neo@gmail.com>

Thanks for this! Russell, should this patch go via the ARM patch tracker?

-Kees

-- 
Kees Cook
Pixel Security
