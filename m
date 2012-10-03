From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 3 Oct 2012 08:00:42 +0200
Subject: [RFC PATCH 1/2] ARM: use generic strnlen_user and
 strncpy_from_user functions
In-Reply-To: <20121002191851.GB20411@mudshark.cambridge.arm.com>
References: <1339169935-31775-1-git-send-email-will.deacon@arm.com>
 <1339169935-31775-2-git-send-email-will.deacon@arm.com>
 <20121002175316.GA598@pengutronix.de>
 <20121002191851.GB20411@mudshark.cambridge.arm.com>
Message-ID: <20121003060042.GB598@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Tue, Oct 02, 2012 at 08:18:51PM +0100, Will Deacon wrote:
> On Tue, Oct 02, 2012 at 06:53:16PM +0100, Uwe Kleine-K?nig wrote:
> > On Fri, Jun 08, 2012 at 04:38:54PM +0100, Will Deacon wrote:
> > > This patch implements the word-at-a-time interface for ARM using the
> > > same algorithm as x86. Although we have a clz instruction from ARMv5,
> > > this only saves us one mov instruction when building with Thumb-2 and
> > > makes no difference when targetting ARM, so we use the magic 0x0ff0001
> > > constant for all CPUs. For big-endian configurations, we use the
> > > implementation from asm-generic.
> > > 
> > > With this implemented, we can replace our byte-at-a-time strnlen_user
> > > and strncpy_from_user functions with the optimised generic versions.
> > This patch is in Linus tree as 8c56cc8be5b38e3684eba96dc9b3f7ca7e495755
> > now and it broke my booting my Cortex-M3 machine. I didn't debug that
> > yet, but wanted to let you know already now before I call it a day.
> 
> Ok, thanks for the heads-up. I didn't test it with an M-class CPU, but
> hopefully that's understandable :)
I think so, yes. But I intend to change that, and I heard your coworker
gets an efm32 :-)

> > > +#define user_addr_max() \
> > > +	(segment_eq(get_fs(), USER_DS) ? TASK_SIZE : ~0UL)
> > > +
> > I think this is the problem as for no-mmu USER_DS == KERNEL_DS. I will
> > take a look tomorrow.
> 
> I can't immediately see why that would cause a problem, so please let me
> know if you get more information.
BTW, I once saw the call to sys_mount fail:

	sys_mount ->
	copy_mount_string ->
	strndup_user ->
	strnlen_user returns 0 which makes sys_mount fail with -EFAULT.

but that was not the problem I hit when I bisected (using merges instead
of rebasing).

We have a bank holiday today in Germany, so it's still tomorrow when I
will look into the problem. So I hope to be able to give more details
soon.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
