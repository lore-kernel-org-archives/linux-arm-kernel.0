From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 31 Jan 2018 00:13:19 -0200
Subject: [PATCH v3 2/6] arm: Invalidate BTB on prefetch abort outside of
 user mapping on Cortex A8, A9, A12 and A17
In-Reply-To: <20180125152139.32431-3-marc.zyngier@arm.com>
References: <20180125152139.32431-1-marc.zyngier@arm.com>
 <20180125152139.32431-3-marc.zyngier@arm.com>
Message-ID: <CAOMZO5BztwQy7AzQ75YRQYGK-=6+aCGTX8BH=kXBKcZCp5e6-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Thu, Jan 25, 2018 at 1:21 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:

> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -21,6 +21,7 @@
>  #include <linux/highmem.h>
>  #include <linux/perf_event.h>
>
> +#include <asm/cp15.h>
>  #include <asm/exception.h>
>  #include <asm/pgtable.h>
>  #include <asm/system_misc.h>
> @@ -181,6 +182,7 @@ __do_user_fault(struct task_struct *tsk, unsigned long addr,
>         si.si_errno = 0;
>         si.si_code = code;
>         si.si_addr = (void __user *)addr;
> +

Unneeded blank line.

>         force_sig_info(sig, &si, tsk);
>  }
>
> @@ -396,12 +398,35 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>         __do_kernel_fault(mm, addr, fsr, regs);
>         return 0;
>  }
> +
> +static int
> +do_pabt_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
> +{
> +       if (addr > TASK_SIZE) {
> +               switch(read_cpuid_part()) {

checkpatch complains here:

ERROR: space required before the open parenthesis '('
#62: FILE: arch/arm/mm/fault.c:406:
+        switch(read_cpuid_part()) {
