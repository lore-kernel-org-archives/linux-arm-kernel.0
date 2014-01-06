From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 06 Jan 2014 18:20:49 +0000
Subject: [PATCH REPOST 5/5] ARM: kvm MMIO support BE host running LE code
In-Reply-To: <CAA3XUr3sGNQ1==13gcsuz4+ozF1fgUz4YiwbYa6OLFCqFbB5Lg@mail.gmail.com>
 (Victor Kamensky's message of "Mon, 6 Jan 2014 17:44:48 +0000")
References: <1387558125-3460-1-git-send-email-victor.kamensky@linaro.org>
 <1387558125-3460-6-git-send-email-victor.kamensky@linaro.org>
 <8738l1ffr4.fsf@e102391-lin.cambridge.arm.com>
 <CAA3XUr3sGNQ1==13gcsuz4+ozF1fgUz4YiwbYa6OLFCqFbB5Lg@mail.gmail.com>
Message-ID: <87r48ldla6.fsf@e102391-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Victor,

On Mon, Jan 06 2014 at 05:44:48 PM, Victor Kamensky <victor.kamensky@linaro.org> wrote:
> Hi Marc,
>
> Thank you for looking into this.
>
> On 6 January 2014 04:37, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On Fri, Dec 20 2013 at 04:48:45 PM, Victor Kamensky <victor.kamensky@linaro.org> wrote:
>>> In case of status register E bit is not set (LE mode) and host runs in
>>> BE mode we need byteswap data, so read/write is emulated correctly.
>>
>> I don't think this is correct.
>>
>> The only reason we byteswap the value in the BE guest case is because it
>> has byteswapped the data the first place.
>>
>> With a LE guest, the value we get in the register is the right one, no
>> need for further processing. I think your additional byteswap only
>> hides bugs somewhere else in the stack.
>
> First, do we agree that this patch has effect only in BE host case
> (CONFIG_CPU_BIG_ENDIAN=y), because in LE host case cpu_to_leXX
> function does nothing only simple copy, just the same we  had before?

Sure, but that is not the point.

> In BE host case, we have emulator (qemu, kvm-tool), host kernel, and
> hypervisor part of code, all, operating in BE mode; and guest could be either
> LE or BE (i.e E bit not set or set). That is opposite to LE host case,
> where we have emulator (qemu, kvm-tool), host kernel, and hypervisor part
> of code, all, operating in LE mode. Your changes introduced byteswap when
> host is LE and access is happening with E bit set. I don't see why symmetry
> should break for case when host is BE and access is happening with E bit
> cleared.

It is certainly not about symmetry. An IO access is LE, always. Again,
the only reason we byteswap a BE guest is because it tries to write to a
LE device, and thus byteswapping the data before it hits the bus.

When we trap this access, we need to correct that byteswap. And that is
the only case we should handle. A LE guest writes a LE value to a LE
device, and nothing is to be byteswapped.

As for the value you read on the host, it will be exactly the value the
guest has written (registers don't have any endianness).

> In another words, regardless of E bit setting of guest access operation rest
> of the stack should bring/see the same value before/after
> vcpu_data_host_to_guest/vcpu_data_guest_to_host functions are applied. I.e
> the rest of stack should be agnostic to E bit setting of access operation.
> Do we agree on that? Now, depending on E bit setting of guest access operation
> result should differ in its endianity - so in one of two cases byteswap must
> happen. But it will not happen in case of BE host and LE access, unless my diff
> is applied. Previously added byteswap code for E bit set case will not
> have effect
> because in BE host case cpu_to_beXX functions don't do anything just copy, and
> in another branch of if statement again it just copies the data. So regardless
> of E bit setting guest access resulting value is the same in case of
> BE host - it
> cannot be that way. Note, just only with your changes, in LE host case
> byteswap will happen if E bit is set and no byteswap if E bit is clear - so
> guest access resulting value does depend on E setting.
>
> Also please note that vcpu_data_host_to_guest/vcpu_data_guest_to_host functions
> effectively transfer data between host kernel and memory of saved guest CPU
> registers. Those saved registers will be will be put back to CPU registers,
> or saved from CPU registers to memory by hypervisor part of code. In BE host
> case this hypervisor part of code operates in BE mode as well, so register set
> shared between host and hypervisor part of code holds guest registers values in
> memory in BE order. vcpu_data_host_to_guest/vcpu_data_guest_to_host function are
> not interacting with CPU registers directly. I am not sure, but may this
> point was missed.

It wasn't missed. No matter how data is stored in memory (BE, LE, or
even PDP endianness), CPU registers always have a consistent
representation. They are immune to CPU endianness change, and storing
to/reading from memory won't change the value, as long as you use the
same endianness for writing/reading.

What you seems to be missing is that the emulated devices must be
LE. There is no such thing as a BE GIC. So for this to work properly,
you will need to fix the VGIC code (distributor emulation only) to be
host-endianness agnostic, and behave like a LE device, even on a BE
system. And all your other device emulations.

	M.
-- 
Jazz is not dead. It just smells funny.
