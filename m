From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Aug 2018 14:57:31 +0100
Subject: [PATCH v3 7/9] KVM: arm/arm64: Only clean the dcache on
 translation fault
In-Reply-To: <bfeee11e-f8bf-78f2-ab61-27e43781e2e3@suse.de>
References: <20171023161122.15291-1-marc.zyngier@arm.com>
 <20171023161122.15291-8-marc.zyngier@arm.com>
 <bfeee11e-f8bf-78f2-ab61-27e43781e2e3@suse.de>
Message-ID: <9fa7efdf-1c21-7b07-edb9-0c7d0d91eaed@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/08/18 14:35, Alexander Graf wrote:
> On 10/23/2017 06:11 PM, Marc Zyngier wrote:
>> The only case where we actually need to perform a dcache maintenance
>> is when we map the page for the first time, and subsequent permission
>> faults do not require cache maintenance. Let's make it conditional
>> on not being a permission fault (and thus a translation fault).
>>
>> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> This patch unfortunately breaks something on Hi1616 SoCs when running 
> 32bit guests. With this patch applied (and thus with 4.18) I get random 
> illegal instruction warnings from 32bit code inside VMs. I do not know 
> at this point whether this affects other CPUs as well.

Can you please give a few more details?

- what are the CPUs on this Hi1616? At least a /proc/cpuinfo would help

- an example of the crash? Is it within the decompressor? After? This
things do matter, given the number of crazy things the 32bit kernel does

- a host kernel configuration?

> If anyone is interested in a reproducer, I have something handy. But for 
> now I believe we should just revert this patch.

Before we revert anything, I'd like to understand what is happening.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
