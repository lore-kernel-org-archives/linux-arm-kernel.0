From: will.deacon@arm.com (Will Deacon)
Date: Tue, 4 Jul 2017 18:17:47 +0100
Subject: [PATCH] arm64: traps: disable irq in die()
In-Reply-To: <1498640652-23338-2-git-send-email-qiaozhou@asrmicro.com>
References: <1498640652-23338-2-git-send-email-qiaozhou@asrmicro.com>
Message-ID: <20170704171746.GM22175@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 28, 2017 at 05:04:12PM +0800, Qiao Zhou wrote:
> In current die(), the irq is disabled for __die() handle, not
> including the possible panic() handling. Since the log in __die()
> can take several hundreds ms, new irq might come and interrupt
> current die().
> 
> If the process calling die() holds some critical resource, and some
> other process scheduled later also needs it, then it would deadlock.
> The first panic will not be executed.
> 
> So here disable irq for the whole flow of die().

Could you give an example of this going wrong, please?

> 
> Signed-off-by: Qiao Zhou <qiaozhou@asrmicro.com>
> ---
>  arch/arm64/kernel/traps.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 0805b44..b12bf0f 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -274,10 +274,13 @@ static DEFINE_RAW_SPINLOCK(die_lock);
>  void die(const char *str, struct pt_regs *regs, int err)
>  {
>  	int ret;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
>  
>  	oops_enter();
>  
> -	raw_spin_lock_irq(&die_lock);
> +	raw_spin_lock(&die_lock);

Can we instead move the taking of the die_lock before oops_enter, or does
that break something else?

>  	console_verbose();
>  	bust_spinlocks(1);
>  	ret = __die(str, err, regs);
> @@ -287,13 +290,16 @@ void die(const char *str, struct pt_regs *regs, int err)
>  
>  	bust_spinlocks(0);
>  	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
> -	raw_spin_unlock_irq(&die_lock);
> +	raw_spin_unlock(&die_lock);
>  	oops_exit();
>  
>  	if (in_interrupt())
>  		panic("Fatal exception in interrupt");
>  	if (panic_on_oops)
>  		panic("Fatal exception");
> +
> +	local_irq_restore(flags);

We could also move the unlock_irq down here.

Will
