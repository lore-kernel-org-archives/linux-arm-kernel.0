From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 25 Jun 2014 15:46:43 +0100
Subject: [RFC PATCH 3/9] irqchip: GIC: Convert to EOImode == 1
In-Reply-To: <CAFEAcA_naeGVc+Rsec=Ds6Lzf345nzFj3Wg2RWY-6LWYv3euNQ@mail.gmail.com>
References: <1403688530-23273-1-git-send-email-marc.zyngier@arm.com>
 <1403688530-23273-4-git-send-email-marc.zyngier@arm.com>
 <CAFEAcA_naeGVc+Rsec=Ds6Lzf345nzFj3Wg2RWY-6LWYv3euNQ@mail.gmail.com>
Message-ID: <53AAE0D3.8030008@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/06/14 15:06, Peter Maydell wrote:
> On 25 June 2014 10:28, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> For this case, the GIC architecture provides EOImode == 1, where:
>> - A write to the EOI register drops the priority of the interrupt and leaves
>> it active. Other interrupts at the same priority level can now be taken,
>> but the active interrupt cannot be taken again
>> - A write to the DIR marks the interrupt as inactive, meaning it can
>> now be taken again.
>>
>> We only enable this feature when booted in HYP mode. Also, as most device
>> trees are broken (they report the CPU interface size to be 4kB, while
>> the GICv2 CPU interface size is 8kB), output a warning if we're booted
>> in HYP mode, and disable the feature.
> 
> Does that mean you guarantee not to write to the DEACTIVATE register
> if not booted in Hyp mode? I ask because QEMU's GIC emulation doesn't
> emulate that register, so it would be useful to know if this patch
> means newer kernels are going to fall over under TCG QEMU...

So far, I only plan to support it when booted in HYP. But it may be that
the split prio-drop/deactivate is also beneficial to threaded
interrupts, saving the writes to the distributor to mask/unmask. That
would require to be a bit more subtle in identifying a GICv2
implementation (DT binding, probably).

	M.
-- 
Jazz is not dead. It just smells funny...
