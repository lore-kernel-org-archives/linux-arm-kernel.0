From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Jan 2014 15:57:42 +0000
Subject: 'unannotated irqs-on' lockdep warning
In-Reply-To: <CAH9NwWcVrjV1=rFnHJhDH0yoEkTwUTcq-Tn=R0aaiTr70Fs3hA@mail.gmail.com>
References: <CAH9NwWcVrjV1=rFnHJhDH0yoEkTwUTcq-Tn=R0aaiTr70Fs3hA@mail.gmail.com>
Message-ID: <20140130155741.GB15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 03:31:46PM +0100, Christian Gmeiner wrote:
> [   19.859234] CPU: 0 PID: 1848 Comm: mkdir Not tainted 3.12.4 #44
> [   19.865190] [<c0013900>] (unwind_backtrace+0x0/0xe0) from
> [<c00113b8>] (show_stack+0x10/0x14)
> [   19.873739] [<c00113b8>] (show_stack+0x10/0x14) from [<c044e040>]
> (dump_stack+0x64/0xa4)
> [   19.881851] [<c044e040>] (dump_stack+0x64/0xa4) from [<c0022718>]
> (warn_slowpath_common+0x64/0x84)
> [   19.890828] [<c0022718>] (warn_slowpath_common+0x64/0x84) from
> [<c00227b8>] (warn_slowpath_fmt+0x2c/0x3c)
> [   19.900413] [<c00227b8>] (warn_slowpath_fmt+0x2c/0x3c) from
> [<c0076c84>] (check_flags.part.26+0xb4/0x1e4)
> [   19.910001] [<c0076c84>] (check_flags.part.26+0xb4/0x1e4) from
> [<c0079654>] (lock_release+0x3c/0x100)
> [   19.919243] [<c0079654>] (lock_release+0x3c/0x100) from
> [<c00485b4>] (lg_local_unlock+0x18/0x6c)
> [   19.928055] [<c00485b4>] (lg_local_unlock+0x18/0x6c) from
> [<c012a2cc>] (free_fs_struct+0x18/0x30)
> [   19.936947] [<c012a2cc>] (free_fs_struct+0x18/0x30) from
> [<c0024e24>] (do_exit+0x2ac/0x3f0)
> [   19.945316] [<c0024e24>] (do_exit+0x2ac/0x3f0) from [<c002501c>]
> (do_group_exit+0x88/0xb4)
> [   19.953596] [<c002501c>] (do_group_exit+0x88/0xb4) from
> [<c0025058>] (__wake_up_parent+0x0/0x18)
> [   19.962391] ---[ end trace 98a70b5cdc7b49fe ]---
> [   19.967017] possible reason: unannotated irqs-on.
> [   19.971729] irq event stamp: 2910
> [   19.975050] hardirqs last  enabled at (2909): [<c044a160>]
> __slab_free+0x1c0/0x390
> [   19.982661] hardirqs last disabled at (2910): [<c0456d14>]
> __dabt_svc+0x34/0x60

So, I wonder how we got from __dabt_svc to __wake_up_parent.  It looks
like the unwinder has failed to do a proper job of unwinding, which
makes this undebuggable.

Can you rebuild in ARM mode with frame pointers enabled please?

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
