From: m.smarduch@samsung.com (Mario Smarduch)
Date: Sat, 14 Nov 2015 15:04:23 -0800
Subject: [PATCH 3/3] KVM/arm64: enable enhanced armv8 fp/simd lazy switch
In-Reply-To: <20151110111822.GC12968@cbox>
References: <1446242193-8424-1-git-send-email-m.smarduch@samsung.com>
 <1446242193-8424-4-git-send-email-m.smarduch@samsung.com>
 <20151105150255.GD5819@cbox> <5641288B.90105@samsung.com>
 <20151110111822.GC12968@cbox>
Message-ID: <5647BDF7.5070209@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/10/2015 3:18 AM, Christoffer Dall wrote:
> On Mon, Nov 09, 2015 at 03:13:15PM -0800, Mario Smarduch wrote:
>>
>>
>> On 11/5/2015 7:02 AM, Christoffer Dall wrote:
>>> On Fri, Oct 30, 2015 at 02:56:33PM -0700, Mario Smarduch wrote:
[....]
>> kern_hyp_va x0
>> add x2, x0, #VCPU_CONTEXT
>> mrs x1, fpexec32_el2
>> str x1, [x2, #CPU_SYSREG_OFFSET(FPEXC32_EL2)]
>> ret
>>
>> Of course each hyp call has additional overhead, at a high exit to
>> vcpu_put ratio hyp call appears better. But all this is very
>> highly dependent on exit rate and fp/simd usage. IMO hyp call
>> works better under extreme loads should be pretty close
>> for general loads.
>>
>> Any thoughts?
>>
> I think the typical case will be lots of exits and few
> vcpu_load/vcpu_put, and I think it's reasonable to write the code that
> way.

Yes, especially for RT guests where vCPU is pinned.

Thanks.
> 
> That should also be much better for VHE.
> 
> So I would go that direction.
> 
> Thanks,
> -Christoffer
> 
