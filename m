From: james.morse@arm.com (James Morse)
Date: Fri, 03 Nov 2017 16:14:04 +0000
Subject: [PATCH v4 20/21] KVM: arm64: Take any host SError before entering
 the guest
In-Reply-To: <20171103124904.GC14144@cbox>
References: <20171019145807.23251-1-james.morse@arm.com>
 <20171019145807.23251-21-james.morse@arm.com> <20171031062315.GY2166@lvm>
 <59F861EE.4010505@arm.com> <20171101045550.GB11166@lvm>
 <59FB0D0C.1010208@arm.com> <20171103124904.GC14144@cbox>
Message-ID: <59FC95CC.3090706@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 03/11/17 12:49, Christoffer Dall wrote:
> Does a non-secure esb() cause the error to be delivered to firmware on
> the secure side if anything is pending?

Yes, the ESB-instruction causes 'synchronisable' errors to become pending as an
SError. They then follow the normal SError rules.


> I'm not sure I fully understand the interaction between issuing an
> esb() in non-secure and firmware handling a RAS error; I thought there
> would be none, and that this was only for kernel-first ?

To implement firmware-first, EL3 has to set SCR_EL3.EA to route external-aborts
and physical SError to EL3. So an ESB-instruction, even in a guest, may cause an
SError to be taken to EL3 for firmware-first handling.

This is why RAS is causing so much noise for KVM, any notification could also
interrupt a guest, so firmware has to emulate an exception taken to EL2
correctly and KVM will have to plumb the notification across to the host APEI code.


Thanks,

James
