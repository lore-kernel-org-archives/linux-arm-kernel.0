From: gengdongjiu@huawei.com (gengdongjiu)
Date: Fri, 27 Oct 2017 14:26:14 +0800
Subject: [PATCH v4 19/21] KVM: arm64: Handle RAS SErrors from EL2 on guest
 exit
In-Reply-To: <20171019145807.23251-20-james.morse@arm.com>
References: <20171019145807.23251-1-james.morse@arm.com>
 <20171019145807.23251-20-james.morse@arm.com>
Message-ID: <6c0eaa5b-32a5-5562-2322-7dffb698d27d@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017/10/19 22:58, James Morse wrote:
> +alternative_if ARM64_HAS_RAS_EXTN
> +	// If we have the RAS extensions we can consume a pending error
> +	// without an unmask-SError and isb.
> +	esb
> +	mrs_s	x2, SYS_DISR_EL1
I do not think you can get the right value when esb produce a SError. when
SError happen, it will take to EL3 firmware immediately. so the disr_el1 will not record
the error and value is 0.

> +	str	x2, [x1, #(VCPU_FAULT_DISR - VCPU_CONTEXT)]
> +	cbz	x2, 1f
why will jump to 1, if there is not SError, also "ret"?

> +	msr_s	SYS_DISR_EL1, xzr
> +	orr	x0, x0, #(1<<ARM_EXIT_WITH_SERROR_BIT)
> +1:	ret
> +alternative_else
