From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 7 Mar 2017 10:22:31 +0100
Subject: [PATCH] block: systemace: Fix refcount underflow in error handler
In-Reply-To: <1488756960-3659-1-git-send-email-linux@roeck-us.net>
References: <1488756960-3659-1-git-send-email-linux@roeck-us.net>
Message-ID: <17da5bdf-614a-6846-1cb9-94adcf1b2c93@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6.3.2017 00:36, Guenter Roeck wrote:
> Since commit 29dee3c03abc ("locking/refcounts: Out-of-line everything"),
> the following runtime warning is seen if xsysace fails to initialize.
> The commit only exposes the problem.
> 
> refcount_t: underflow; use-after-free.
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at lib/refcount.c:128 refcount_sub_and_test+0x90/0xd0
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper Not tainted 4.11.0-rc1+ #1
> task: cf81d5a0 task.stack: cf81e000
> NIP: c02104d0 LR: c02104d0 CTR: c0279d90
> REGS: cf81fc80 TRAP: 0700   Not tainted  (4.11.0-rc1+)
> MSR: 00029000 <CE,EE,ME>
> CR: 24000022  XER: 00000000
> 
> GPR00: c02104d0 cf81fd30 cf81d5a0 00000026 00000000 00000000 c027a7f0 00000000
> GPR08: c05412dc 00000800 00000000 00000000 24000024 00000000 c0001ad0 00000000
> GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 c054b3c0 c0550000
> GPR24: 00000000 00000001 cf95a010 00000015 00000000 00000000 cfb2b2c0 cfb2b0e8
> NIP [c02104d0] refcount_sub_and_test+0x90/0xd0
> LR [c02104d0] refcount_sub_and_test+0x90/0xd0
> Call Trace:
> [cf81fd30] [c02104d0] refcount_sub_and_test+0x90/0xd0 (unreliable)
> [cf81fd40] [c01f68c4] kobject_put+0x34/0x90
> [cf81fd50] [c01cef64] blk_cleanup_queue+0x164/0x1e0
> [cf81fd60] [c02acab0] ace_probe+0x4c0/0x510
> [cf81fda0] [c0293b64] platform_drv_probe+0x44/0xc0
> [cf81fdc0] [c0291974] driver_probe_device+0x234/0x340
> [cf81fdf0] [c0291b4c] __driver_attach+0xcc/0xd0
> [cf81fe10] [c028f4d8] bus_for_each_dev+0x68/0xc0
> [cf81fe40] [c0290d18] bus_add_driver+0x208/0x280
> [cf81fe60] [c0292678] driver_register+0x88/0x140
> [cf81fe70] [c050ce24] ace_init+0x48/0xa4
> [cf81fe90] [c0001350] do_one_initcall+0x40/0x180
> [cf81fef0] [c04f3ae0] kernel_init_freeable+0x134/0x1d0
> [cf81ff30] [c0001ae4] kernel_init+0x14/0x110
> [cf81ff40] [c000c3d0] ret_from_kernel_thread+0x5c/0x64
> 
> Debugging shows that blk_put_queue() is called twice during error
> handling, once from disk_release() (called from put_disk) and once
> from blk_cleanup_queue(). disk_release() only calls blk_put_queue()
> if the queue pointer is initialized, so moving the initialization of
> gd->queue avoids the problem.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/block/xsysace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
> index 757dce2147e0..a22b38968930 100644
> --- a/drivers/block/xsysace.c
> +++ b/drivers/block/xsysace.c
> @@ -1004,7 +1004,6 @@ static int ace_setup(struct ace_device *ace)
>  	ace->gd->major = ace_major;
>  	ace->gd->first_minor = ace->id * ACE_NUM_MINORS;
>  	ace->gd->fops = &ace_fops;
> -	ace->gd->queue = ace->queue;
>  	ace->gd->private_data = ace;
>  	snprintf(ace->gd->disk_name, 32, "xs%c", ace->id + 'a');
>  
> @@ -1032,6 +1031,8 @@ static int ace_setup(struct ace_device *ace)
>  	ace_out(ace, ACE_CTRL, ACE_CTRL_FORCECFGMODE |
>  		ACE_CTRL_DATABUFRDYIRQ | ACE_CTRL_ERRORIRQ);
>  
> +	ace->gd->queue = ace->queue;
> +
>  	/* Now we can hook up the irq handler */
>  	if (ace->irq) {
>  		rc = request_irq(ace->irq, ace_interrupt, 0, "systemace", ace);
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
