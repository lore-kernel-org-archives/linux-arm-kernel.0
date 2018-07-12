From: daniel@iogearbox.net (Daniel Borkmann)
Date: Thu, 12 Jul 2018 21:02:41 +0200
Subject: [PATCH 00/14] ARM BPF jit compiler improvements
In-Reply-To: <20180711093033.GP17271@n2100.armlinux.org.uk>
References: <20180711093033.GP17271@n2100.armlinux.org.uk>
Message-ID: <bf534d05-8f75-20bc-e25e-4536c1123585@iogearbox.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2018 11:30 AM, Russell King - ARM Linux wrote:
> Hi,
> 
> This series improves the ARM BPF JIT compiler by:
> - enumerating the stack layout rather than using constants that happen
>   to be multiples of four
> - rejig the BPF "register" accesses to use negative numbers instead of
>   positive, which could be confused with register numbers in the bpf2a32
>   array.
> - since we maintain the ARM FP register as a pointer to the top of our
>   scratch space (or, with frame pointers enabled, a valid ARM frame
>   pointer register), we can access our scratch space using FP, which is
>   constant across all BPF programs, including tail-called programs.
> - use immediate forms of ARM instructions where possible, rather than
>   first loading the immediate into an ARM register.
> - use load-with-shift instruction rather than seperate shift instruction
>   followed by load
> - avoid reloading index and array in the tail-call code
> - use double-word load/store instructions where available
> 
> Version 2:
> - Fix ARMv5 test pointed out by Olof
> - Fix build error found by 0-day (adding an additional patch)
> 
>  arch/arm/net/bpf_jit_32.c | 982 ++++++++++++++++++++++++----------------------
>  arch/arm/net/bpf_jit_32.h |  42 +-
>  2 files changed, 543 insertions(+), 481 deletions(-)

Applied to bpf-next, thanks a lot Russell!
