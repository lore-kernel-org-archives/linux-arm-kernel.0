From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Tue, 29 Mar 2016 20:11:33 +0800
Subject: [RFC PATCH 3/3] arm64: Expose cpu vender id and model name
 through cpuinfo
In-Reply-To: <20160329113820.GD26574@leverpostej>
References: <1458898209-7486-1-git-send-email-wangkefeng.wang@huawei.com>
 <1458898209-7486-4-git-send-email-wangkefeng.wang@huawei.com>
 <20160329113820.GD26574@leverpostej>
Message-ID: <56FA70F5.1010606@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/3/29 19:38, Mark Rutland wrote:
> On Fri, Mar 25, 2016 at 05:30:09PM +0800, Kefeng Wang wrote:
>> It is helpful to show the name of chip vendor and CPU model
>> to customers in cpuinfo, identify them by using CPU implementer
>> and CPU part is not intuitive(compared with x86).
> 
> On x86 these strings are acquired from the CPU itself, via CPUID
> instructions, which means that it works for future CPUs. For ARM
> systems, we have no consistent way of acquiring a model name from a CPU
> itself. Given the rate at which implementations are appearing, and
> recent experience [1] with issues mapping MIDRs to human-readable names,
> this is going to be very problematic.
> 
> We already expose the raw field values from MIDR_EL1, which are
> sufficient for a userspace application to identify a particular
> processor regardless of whether the kernel recognises it, and regardless
> of what firmware told the kernel. GCC for instance identifies CPUs based
> on MIDR_EL1 fields.
> 
> We also don't do this for arch/arm, and the two should look the same.
> 
>> We are complained for this several times, so expose them.
> 
> If you which to have human-readable strings for a CPU, a better approach
> would be to teach some userspace tool to map MIDR_EL1 values to vendor
> strings. It would be possible to update that tool when new CPUs appear,
> completely independently of the kernel.
> 
> NAK for this approach. It is not scalable, and there are other
> approaches which work today for the set of problems this tries to
> address.

Ok, clear enough, so we will push the customer to convert the impl and part
in there userspace tool, not do it in kernel.

Thanks.


> 
> Thanks,
> Mark.
> 
> [1] https://community.arm.com/groups/processors/blog/2014/09/30/arm-cortex-a17-cortex-a12-processor-update
> 
