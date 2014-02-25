From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 25 Feb 2014 10:00:08 +0000
Subject: [PATCH v2] arm/arm64: KVM: detect CPU reset on CPU_PM_EXIT
In-Reply-To: <20140221171216.GA22447@cbox>
References: <1392983216-368-1-git-send-email-marc.zyngier@arm.com>
 <20140221171216.GA22447@cbox>
Message-ID: <530C69A8.20800@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/02/14 17:12, Christoffer Dall wrote:
> On Fri, Feb 21, 2014 at 11:46:56AM +0000, Marc Zyngier wrote:
>> Commit 1fcf7ce0c602 (arm: kvm: implement CPU PM notifier) added
>> support for CPU power-management, using a cpu_notifier to re-init
>> KVM on a CPU that entered CPU idle.
>>
>> The code assumed that a CPU entering idle would actually be powered
>> off, loosing its state entierely, and would then need to be
>> reinitialized. It turns out that this is not always the case, and
>> some HW performs CPU PM without actually killing the core. In this
>> case, we try to reinitialize KVM while it is still live. It ends up
>> badly, as reported by Andre Przywara (using a Calxeda Midway):
>>
>> [    3.663897] Kernel panic - not syncing: unexpected prefetch abort in Hyp mode at: 0x685760
>> [    3.663897] unexpected data abort in Hyp mode at: 0xc067d150
>> [    3.663897] unexpected HVC/SVC trap in Hyp mode at: 0xc0901dd0
>>
>> The trick here is to detect if we've been through a full re-init or
>> not by looking at HVBAR (VBAR_EL2 on arm64). This involves
>> implementing the backend for __hyp_get_vectors in the main KVM HYP
>> code (rather small), and checking the return value against the
>> default one when the CPU notifier is called on CPU_PM_EXIT.
>>
>> Reported-by: Andre Przywara <osp@andrep.de>
>> Tested-by: Andre Przywara <osp@andrep.de>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Rob Herring <rob.herring@linaro.org>
>> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Thanks!
> 
> Looks good.

Thanks. I'm thinking of pushing this to 3.14 as a fix. Any objection?

	M.
-- 
Jazz is not dead. It just smells funny...
