From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 26 Aug 2014 10:42:44 -0700
Subject: [PATCH v2 01/26] genirq: add irq_domain-aware core IRQ handler
In-Reply-To: <1409047421-27649-2-git-send-email-marc.zyngier@arm.com>
References: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
 <1409047421-27649-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <53FCC714.3090206@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/26/14 03:03, Marc Zyngier wrote:
> Calling irq_find_mapping from outside a irq_{enter,exit} section is
> unsafe and produces ugly messages if CONFIG_PROVE_RCU is enabled:
> If coming from the idle state, the rcu_read_lock call in irq_find_mapping
> will generate an unpleasant warning:
>
> <quote>
> ===============================
> [ INFO: suspicious RCU usage. ]
> 3.16.0-rc1+ #135 Not tainted
> -------------------------------
> include/linux/rcupdate.h:871 rcu_read_lock() used illegally while idle!
>
> other info that might help us debug this:
>
> RCU used illegally from idle CPU!
> rcu_scheduler_active = 1, debug_locks = 0
> RCU used illegally from extended quiescent state!
> 1 lock held by swapper/0/0:
>  #0:  (rcu_read_lock){......}, at: [<ffffffc00010206c>]
> irq_find_mapping+0x4c/0x198

Do you have the whole stacktrace? I don't see where this is called
outside of irq_enter() from within the idle loop, but maybe I missed
something.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
