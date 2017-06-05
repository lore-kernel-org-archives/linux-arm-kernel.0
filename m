From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 5 Jun 2017 10:10:23 +0100
Subject: [PATCH v2 03/25] KVM: arm64: Make kvm_condition_valid32()
 accessible from EL2
In-Reply-To: <20170605082321.GA8984@cbox>
References: <20170601102117.17750-1-marc.zyngier@arm.com>
 <20170601102117.17750-4-marc.zyngier@arm.com> <20170604121129.GB9464@cbox>
 <394ef6fd-1123-0a1f-f462-ed5cb52e24da@arm.com> <20170605082321.GA8984@cbox>
Message-ID: <2ab26ba3-26b7-4072-00ca-eefd2bdf269b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/17 09:23, Christoffer Dall wrote:
> On Mon, Jun 05, 2017 at 09:13:53AM +0100, Marc Zyngier wrote:
>> On 04/06/17 13:11, Christoffer Dall wrote:
>>> On Thu, Jun 01, 2017 at 11:20:55AM +0100, Marc Zyngier wrote:
>>>> As we're about to trap CP15 accesses and handle them at EL2, we
>>>> need to evaluate whether or not the condition flags are valid,
>>>> as an implementation is allowed to trap despite the condition
>>>> not being met.
>>>>
>>>> Tagging the function as __hyp_text allows this.
>>>
>>> is the cc_map also guaranteed to work (by simple reference) in EL2 then?
>>
>> Yes. By virtue of being const, this ends up in the read-only part of the
>> kernel, which we always map at EL2.
>>
> 
> And why don't we have to do any address-translation-to-hyp tricks on the
> address?  Are we guaranteed that it's a relative address and everything
> is relocated with the same offset, or how was that again?

Arghh, I completely missed this. Yeah, it works because this is a single
compilation unit, that the array is static, used only once, and that the
compiler is using relative addressing and not playing any dirty tricks
on us.

We could make the whole thing private to kvm_condition_valid32, but
that's not more of a guarantee that things won't break if the compiler
decides to generate absolute addresses.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
