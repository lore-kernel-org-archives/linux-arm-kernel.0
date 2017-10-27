From: james.morse@arm.com (James Morse)
Date: Fri, 27 Oct 2017 18:38:33 +0100
Subject: [PATCH v4 19/21] KVM: arm64: Handle RAS SErrors from EL2 on guest
 exit
In-Reply-To: <6c0eaa5b-32a5-5562-2322-7dffb698d27d@huawei.com>
References: <20171019145807.23251-1-james.morse@arm.com>
 <20171019145807.23251-20-james.morse@arm.com>
 <6c0eaa5b-32a5-5562-2322-7dffb698d27d@huawei.com>
Message-ID: <59F36F19.9060109@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi gengdongjiu,

On 27/10/17 07:26, gengdongjiu wrote:
> On 2017/10/19 22:58, James Morse wrote:
>> +alternative_if ARM64_HAS_RAS_EXTN
>> +	// If we have the RAS extensions we can consume a pending error
>> +	// without an unmask-SError and isb.
>> +	esb
>> +	mrs_s	x2, SYS_DISR_EL1

> I do not think you can get the right value when esb produce a SError. when
> SError happen, it will take to EL3 firmware immediately. so the disr_el1 will not record
> the error and value is 0.

This depends on SCR_EL3.EA, which the normal-world can't know about.

Your system sets SCR_EL3.EA, and takes the SError to EL3. It's now up to
firmware to notify the normal world via some firmware-first mechanism.

What does KVM do? SCR_EL3.EA makes DISR_EL1 RAZ/WI, so yes, it reads 0 here,
notes there is no SError pending, and it continues on its merry way. Firmware is
left to pick up the pieces and notify the normal world about the error.


What if SCR_EL3.EA is clear? Now SCTLR_EL2.IESB's ErrorSynchronizationBarrier
causes any RAS error the CPU has deferred to become a pending SError. But SError
is masked because we took an exception.
Running the ESB-instruction consumes any pending SError and writes its ESR into
DISR_EL1.

What does KVM do? Reads the value and sets the ARM_EXIT_WITH_SERROR_BIT if there
was an error pending.


>> +	str	x2, [x1, #(VCPU_FAULT_DISR - VCPU_CONTEXT)]
>> +	cbz	x2, 1f

> why will jump to 1, if there is not SError, also "ret"?

jump to 1: to avoid the cost of writing zero back to DISR_EL1 if its already
zero and skip setting the ARM_EXIT_WITH_SERROR_BIT, as there was no SError.

ret: because this is what happens at the end of the vaxorcism code. We need to
run that as with the ARMv8.2 RAS Extensions we have a better way of consuming
SError from the CPU without taking them as an exception.


>> +	msr_s	SYS_DISR_EL1, xzr
>> +	orr	x0, x0, #(1<<ARM_EXIT_WITH_SERROR_BIT)
>> +1:	ret
>> +alternative_else


James
