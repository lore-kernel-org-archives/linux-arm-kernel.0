From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 28 Nov 2018 19:35:29 +0000
Subject: [PATCH] pci: imx6: support kernels built in Thumb-2 mode
In-Reply-To: <074f80db0eceb76672bca283c5de37b9@agner.ch>
References: <20181128132554.28139-1-stefan@agner.ch>
 <ff476784-b79e-18bf-5870-4365c8377deb@arm.com>
 <074f80db0eceb76672bca283c5de37b9@agner.ch>
Message-ID: <9861493a-6139-ca3e-41a8-e6fe41c2f3a3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/11/2018 17:53, Stefan Agner wrote:
> On 28.11.2018 17:16, Robin Murphy wrote:
>> Hi Stefan,
>>
>> On 28/11/2018 13:25, Stefan Agner wrote:
>>> Add a fault handler which handles reads in Thumb-2 mode. Install
>>> the appropriate handler depending on which mode the kernel has
>>> been built. This avoids an "Unhandled fault: external abort on
>>> non-linefetch (0x1008) at 0xf0a80000" during boot on a device
>>> with a PCIe switch connected.
>>>
>>> Link: https://lore.kernel.org/linux-pci/20181126161645.8177-1-stefan at agner.ch/
>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>> ---
>>> FWIW, I found this manual helpful to write the code below:
>>> http://hermes.wings.cs.wisc.edu/files/Thumb-2SupplementReferenceManual.pdf#page=43&zoom=100,0,66
>>
>> This one's rather less ancient and even more authoritative ;)
>>
>> https://static.docs.arm.com/ddi0406/cd/DDI0406C_d_armv7ar_arm.pdf
>>
>> (ARMv7 had a few new encodings over and above ARMv6T2, although in
>> fairness I don't think any should be relevant to this specific case)
>>
> 
> Thanks, I tried to find the right document on arm.com, but I timed out
> after 5 minutes or so :-)
> 
>>> --
>>> Stefan
>>>
>>>    drivers/pci/controller/dwc/pci-imx6.c | 37 ++++++++++++++++++++++++++-
>>>    1 file changed, 36 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
>>> index 69f86234f7c0..683deb74d69f 100644
>>> --- a/drivers/pci/controller/dwc/pci-imx6.c
>>> +++ b/drivers/pci/controller/dwc/pci-imx6.c
>>> @@ -29,6 +29,7 @@
>>>    #include <linux/reset.h>
>>>    #include <linux/pm_domain.h>
>>>    #include <linux/pm_runtime.h>
>>> +#include <asm/opcodes.h>
>>>      #include "pcie-designware.h"
>>>    @@ -299,6 +300,37 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
>>>    	return 1;
>>>    }
>>>    +static int imx6q_pcie_abort_handler_thumb2(unsigned long addr,
>>> +		unsigned int fsr, struct pt_regs *regs)
>>> +{
>>> +	unsigned long pc = instruction_pointer(regs);
>>> +	unsigned long instr = *(unsigned long *)pc;
>>> +	unsigned long thumb2_instr = __mem_to_opcode_thumb16(instr);
>>> +	int reg = thumb2_instr & 7;
>>> +
>>> +	if (!__opcode_is_thumb16(instr & 0x0000ffffUL))
>>> +		return 1;
>>
>> There are plenty of 32-bit Thumb encodings of various LDR/STR
>> variants, and I doubt we can guarantee that the offset, target
>> register, and/or addressing mode for a config space access will
>> *always* suit the (relatively limited) 16-bit ones.
> 
> Hm, I guess they should be handled too?
> 
> I looked at the code where I had the abort at hand triggered
> (dw_pcie_read).

For the sake of robustness, I think it makes sense to at least handle 
all LDR/LDRH/LDRB encodings which might possibly fall out of a 
read[lwb]() call. Given that we seem to have various versions of this 
decoding in differing states of completeness, perhaps it's even worth 
factoring out into some kind of common "Arm PCI synchronous abort handler".

>>> +
>>> +	/* Load word/byte and halfword immediate offset */
>>> +	if (((thumb2_instr & 0xe800) == 0x6800) ||
>>> +	    ((thumb2_instr & 0xf800) == 0x8800)) {
>>> +		unsigned long val;
>>> +
>>> +		if (thumb2_instr & 0x1000)
>>> +			val = 0xff;
>>> +		else if (thumb2_instr & 0x8000)
>>> +			val = 0xffff;
>>> +		else
>>> +			val = 0xffffffffUL;
>>> +
>>> +		regs->uregs[reg] = val;
>>> +		regs->ARM_pc += 2;
>>> +		return 0;
>>> +	}
>>
>> What about stores? The existing implementation handles them, so either
>> that's dead code which could perhaps be cleaned up, or they need to be
>> handled here too.
>>
> 
> I think the current handler (imx6q_pcie_abort_handler) checks bit 20,
> which means it must be a load not?

Oops, that's just me being dumb - I managed to overlook the pt_regs 
assignment in the second if() block and thought it was just advancing 
the PC, so assumed (because I also didn't bother to actually look up the 
relevant encoding bits) it must be handling stores. Never mind that part 
then.

>>> +
>>> +	return 1;
>>> +}
>>> +
>>>    static int imx6_pcie_attach_pd(struct device *dev)
>>>    {
>>>    	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
>>> @@ -1069,6 +1101,8 @@ static struct platform_driver imx6_pcie_driver = {
>>>      static int __init imx6_pcie_init(void)
>>>    {
>>> +	bool thumb2 = IS_ENABLED(CONFIG_THUMB2_KERNEL);
>>
>> Can these aborts definitely *only* be triggered by kernel accesses,
>> and never, say, via an mmap() of anything exposed to userspace?
> 
> Honestly, I am not very familiar with PCIe, I don't know...

Yeah, hopefully the linux-pci audience can clear up that one.

I was thinking in terms of whether we might need a combined handler with 
a runtime "thumb_mode(regs)" check rather than a compile-time decision, 
but Russell has a good point that just reading the instruction at all is 
its own can of worms in that case.

Robin.
