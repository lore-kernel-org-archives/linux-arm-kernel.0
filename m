From: leoy@marvell.com (Leo Yan)
Date: Mon, 23 Sep 2013 19:11:40 +0800
Subject: [Question] Verification For arm64: suspend/resume implementation
In-Reply-To: <20130913144001.GA28531@e102568-lin.cambridge.arm.com>
References: <52327E41.1070904@marvell.com>
 <20130913144001.GA28531@e102568-lin.cambridge.arm.com>
Message-ID: <524021EC.2000207@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2013 10:40 PM, Lorenzo Pieralisi wrote:
> On Fri, Sep 13, 2013 at 03:53:53AM +0100, Leo Yan wrote:
>> hi Lorenzo,
>>
>> I have applied your ARM64's suspend/resume related patches and can built
>> successfully. i want to verify these patches on foundation model
>> firstly, so below are my questions:
>>
>> "Code has been tested on AEM v8 models and a simple CPU idle driver that
>> enables a C-state where CPUs are reset when wfi is hit."
>>
>> 1. Can u help share this simple cpu idle driver?
>
> Yes, I will post a simple skeleton driver, PSCI based (bootwrapper
> implementation), by the end of September.
>
>> 2. On the foundation model, if the core is placed into reset state, then
>> if there have interrupt is routed to the core, the core still cannot be
>> waken up anymore; because the reset bit cannot be released by h/w. So
>> how can let the core return back from the reset state?
>
> Well, I am testing it with the AEM models power controller that is not
> publicly available yet, and _should_ be released with the new version of the
> foundation models.
>
> As a first step, I will write a PSCI suspend implementation that just executes
> wfi and resumes through the reset vector to emulate a power down as a means to
> make the suspend/resume code path usable to everyone.
>

Looking forward the related implementation; After them are ready, i'm 
glad have a trying.

At my side, i'm warming up related doc and tried to debug related tear 
down opreations according to CA53's TRM; pls see enclosed two patches.
Firstly clarify, these two patches are _ONLY_ for debugging purpose, i 
have no plan to commit them for Linux kernel.

0001-cpuidle-add-simple-driver-for-arm64.patch: it's a simple cpuidle 
driver;
0002-ARM64-add-cpu-tear-down-function-for-A53-s-power-mod.patch: i tried 
to wrote a tear down operations (disable D$/flush L1 cache/Disable SMP 
bit, etc);

But i found in the patch 2, if the core execute the instruction "mrs 
  x0, S3_1_C15_C2_1" to access CPUECTLR_EL1, the kernel will report the 
illegal instructions. So just like before i saw the discussion on 
mailing list, On ARMv8 we need operate the SMP bit in EL2/EL3/Secure EL1 
but not in non-secure EL1.

Here i tried two methods to try to fix this issue, but both of them were 
failure:
1. I tried to set the ACTLR_EL2 bit 1 in the boot wrapper code, but when 
in the non-secure world's kernel to access  CPUECTLR_EL1 it still will 
report the panic for illegal instruction;
2. I tried to modify the boot wrapper code to let the kernel stay in 
secure world's EL1, but looks like it also failed;

So do u have any suggestion for this failure?


Thx,
Leo Yan
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-cpuidle-add-simple-driver-for-arm64.patch
Type: text/x-patch
Size: 5866 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130923/1711d443/attachment-0002.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-ARM64-add-cpu-tear-down-function-for-A53-s-power-mod.patch
Type: text/x-patch
Size: 4314 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130923/1711d443/attachment-0003.bin>
