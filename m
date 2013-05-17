From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 May 2013 09:55:31 +0100
Subject: [Bug] ARM 'perf' regression by commit a43cb95d5
In-Reply-To: <CACVXFVPjo2dQpYPpqZS8GC8UPNzB5HLURpYm6-g1FOBbSUjDyA@mail.gmail.com>
References: <CACVXFVPjo2dQpYPpqZS8GC8UPNzB5HLURpYm6-g1FOBbSUjDyA@mail.gmail.com>
Message-ID: <20130517085530.GB22992@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 03:16:40AM +0100, Ming Lei wrote:
> Hi,

Hello,

> The commit a43cb95d5(dump_stack: unify debug information printed by show_regs())
> caused ARM perf regression, then 'perf top' outputs mistakenly, see
> [1].  The correct
> output should be [2], which can be got after reverting the commit or
> doing it partly
> by the one line change below:
> 
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index f219703..89bc3a4 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -225,7 +225,7 @@ void __show_regs(struct pt_regs *regs)
>         unsigned long flags;
>         char buf[64];
> 
> -       show_regs_print_info(KERN_DEFAULT);
> +       //show_regs_print_info(KERN_DEFAULT);
> 
> 
> Looks a bit weird, anyone can give a hint?

So it's still the morning and I haven't had my coffee yet, but I'm really
struggling to see what you're getting at. Why does this have anything to do
with perf?

> [1], 'perf top' mistaken output
> Samples: 17K of event 'cpu-clock', Event count (approx.): 3516532661
>  97.51%  [smsc95xx]            [k] 0x013645b8
>   0.21%  libc-2.15.so          [.] strstr
>   0.14%  libc-2.15.so          [.] strchr
>   0.12%  libc-2.15.so          [.] strcmp

[...]

> [2], 'perf top' correct output
> Samples: 46K of event 'cpu-clock', Event count (approx.): 937128704
>  96.44%  [kernel]            [k] cpuidle_enter_state
>   0.19%  libc-2.15.so        [.] strstr
>   0.16%  [kernel]            [k] kallsyms_expand_symbol.clone.0
>   0.13%  [kernel]            [k] _raw_spin_unlock_irq

[...]

Are you saying that the profile you're seeing is radically different,
rather than there being some formatting error that I can't spot? If so, that
sounds really strange and I can't see how the patch you mention is to
blame...

If we want to persue this, I guess other obvious questions are: which kernel
are you running? Does this affect multiple architectures (your diff only
changes ARM)? What's the workload which you are profiling?

Will
