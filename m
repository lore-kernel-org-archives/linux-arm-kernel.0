From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 2 Oct 2012 19:53:16 +0200
Subject: [RFC PATCH 1/2] ARM: use generic strnlen_user and
 strncpy_from_user functions
In-Reply-To: <1339169935-31775-2-git-send-email-will.deacon@arm.com>
References: <1339169935-31775-1-git-send-email-will.deacon@arm.com>
 <1339169935-31775-2-git-send-email-will.deacon@arm.com>
Message-ID: <20121002175316.GA598@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Jun 08, 2012 at 04:38:54PM +0100, Will Deacon wrote:
> This patch implements the word-at-a-time interface for ARM using the
> same algorithm as x86. Although we have a clz instruction from ARMv5,
> this only saves us one mov instruction when building with Thumb-2 and
> makes no difference when targetting ARM, so we use the magic 0x0ff0001
> constant for all CPUs. For big-endian configurations, we use the
> implementation from asm-generic.
> 
> With this implemented, we can replace our byte-at-a-time strnlen_user
> and strncpy_from_user functions with the optimised generic versions.
This patch is in Linus tree as 8c56cc8be5b38e3684eba96dc9b3f7ca7e495755
now and it broke my booting my Cortex-M3 machine. I didn't debug that
yet, but wanted to let you know already now before I call it a day.

> +#define user_addr_max() \
> +	(segment_eq(get_fs(), USER_DS) ? TASK_SIZE : ~0UL)
> +
I think this is the problem as for no-mmu USER_DS == KERNEL_DS. I will
take a look tomorrow.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
