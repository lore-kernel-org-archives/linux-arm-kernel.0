From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 2 May 2017 15:50:17 +0100
Subject: [PATCH 1/5] arm64: KVM: Do not use stack-protector to compile EL2
 code
In-Reply-To: <20170502144029.GB29224@e104818-lin.cambridge.arm.com>
References: <20170502133041.10980-1-marc.zyngier@arm.com>
 <20170502133041.10980-2-marc.zyngier@arm.com>
 <20170502144029.GB29224@e104818-lin.cambridge.arm.com>
Message-ID: <334c4025-873d-d30c-534b-4194c78eb64b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/17 15:40, Catalin Marinas wrote:
> On Tue, May 02, 2017 at 02:30:37PM +0100, Marc Zyngier wrote:
>> We like living dangerously. Nothing explicitely forbids stack-protector
>> to be used in the EL2 code, while distributions routinely compile their
>> kernel with it. We're just lucky that no code actually triggers the
>> instrumentation.
>>
>> Let's not try our luck for much longer, and disable stack-protector
>> for code living at EL2.
>>
>> Cc: stable at vger.kernel.org
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm64/kvm/hyp/Makefile | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
>> index aaf42ae8d8c3..14c4e3b14bcb 100644
>> --- a/arch/arm64/kvm/hyp/Makefile
>> +++ b/arch/arm64/kvm/hyp/Makefile
>> @@ -2,6 +2,8 @@
>>  # Makefile for Kernel-based Virtual Machine module, HYP part
>>  #
>>  
>> +ccflags-y += -fno-stack-protector
>> +
> 
> While you are at it, should we have a -fpic here as well? The hyp code
> runs at a different location than the rest of the kernel.

We definitely should. I've just tried this, and this doesn't seem to
work very well. At least this seems to break our jump label
implementation. I need to page in that part of the code base and see
what happens.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
