From: gengdongjiu@huawei.com (gengdongjiu)
Date: Wed, 10 May 2017 17:15:04 +0800
Subject: [PATCH v3 3/3] arm/arm64: signal SIBGUS and inject SEA Error
In-Reply-To: <5911D204.7020304@arm.com>
References: <CAMj-D2BGTDKpOcMu2ip41_MTTj8VDwvs59Ds7yvLHcD8PeQzhg@mail.gmail.com>
 <5910AAA2.4030304@arm.com> <20170508175416.GA32234@cbox>
 <5911D204.7020304@arm.com>
Message-ID: <e8614b38-9c17-bcfc-2239-307ed0f98c94@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks James's explanation.

Hi Christoffer,

On 2017/5/9 22:28, James Morse wrote:
> Hi Christoffer,
> 
> On 08/05/17 18:54, Christoffer Dall wrote:
>> On Mon, May 08, 2017 at 06:28:02PM +0100, James Morse wrote:
>> I must admit I am losing track of exactly what this proposed API was
>> supposed to do.
> 
> There are two, and we keep jumping between them!
> This is about two notification methods APEI has for arm64, 'SEA' and 'SEI'.
> 
> SEA is synchronous and looks like a data abort. Qemu/kvmtool can inject these
> today using the KVM_GET/SET_ONE_REG API whenever it wants to.
> 
> SEI uses SError, is asynchronous and can be masked. In addition these need to be
> consumed/synchronised by the ESB instruction, even when executed by a guest.
> Hardware has the necessary bits to drive all this, we need to expose an API to
> drive it.
> 
> (I try to spell them out each time so I don't confuse SEI with something
> synchronous!)
> 
> 
> This patch was about SEA. I think you've answered our question:

we are talking about the SEA(synchronous data abort) injection two methods:

(1)change vcpu registers in the Qemu/kvmtools and using the KVM_GET/SET_ONE_REG API to set.
(2)using existed in-kernel API "kvm_inject_dabt" to inject through IOCTL command from Qemu.


> 
>> However, if it's a question about setting up VCPU registers to a certain
>> state and potentially modifying memory, then I think experience has
>> shown us (psci) that emulating something in the kernel that userspace
>> can have fine-grained control over is a bad idea, and should be left to
>> userspace using as generic APIs as possible.
>>
>> Furthermore, if I understand what injecting a SEA requires, it is very
>> similar to resetting the CPU and loading data into guest memory, which
>> QEMU already does today, and there is no reason to introduce additional
>> APIs if it can be done using KVM_GET/SET_ONE_REG ioctls.
> 
> 
> Thanks,
> 
> James
> 
> .
> 
