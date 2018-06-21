From: xuwei5@hisilicon.com (Wei Xu)
Date: Thu, 21 Jun 2018 10:20:42 +0100
Subject: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
In-Reply-To: <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
References: <5B2A6218.3030201@hisilicon.com> <20180620144257.GB27776@arm.com>
 <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
Message-ID: <5B2B6DEA.2090100@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On 2018/6/21 9:38, James Morse wrote:
> Hi Will, Wei,
> 
> On 20/06/18 17:25, Wei Xu wrote:
>> On 2018/6/20 23:54, James Morse wrote:
>> I have disabled CONFIG_ARM64_RAS_EXTN and reverted that commit.
>> But I still got the stack overflow issue sometimes.
>> Do you have more hint?
> 
>> The log is as below:
>>     [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x480fd010]
>>     [    0.000000] Linux version 4.17.0-45865-g2b31fe7-dirty
> 
> Could you reproduce this with v4.17? This says there are ~45,000 extra patches,
> and un-committed changes. None of the hashes so far have been commits in
> mainline, so we have no idea what this tree is.
> 

I have tried v4.17 and log is as below and also it can be found in the first mail
of this thread.

	[ 0.000000] Linux version 4.17.0-45864-g29dcea8-dirty
	(joyx at Turing-Arch-b) (gcc version 4.9.1 20140505 (prerelease) (crosstool-NG
	linaro-1.13.1-4.9-2014.05 - Linaro GCC 4.9-2014.05)) #6 SMP PREEMPT Fri Jun
	15 21:39:52 CST 2018

I will try v4.17.2 and v4.18-rc1.

> 
>> (joyx at Turing-Arch-b) (gcc version 4.9.1 20140505 (prerelease) (crosstool-NG
>> linaro-1.13.1-4.9-2014.05 - Linaro GCC 4.9-2014.05)) #10 SMP PREEMPT Wed Jun 20
>> 23:59:05 CST 2018
> 
>>     [    0.000000] CPU0: using LPI pending table @0x000000007d860000
>>     [    0.000000] GIC: PPI11 is secure or misconfigured
>>     [    0.000000] arch_timer: WARNING: Invalid trigger for IRQ3, assuming level
>> low
>>     [    0.000000] arch_timer: WARNING: Please fix your firmware
>>     [    0.000000] arch_timer: cp15 timer(s) running at 100.00MHz (virt).
> 
> (No idea what these mean, but I doubt they are relevant)
> 

I will try with mainline qemu 2.12.0.

Thanks!

Best Regards,
Wei

> 
>>     [    0.042421] Insufficient stack space to handle exception!
>>     [    0.042423] ESR: 0x96000046 -- DABT (current EL)
>>     [    0.043730] FAR: 0xffff0000093a80e0
>>     [    0.044714] Task stack: [0xffff0000093a8000..0xffff0000093ac000]
> 
> This was a level 2 translation fault on a write, to an address that is within
> the stack....
> 
> 
>>     [    0.051113] IRQ stack: [0xffff000008000000..0xffff000008004000]
>>     [    0.057610] Overflow stack: [0xffff80003efce2f0..0xffff80003efcf2f0]
>>     [    0.064003] CPU: 0 PID: 12 Comm: migration/0 Not tainted
>> 4.17.0-45865-g2b31fe7-dirty #10
>>     [    0.072201] Hardware name: linux,dummy-virt (DT)
> 
>>     [    0.076797] pstate: 604003c5 (nZCv DAIF +PAN -UAO)
>>     [    0.081727] pc : el1_sync+0x0/0xb0
> 
> ... from the vectors.
> 
> 
>>     [    0.085217] lr : kpti_install_ng_mappings+0x120/0x214
> 
> What I think is happening is: we come out of the kpti idmap with the stack
> unmapped. Shortly after we access the stack, which faults. el1_sync faults as
> well when it tries to push the registers to the stack, and we keep going until
> we overflow the stack.
> 
> I can't reproduce this with kvmtool or qemu in the model.
> 
> 
> Thanks,
> 
> James
> 
> .
> 
