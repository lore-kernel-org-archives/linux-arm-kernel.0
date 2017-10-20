From: gengdj.1984@gmail.com (gengdongjiu)
Date: Sat, 21 Oct 2017 00:44:57 +0800
Subject: [PATCH v4 15/21] KVM: arm64: Set an impdef ESR for Virtual-SError
 using VSESR_EL2.
In-Reply-To: <20171019145807.23251-16-james.morse@arm.com>
References: <20171019145807.23251-1-james.morse@arm.com>
 <20171019145807.23251-16-james.morse@arm.com>
Message-ID: <CAMj-D2AMy1_SPrLGti9U=oz1JvBDHvRAMsBtw51B3JK0omLyXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-10-19 22:58 GMT+08:00 James Morse <james.morse@arm.com>:
> Prior to v8.2's RAS Extensions, the HCR_EL2.VSE 'virtual SError' feature
> generated an SError with an implementation defined ESR_EL1.ISS, because we
> had no mechanism to specify the ESR value.
>
> On Juno this generates an all-zero ESR, the most significant bit 'ISV'
> is clear indicating the remainder of the ISS field is invalid.
>
> With the RAS Extensions we have a mechanism to specify this value, and the
> most significant bit has a new meaning: 'IDS - Implementation Defined
> Syndrome'. An all-zero SError ESR now means: 'RAS error: Uncategorized'
> instead of 'no valid ISS'.

consider again.

I still consider that it is not better set  "Implementation Defined
Syndrome" here.
I know your meaning that An all-zero SError means Uncategorized
>From the beginning,  our starting point is KVM is the architecture
related and Qemu/kvmtool is platform related.
Qemu/kvmtool is the role of host firmware.
so we let Qemu to create APEI/GHES table and record CPER,
and also injects SEA/SEI in the Qemu.

About the vsesr_el2 which is used to specify the guest ESR,   also all
set by Qemu/kvmtool are better.
including the three cases  even the ESR are  all-zero(uncategorized).
1. IMPLEMENTATION DEFINED
2  categorized,
3  uncategorized,

For this case, Qemu just set the ESR, nothing else, not passing
RAS-error to userspace.
