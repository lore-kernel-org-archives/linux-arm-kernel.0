From: stefan@agner.ch (Stefan Agner)
Date: Thu, 29 Nov 2018 10:54:45 +0100
Subject: [PATCH] pci: imx6: support kernels built in Thumb-2 mode
In-Reply-To: <9861493a-6139-ca3e-41a8-e6fe41c2f3a3@arm.com>
References: <20181128132554.28139-1-stefan@agner.ch>
 <ff476784-b79e-18bf-5870-4365c8377deb@arm.com>
 <074f80db0eceb76672bca283c5de37b9@agner.ch>
 <9861493a-6139-ca3e-41a8-e6fe41c2f3a3@arm.com>
Message-ID: <89a0b0bf3ff340ac5077f6c0de3419a7@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.11.2018 20:35, Robin Murphy wrote:
> On 28/11/2018 17:53, Stefan Agner wrote:
>> On 28.11.2018 17:16, Robin Murphy wrote:
>>> Hi Stefan,
>>>
>>> On 28/11/2018 13:25, Stefan Agner wrote:
>>>> Add a fault handler which handles reads in Thumb-2 mode. Install
>>>> the appropriate handler depending on which mode the kernel has
>>>> been built. This avoids an "Unhandled fault: external abort on
>>>> non-linefetch (0x1008) at 0xf0a80000" during boot on a device
>>>> with a PCIe switch connected.
>>>>
>>>> Link: https://lore.kernel.org/linux-pci/20181126161645.8177-1-stefan at agner.ch/
>>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>>> ---
>>>> FWIW, I found this manual helpful to write the code below:
>>>> http://hermes.wings.cs.wisc.edu/files/Thumb-2SupplementReferenceManual.pdf#page=43&zoom=100,0,66
>>>
>>> This one's rather less ancient and even more authoritative ;)
>>>
>>> https://static.docs.arm.com/ddi0406/cd/DDI0406C_d_armv7ar_arm.pdf
>>>
>>> (ARMv7 had a few new encodings over and above ARMv6T2, although in
>>> fairness I don't think any should be relevant to this specific case)
>>>
>>
>> Thanks, I tried to find the right document on arm.com, but I timed out
>> after 5 minutes or so :-)
>>
>>>> --
>>>> Stefan
>>>>
>>>>    drivers/pci/controller/dwc/pci-imx6.c | 37 ++++++++++++++++++++++++++-
>>>>    1 file changed, 36 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
>>>> index 69f86234f7c0..683deb74d69f 100644
>>>> --- a/drivers/pci/controller/dwc/pci-imx6.c
>>>> +++ b/drivers/pci/controller/dwc/pci-imx6.c
>>>> @@ -29,6 +29,7 @@
>>>>    #include <linux/reset.h>
>>>>    #include <linux/pm_domain.h>
>>>>    #include <linux/pm_runtime.h>
>>>> +#include <asm/opcodes.h>
>>>>      #include "pcie-designware.h"
>>>>    @@ -299,6 +300,37 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
>>>>    	return 1;
>>>>    }
>>>>    +static int imx6q_pcie_abort_handler_thumb2(unsigned long addr,
>>>> +		unsigned int fsr, struct pt_regs *regs)
>>>> +{
>>>> +	unsigned long pc = instruction_pointer(regs);
>>>> +	unsigned long instr = *(unsigned long *)pc;
>>>> +	unsigned long thumb2_instr = __mem_to_opcode_thumb16(instr);
>>>> +	int reg = thumb2_instr & 7;
>>>> +
>>>> +	if (!__opcode_is_thumb16(instr & 0x0000ffffUL))
>>>> +		return 1;
>>>
>>> There are plenty of 32-bit Thumb encodings of various LDR/STR
>>> variants, and I doubt we can guarantee that the offset, target
>>> register, and/or addressing mode for a config space access will
>>> *always* suit the (relatively limited) 16-bit ones.
>>
>> Hm, I guess they should be handled too?
>>
>> I looked at the code where I had the abort at hand triggered
>> (dw_pcie_read).
> 
> For the sake of robustness, I think it makes sense to at least handle
> all LDR/LDRH/LDRB encodings which might possibly fall out of a
> read[lwb]() call. Given that we seem to have various versions of this
> decoding in differing states of completeness, perhaps it's even worth
> factoring out into some kind of common "Arm PCI synchronous abort
> handler".
> 

That was actually my approach. dw_pcie_read uses read[lwb](), and this
is how it disassembles:

00000000 <dw_pcie_read>:                                                
                                                                   
   0:   1e4b            subs    r3, r1, #1                              
                                                                   
   2:   4003            ands    r3, r0                                  
                                                                   
   4:   d112            bne.n   2c <dw_pcie_read+0x2c>                  
                                                                   
   6:   2904            cmp     r1, #4                                  
                                                                   
   8:   d00a            beq.n   20 <dw_pcie_read+0x20>                  
                                                                   
   a:   2902            cmp     r1, #2                                  
                                                                   
   c:   d012            beq.n   34 <dw_pcie_read+0x34>                  
                                                                   
   e:   2901            cmp     r1, #1                                  
                                                                   
  10:   d10c            bne.n   2c <dw_pcie_read+0x2c>                  
                                                                   
  12:   7801            ldrb    r1, [r0, #0]                            
                                                                   
  14:   b2c9            uxtb    r1, r1                                  
                                                                   
  16:   f3bf 8f4f       dsb     sy                                      
                                                                   
  1a:   4618            mov     r0, r3                                  
                                                                   
  1c:   6011            str     r1, [r2, #0]                            
                                                                   
  1e:   4770            bx      lr                                      
                                                                   
  20:   6801            ldr     r1, [r0, #0]
  22:   f3bf 8f4f       dsb     sy
  26:   6011            str     r1, [r2, #0]
  28:   4618            mov     r0, r3
  2a:   4770            bx      lr
  2c:   2300            movs    r3, #0
  2e:   2087            movs    r0, #135        ; 0x87
  30:   6013            str     r3, [r2, #0]
  32:   4770            bx      lr
  34:   8801            ldrh    r1, [r0, #0]
  36:   b289            uxth    r1, r1
  38:   f3bf 8f4f       dsb     sy
  3c:   6011            str     r1, [r2, #0]
  3e:   4618            mov     r0, r3
  40:   4770            bx      lr
  42:   bf00            nop

Those three loads should be handled by below code (unless I made a
mistake).


>>>> +
>>>> +	/* Load word/byte and halfword immediate offset */
>>>> +	if (((thumb2_instr & 0xe800) == 0x6800) ||
>>>> +	    ((thumb2_instr & 0xf800) == 0x8800)) {
>>>> +		unsigned long val;
>>>> +
>>>> +		if (thumb2_instr & 0x1000)
>>>> +			val = 0xff;
>>>> +		else if (thumb2_instr & 0x8000)
>>>> +			val = 0xffff;
>>>> +		else
>>>> +			val = 0xffffffffUL;
>>>> +
>>>> +		regs->uregs[reg] = val;
>>>> +		regs->ARM_pc += 2;
>>>> +		return 0;
>>>> +	}
>>>
>>> What about stores? The existing implementation handles them, so either
>>> that's dead code which could perhaps be cleaned up, or they need to be
>>> handled here too.
>>>
>>
>> I think the current handler (imx6q_pcie_abort_handler) checks bit 20,
>> which means it must be a load not?
> 
> Oops, that's just me being dumb - I managed to overlook the pt_regs
> assignment in the second if() block and thought it was just advancing
> the PC, so assumed (because I also didn't bother to actually look up
> the relevant encoding bits) it must be handling stores. Never mind
> that part then.
> 
>>>> +
>>>> +	return 1;
>>>> +}
>>>> +
>>>>    static int imx6_pcie_attach_pd(struct device *dev)
>>>>    {
>>>>    	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
>>>> @@ -1069,6 +1101,8 @@ static struct platform_driver imx6_pcie_driver = {
>>>>      static int __init imx6_pcie_init(void)
>>>>    {
>>>> +	bool thumb2 = IS_ENABLED(CONFIG_THUMB2_KERNEL);
>>>
>>> Can these aborts definitely *only* be triggered by kernel accesses,
>>> and never, say, via an mmap() of anything exposed to userspace?
>>
>> Honestly, I am not very familiar with PCIe, I don't know...
> 
> Yeah, hopefully the linux-pci audience can clear up that one.
> 
> I was thinking in terms of whether we might need a combined handler
> with a runtime "thumb_mode(regs)" check rather than a compile-time
> decision, but Russell has a good point that just reading the
> instruction at all is its own can of worms in that case.

Since the ARM handler also does not support userspace at this point I'd
rather prefer to just exclude that case and pass it to the default
handler. Then we can look at it once a real world case comes up...

--
Stefan

> 
> Robin.
