From: tony@atomide.com (Tony Lindgren)
Date: Tue, 12 Mar 2013 09:34:22 -0700
Subject: IS_ERR_VALUE()
In-Reply-To: <20130312141604.GV4977@n2100.arm.linux.org.uk>
References: <20130312141604.GV4977@n2100.arm.linux.org.uk>
Message-ID: <20130312163422.GY26093@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [130312 07:25]:
> I am removing almost all references to the above macro from arch/arm.
> Many of them are wrong.  Some of them are buggy.
> 
> For instance:
> 
> int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
> {
>         int div;
>         div = gpmc_calc_divider(t->sync_clk);
>         if (div < 0)
>                 return div;
> static int gpmc_set_async_mode(int cs, struct gpmc_timings *t)
> {
> ...
>         return gpmc_cs_set_timings(cs, t);
> 
> .....
>         ret = gpmc_set_async_mode(gpmc_onenand_data->cs, &t);
>         if (IS_ERR_VALUE(ret))
>                 return ret;
> 
> So, gpmc_cs_set_timings() thinks any negative return value is an error,
> but where we check that in higher levels, only a limited range are
> errors... seriously?  Come on guys, get with the program.  Get your
> error checking in order.
> 
> There is only _one_ use of IS_ERR_VALUE() in arch/arm which is correct,
> and that is in arch/arm/include/asm/syscall.h:
> 
> static inline long syscall_get_error(struct task_struct *task,
>                                      struct pt_regs *regs)
> {
>         unsigned long error = regs->ARM_r0;
>         return IS_ERR_VALUE(error) ? error : 0;
> }
> 
> So, here's a patch to remove them all, except for the above.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> This patch will be going into my "cleanup" branch along with the removal
> of many wrong IS_ERR_OR_NULL() uses - with any errors anyone spots fixed.

Looks good to me. Can you please also let us know some immutable
commit for your cleanup branch? I'd like to use that as a base
to pull in further GPMC changes to avoid unnecessary merge conflicts.

Acked-by: Tony Lindgren <tony@atomide.com>
