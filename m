From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 27 Mar 2015 15:37:04 +0000
Subject: [RFC v2 0/5] arm64: kvm: reset hyp context for kexec
In-Reply-To: <20150327153131.GK12400@redacted.bos.redhat.com>
References: <1427358326-3708-1-git-send-email-takahiro.akashi@linaro.org>
 <20150327153131.GK12400@redacted.bos.redhat.com>
Message-ID: <55157920.3050003@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/03/15 15:31, Kyle McMartin wrote:
> On Thu, Mar 26, 2015 at 05:25:21PM +0900, AKASHI Takahiro wrote:
>> 1) Call kvm_cpu_reset() on non-boot cpus in reboot notifier
>>    We don't have to do so in kexec-specific case. But the current code runs
>>    the function on each cpu for safety since we use a general reboot hook.
>> 2) Flush D$ in kvm_cpu_reset()
>>    Currently doesn't do so because all the cpus are just going to shut down,
>>    and we actually flush D$ on boot cpu in Geoff's cpu_reset().
>> 3) Compatibility with arm implementation
>>    Frediano[2] is no longer working on this issue on arm as he left his
>>    company. But my approach here is based on a generic interface and can be
>>    applied to arm in a similar way.
>>
> 
> i'm hitting this when rebooting with your patchset applied...
> 
> Rebooting.
> [  236.260863] Kernel panic - not syncing: HYP panic:
> [  236.260863] PS:600003c9 PC:000003ffffff0830 ESR:0000000096000006

It would be interesting if you could find out what you have at offset
0x830 of hyp-init.o (the stack trace is for EL1, and is not going to
help much).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
