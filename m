From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Aug 2014 19:07:03 +0100
Subject: [PATCH v2 01/26] genirq: add irq_domain-aware core IRQ handler
In-Reply-To: <53FCC714.3090206@codeaurora.org>
References: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
 <1409047421-27649-2-git-send-email-marc.zyngier@arm.com>
 <53FCC714.3090206@codeaurora.org>
Message-ID: <53FCCCC7.9070801@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/08/14 18:42, Stephen Boyd wrote:
> On 08/26/14 03:03, Marc Zyngier wrote:
>> Calling irq_find_mapping from outside a irq_{enter,exit} section is
>> unsafe and produces ugly messages if CONFIG_PROVE_RCU is enabled:
>> If coming from the idle state, the rcu_read_lock call in irq_find_mapping
>> will generate an unpleasant warning:
>>
>> <quote>
>> ===============================
>> [ INFO: suspicious RCU usage. ]
>> 3.16.0-rc1+ #135 Not tainted
>> -------------------------------
>> include/linux/rcupdate.h:871 rcu_read_lock() used illegally while idle!
>>
>> other info that might help us debug this:
>>
>> RCU used illegally from idle CPU!
>> rcu_scheduler_active = 1, debug_locks = 0
>> RCU used illegally from extended quiescent state!
>> 1 lock held by swapper/0/0:
>>  #0:  (rcu_read_lock){......}, at: [<ffffffc00010206c>]
>> irq_find_mapping+0x4c/0x198
> 
> Do you have the whole stacktrace? I don't see where this is called
> outside of irq_enter() from within the idle loop, but maybe I missed
> something.
> 

Hi Stephen,

Digging into my email, one of the traces looked like this:

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.16.0-rc1+ #135
Call trace:
[<ffffffc0000882cc>] dump_backtrace+0x0/0x12c
[<ffffffc000088408>] show_stack+0x10/0x1c
[<ffffffc0004ee5f0>] dump_stack+0x74/0xc4
[<ffffffc0000edfbc>] lockdep_rcu_suspicious+0xe8/0x124
[<ffffffc00010218c>] irq_find_mapping+0x16c/0x198
[<ffffffc00008130c>] gic_handle_irq+0x38/0xcc

Most drivers call irq_find_mapping outside of irq_enter()/irq_exit(), as
this is in handle_IRQ().

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
