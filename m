From: zlim.lnx@gmail.com (Z Lim)
Date: Thu, 12 Nov 2015 19:28:12 -0800
Subject: [PATCH 2/2] arm64: bpf: make BPF prologue and epilogue align with
 ARM64 AAPCS
In-Reply-To: <1447365421-1309-3-git-send-email-yang.shi@linaro.org>
References: <1447365421-1309-1-git-send-email-yang.shi@linaro.org>
 <1447365421-1309-3-git-send-email-yang.shi@linaro.org>
Message-ID: <CABg9mctTj2M7Mw+bPgkDYtorW21uTuLxWnxLFucWPtM4TQ-7VA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2015 at 1:57 PM, Yang Shi <yang.shi@linaro.org> wrote:
>
> Save and restore FP/LR in BPF prog prologue and epilogue, save SP to FP
> in prologue in order to get the correct stack backtrace.
>
> However, ARM64 JIT used FP (x29) as eBPF fp register, FP is subjected to
> change during function call so it may cause the BPF prog stack base address
> change too.
>
> Use x25 to replace FP as BPF stack base register (fp). Since x25 is callee
> saved register, so it will keep intact during function call.
> It is initialized in BPF prog prologue when BPF prog is started to run
> everytime. When BPF prog exits, it could be just tossed.
>
> So, the BPF stack layout looks like:
>
>                                  high
>          original A64_SP =>   0:+-----+ BPF prologue
>                                 |     | FP/LR and callee saved registers
>          BPF fp register => -64:+-----+
>                                 |     |
>                                 | ... | BPF prog stack
>                                 |     |
>                                 |     |
>          current A64_SP/FP =>   +-----+
>                                 |     |
>                                 | ... | Function call stack
>                                 |     |
>                                 +-----+
>                                   low
>

Yang, for stack unwinding to work, shouldn't it be something like the following?

          | LR |
A64_FP => | FP |
          | .. |
