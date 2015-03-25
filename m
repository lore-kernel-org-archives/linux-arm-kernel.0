From: peter.crosthwaite@xilinx.com (Peter Crosthwaite)
Date: Wed, 25 Mar 2015 15:28:26 +0530
Subject: [PATCH] arm64: Implement cpu_relax as yield
In-Reply-To: <ad93acf5318c404683f5654d6734316e@BL2FFO11FD047.protection.gbl>
References: <ad93acf5318c404683f5654d6734316e@BL2FFO11FD047.protection.gbl>
Message-ID: <CAEgOgz6q_dOUaEvgH=Bnz3pafWtxVx8tYvSM26yX1s=2svUY7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping!

Anything I need to do or send to to get a merge on this?

Regards,
Peter

On Tue, Mar 3, 2015 at 12:49 AM, Peter Crosthwaite
<peter.crosthwaite@xilinx.com> wrote:
> ARM64 has the yield nop hint which has the intended semantics of
> cpu_relax. Implement.
>
> The immediate application is ARM CPU emulators. An emulator can take
> advantage of the yield hint to de-prioritise an emulated CPU in favor
> of other emulation tasks. QEMU A64 SMP emulation has yield awareness,
> and sees a significant boot time performance increase with this change.
>
> Signed-off-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/processor.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index f9be30e..ac2381d 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -126,7 +126,11 @@ extern void release_thread(struct task_struct *);
>
>  unsigned long get_wchan(struct task_struct *p);
>
> -#define cpu_relax()                    barrier()
> +static inline void cpu_relax(void)
> +{
> +       asm volatile("yield" ::: "memory");
> +}
> +
>  #define cpu_relax_lowlatency()                cpu_relax()
>
>  /* Thread switching */
> --
> 2.3.0.1.g27a12f1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
