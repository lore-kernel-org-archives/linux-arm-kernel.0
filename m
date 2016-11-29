From: ghorbel@gmail.com (Oussama Ghorbel)
Date: Wed, 30 Nov 2016 00:13:30 +0100
Subject: [PATCH] arm: add stat support to fiq
In-Reply-To: <1480459715-19496-1-git-send-email-ghorbel@gmail.com>
References: <1480459715-19496-1-git-send-email-ghorbel@gmail.com>
Message-ID: <CAChrKvQHtwYKH+E-WZ4s2SZfvzBtLaP-TyiY8e8fjFZRUPUn0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch has been tested on the raspberry pi 2/3 boards with 4.6.y kernel.
Another patch written for dwc_otg driver (not in mainline)  that uses the
features provided by this patch. it's available here
https://www.osadl.org/monitoring/patches/r7s3s/0002-usb-dwc_otg-enable-fiq-stat.patch
To see both patches in action, you may viewed it on OSALD QA Farm here:
https://www.osadl.org/Profile-of-system-in-rack-7-slot-3.qa-profile-r7s3.0.html?shadow=1

Oussama

On Tue, Nov 29, 2016 at 11:48 PM, Oussama Ghorbel <ghorbel@gmail.com> wrote:
> This patch allows drivers that uses fiq to have a stat on the
> execution number of the fiq handler.
> For that three APIs has been defined:
> - fiq_kstat_enable: this function enables fiq stat and allocates required
> memory for it
> - fiq_kstat_disable: this function disable fiq stat and free its allocated
> memory
> - fiq_kstat_this_cpu_inc: This function increments the fiq stat counter of
> the current CPU running the fiq handler
>
> A driver may call fiq_kstat_enable at its initialization to enable fiq
> stat and then call fiq_kstat_this_cpu_inc from the fiq handler
>
> When the fiq stat is enabled by a driver, then /proc/interrupts shows the
> fiq entry as the following example:
> FIQ:          0   21642080          0          0  usb_fiq
> If the fiq stat is not enabled, the content will be similar to the old one
> as the following example:
> FIQ:                                              usb_fiq
> The fiq name will be always written on the first column after the last CPU
> column
>
> Signed-off-by: Oussama Ghorbel <ghorbel@gmail.com>
> ---
>  arch/arm/include/asm/fiq.h | 10 ++++++++++
>  arch/arm/kernel/fiq.c      | 31 +++++++++++++++++++++++++++----
>  2 files changed, 37 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/include/asm/fiq.h b/arch/arm/include/asm/fiq.h
> index d493d0b..77f819b 100644
> --- a/arch/arm/include/asm/fiq.h
> +++ b/arch/arm/include/asm/fiq.h
> @@ -31,6 +31,8 @@ struct fiq_handler {
>         /* data for the relinquish/reacquire functions
>          */
>         void *dev_id;
> +       /* fiq stats percpu */
> +       unsigned int __percpu *fiq_kstat;
>  };
>
>  extern int claim_fiq(struct fiq_handler *f);
> @@ -53,4 +55,12 @@ static inline void get_fiq_regs(struct pt_regs *regs)
>         __get_fiq_regs(&regs->ARM_r8);
>  }
>
> +extern int fiq_kstat_enable(struct fiq_handler *fh);
> +extern void fiq_kstat_disable(struct fiq_handler *fh);
> +
> +static inline void fiq_kstat_this_cpu_inc(struct fiq_handler *fh)
> +{
> +       __this_cpu_inc(*fh->fiq_kstat);
> +}
> +
>  #endif
> diff --git a/arch/arm/kernel/fiq.c b/arch/arm/kernel/fiq.c
> index 059c3da..4b606df 100644
> --- a/arch/arm/kernel/fiq.c
> +++ b/arch/arm/kernel/fiq.c
> @@ -83,10 +83,19 @@ static struct fiq_handler *current_fiq = &default_owner;
>
>  int show_fiq_list(struct seq_file *p, int prec)
>  {
> -       if (current_fiq != &default_owner)
> -               seq_printf(p, "%*s:              %s\n", prec, "FIQ",
> -                       current_fiq->name);
> -
> +       int j;
> +
> +       if (current_fiq == &default_owner)
> +               return 0;
> +       seq_printf(p, "%*s: ", prec, "FIQ");
> +       for_each_online_cpu(j) {
> +               if (current_fiq->fiq_kstat)
> +                       seq_printf(p, "%10u ",
> +                               *per_cpu_ptr(current_fiq->fiq_kstat, j));
> +               else
> +                       seq_printf(p, "%10s ", "");
> +       }
> +       seq_printf(p, " %s\n", current_fiq->name);
>         return 0;
>  }
>
> @@ -162,3 +171,17 @@ void __init init_FIQ(int start)
>         get_fiq_regs(&dfl_fiq_regs);
>         fiq_start = start;
>  }
> +
> +int fiq_kstat_enable(struct fiq_handler *fh)
> +{
> +       fh->fiq_kstat = alloc_percpu(unsigned int);
> +       return fh->fiq_kstat != 0 ? 0 : 1;
> +}
> +EXPORT_SYMBOL(fiq_kstat_enable);
> +
> +void fiq_kstat_disable(struct fiq_handler *fh)
> +{
> +       free_percpu(fh->fiq_kstat);
> +       fh->fiq_kstat = NULL;
> +}
> +EXPORT_SYMBOL(fiq_kstat_disable);
> --
> 2.7.4
>
