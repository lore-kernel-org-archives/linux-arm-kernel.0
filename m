From: balbi@ti.com (Felipe Balbi)
Date: Wed, 3 Jun 2015 16:04:55 -0500
Subject: [RFC/NOT FOR MERGING] HACK: add global/private timers for A9
In-Reply-To: <2466648.WjMxjIpAUG@wuerfel>
References: <1433363565-17725-1-git-send-email-balbi@ti.com>
 <2466648.WjMxjIpAUG@wuerfel>
Message-ID: <20150603210455.GD6042@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 03, 2015 at 10:55:27PM +0200, Arnd Bergmann wrote:
> On Wednesday 03 June 2015 15:32:45 Felipe Balbi wrote:
> > 
> > Hi Tony and Russell,
> > 
> > AM43xx, even though it's a single processor A9, it still has TWD and global
> > timer. I was doing some profiling with RT v4.0 and latency is 3.5x lower just
> > by switching from gptimer to twd/global.
> > 
> > The only problem is that currently, is_smp() check prevents me from using twd
> > with AM43xx (that's why it's commented below, for testing purposes).
> > 
> > In the hopes that we can start a, hopefully, small thread around the subject,
> > I'm sending this HACK which I used to get TWD and global timer enabled so I
> > could measure latencies with cyclictest.
> > 
> > Is it so that TWD shouldn't be available on UP integrations of ARM's Cortex-A
> > processors ?
> > 
> > 
> 
> I wondered about this recently when looking at something unrelated
> and noticed that the check had been introduced as part of
> 904464b91eca8 ("ARM: 7655/1: smp_twd: make twd_local_timer_of_register()
> no-op for nosmp").
> 
> I suspect this was just the wrong fix at the time, and that the
> real culprit is either alloc_percpu() or request_percpu_irq()
> getting called too early on a machine without SMP support.
> 
> Possibly the problem is already resolved independently, if you
> didn't run into it.

no, no splats, nothing at all. See [1]

[1] http://hastebin.com/helekubutu

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150603/758e7b2f/attachment.sig>
