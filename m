From: will.deacon@arm.com (Will Deacon)
Date: Tue, 2 Oct 2012 20:18:51 +0100
Subject: [RFC PATCH 1/2] ARM: use generic strnlen_user and
 strncpy_from_user functions
In-Reply-To: <20121002175316.GA598@pengutronix.de>
References: <1339169935-31775-1-git-send-email-will.deacon@arm.com>
 <1339169935-31775-2-git-send-email-will.deacon@arm.com>
 <20121002175316.GA598@pengutronix.de>
Message-ID: <20121002191851.GB20411@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 02, 2012 at 06:53:16PM +0100, Uwe Kleine-K?nig wrote:
> Hello,

Hi Uwe,

> On Fri, Jun 08, 2012 at 04:38:54PM +0100, Will Deacon wrote:
> > This patch implements the word-at-a-time interface for ARM using the
> > same algorithm as x86. Although we have a clz instruction from ARMv5,
> > this only saves us one mov instruction when building with Thumb-2 and
> > makes no difference when targetting ARM, so we use the magic 0x0ff0001
> > constant for all CPUs. For big-endian configurations, we use the
> > implementation from asm-generic.
> > 
> > With this implemented, we can replace our byte-at-a-time strnlen_user
> > and strncpy_from_user functions with the optimised generic versions.
> This patch is in Linus tree as 8c56cc8be5b38e3684eba96dc9b3f7ca7e495755
> now and it broke my booting my Cortex-M3 machine. I didn't debug that
> yet, but wanted to let you know already now before I call it a day.

Ok, thanks for the heads-up. I didn't test it with an M-class CPU, but
hopefully that's understandable :)

> > +#define user_addr_max() \
> > +	(segment_eq(get_fs(), USER_DS) ? TASK_SIZE : ~0UL)
> > +
> I think this is the problem as for no-mmu USER_DS == KERNEL_DS. I will
> take a look tomorrow.

I can't immediately see why that would cause a problem, so please let me
know if you get more information.

Will
