From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 6 Jul 2018 12:34:21 +0100
Subject: [PATCH v2] power: vexpress: fix corruption in notifier
 registration
In-Reply-To: <1529337272-11799-1-git-send-email-sudeep.holla@arm.com>
References: <1529322007-4637-1-git-send-email-sudeep.holla@arm.com>
 <1529337272-11799-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <377ad2bb-b620-f6cc-6f0b-8d4d304dac55@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/06/18 16:54, Sudeep Holla wrote:
> Vexpress platforms provide two different restart handlers: SYS_REBOOT
> that restart the entire system, while DB_RESET only restarts the
> daughter board containing the CPU. DB_RESET is overridden by SYS_REBOOT
> if it exists.
> 
> notifier_chain_register used in register_restart_handler by design
> relies on notifiers to be registered once only, however vexpress restart
> notifier can get registered twice. When this happen it corrupts list
> of notifiers, as result some notifiers can be not called on proper
> event, traverse on list can be cycled forever, and second unregister
> can access already freed memory.
> 
> So far, since this was the only restart handler in the system, no issue
> was observed even if the same notifier was registered twice. However
> commit 6c5c0d48b686 ("watchdog: sp805: add restart handler") added
> support for SP805 restart handlers and since the system under test
> contains two vexpress restart and two SP805 watchdog instances, it was
> observed that during the boot traversing the restart handler list looped
> forever as there's a cycle in that list resulting in boot hang.
> 
> This patch fixes the issues by ensuring that the notifier is installed
> only once.
> 
> Cc: Sebastian Reichel <sre@kernel.org>


Gentle Ping ! This needs to go as fix as my platform(TC2) fails to boot
without this.

-- 
Regards,
Sudeep
