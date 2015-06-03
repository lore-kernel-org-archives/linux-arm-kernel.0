From: balbi@ti.com (Felipe Balbi)
Date: Wed, 3 Jun 2015 16:54:45 -0500
Subject: [RFC/NOT FOR MERGING] HACK: add global/private timers for A9
In-Reply-To: <556F7493.2060602@codeaurora.org>
References: <1433363565-17725-1-git-send-email-balbi@ti.com>
 <2466648.WjMxjIpAUG@wuerfel>
 <20150603210455.GD6042@saruman.tx.rr.com>
 <20150603212821.GH6042@saruman.tx.rr.com>
 <556F7493.2060602@codeaurora.org>
Message-ID: <20150603215445.GK6042@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 03, 2015 at 02:41:39PM -0700, Stephen Boyd wrote:
> >>>>AM43xx, even though it's a single processor A9, it still has TWD and global
> >>>>timer. I was doing some profiling with RT v4.0 and latency is 3.5x lower just
> >>>>by switching from gptimer to twd/global.
> >>>>
> >>>>The only problem is that currently, is_smp() check prevents me from using twd
> >>>>with AM43xx (that's why it's commented below, for testing purposes).
> >>>>
> >>>>In the hopes that we can start a, hopefully, small thread around the subject,
> >>>>I'm sending this HACK which I used to get TWD and global timer enabled so I
> >>>>could measure latencies with cyclictest.
> >>>>
> >>>>Is it so that TWD shouldn't be available on UP integrations of ARM's Cortex-A
> >>>>processors ?
> >>>>
> >>>>
> >>>I wondered about this recently when looking at something unrelated
> >>>and noticed that the check had been introduced as part of
> >>>904464b91eca8 ("ARM: 7655/1: smp_twd: make twd_local_timer_of_register()
> >>>no-op for nosmp").
> >>>
> >>>I suspect this was just the wrong fix at the time, and that the
> >>>real culprit is either alloc_percpu() or request_percpu_irq()
> >>>getting called too early on a machine without SMP support.
> >>>
> >>>Possibly the problem is already resolved independently, if you
> >>>didn't run into it.
> >>no, no splats, nothing at all. See [1]
> >>
> >>[1] http://hastebin.com/helekubutu
> >Adding Shawn
> >
> 
> Mason was also interested in doing this. See [2]. From what I could tell
> back then, commit 904464b91eca8 was working around the local timer APIs that
> no longer exist.
> 
> [2] http://thread.gmane.org/gmane.linux.ports.arm.kernel/389931/focus=392348

A lot of good information on that thread, thanks. Seems like getting
twd/global timer working would also have some effect on context
switching, perhaps ?

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150603/c65b9710/attachment.sig>
