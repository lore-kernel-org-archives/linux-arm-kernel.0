From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 May 2014 15:20:03 +0100
Subject: [PATCH v3 14/14] ARM64: KVM: fix big endian issue in access_vm_reg
 for 32bit guest
In-Reply-To: <20140528140915.GB38250@lvm>
References: <1399997646-4716-1-git-send-email-victor.kamensky@linaro.org>
 <1399997646-4716-15-git-send-email-victor.kamensky@linaro.org>
 <20140526175225.GF31431@lvm>
 <CAA3XUr15fJu3vRU3Hq=fajiRCd1gvkdmvJfsa3Te4N-3puwcWA@mail.gmail.com>
 <20140528091438.GL16428@lvm>
 <CAA3XUr3=jeNqP6FMSki8Mij-ENu7X+nBRrQ2p_bUODw_9jmgog@mail.gmail.com>
 <20140528140915.GB38250@lvm>
Message-ID: <5385F093.7020405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/05/14 15:09, Christoffer Dall wrote:
> On Wed, May 28, 2014 at 06:56:44AM -0700, Victor Kamensky wrote:
>> On 28 May 2014 02:14, Christoffer Dall <christoffer.dall@linaro.org> wrote:
>>
>> They cannot be separate it is the same data with two ways
>> to access: as 64bit value or low word 32bit value. Typically it is LPAE
>> cp15 memory related registers like TTBR0, as in mcrr, mcr example
>> in my previous response. mcrr will update high and low word values
>> of TTBR0, mcr will update only low word of it.
>>
> You just have to decide whether you want to represent a 64-bit register as
> a concatenation of two u32's or a 32-bit register access as a part
> of the 64-bit register value.
> 
> I think the architecture, at least for 32-bit register views on ARMv8,
> defines the 32-bit accesses as a view on the 64-bit register.

Indeed, and that's how KVM implements it.

> You should of course only store those registers once, but instead of
> storing them in an array of u32's you could store the 64-bit wide
> registers in a separate array of u64's.  32-bit accesses to those
> registers would look in the array of u64's for such a value.
> 
> I didn't try it out, so not sure how it looks like, just saying it's an
> option worth considering.

I think that's the best idea so far. If the access is 64bit, use the
64bit version of the union (going through the corresponding
vcpu_sys_reg() interface).

This should be a very minimal refactor.

	M.
-- 
Jazz is not dead. It just smells funny...
