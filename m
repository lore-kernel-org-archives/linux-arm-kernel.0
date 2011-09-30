From: per.forlin@stericsson.com (=?ISO-8859-1?Q?Per_F=F6rlin?=)
Date: Fri, 30 Sep 2011 07:37:41 +0200
Subject: [PATCH] arm: proc-v7: pc phy addresses before disable MMU
In-Reply-To: <20110924130202.GF17169@n2100.arm.linux.org.uk>
References: <1316851370-7284-1-git-send-email-per.forlin@stericsson.com>
	<20110924081342.GA2639@mwesterb-mobl.ger.corp.intel.com>
	<4E7DA3C0.7000208@stericsson.com>
	<20110924110024.GA20044@e102144-lin.cambridge.arm.com>
	<4E7DD34E.3060402@stericsson.com>
	<20110924130202.GF17169@n2100.arm.linux.org.uk>
Message-ID: <4E8555A5.9090304@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2011 03:02 PM, Russell King - ARM Linux wrote:
> On Sat, Sep 24, 2011 at 02:55:42PM +0200, Per F?rlin wrote:
>> On 09/24/2011 01:00 PM, Will Deacon wrote:
>>> On Sat, Sep 24, 2011 at 10:32:48AM +0100, Per F?rlin wrote:
>>>> I am trying to figure out how I can get the value of PHYS_OFFSET in assembler code (proc-v7.S).
>>>> I guess I could use the value calculated in arch/arm/kernel.head.S but wouldn't that make
>>>> this patch dependent on CONFIG_ARM_PATCH_PHYS_VIRT?
>>>
>>> Wouldn't we just be better off passing a physical address to cpu_v7_reset
>>> instead?
>>>
>> Good point! I'm fine with that.
> 
> Alternatively, call it using the phys address.
I changed the code to use a label instead of the ARM specific instruction offset +4. A few more lines but the intention is that it should work with both ARM and THUMB. I'm in favour of Russell's idea of setting pc to physical before calling cpu_reset().
      /* Go to physical addresses to be ready for MMU disable */
      asm("ADR r1, pc_phy_here \n\t"
          "sub r1, %0 \n\t"
          "mov pc, r1 \n\t"
          "pc_phy_here: \n\t"
          : :"r" (PAGE_OFFSET - PHYS_OFFSET) : "r1", "cc");

Where is the best place for this code?
Should this be run for all ARM cpu_reset()?

I haven't found a nice way to add to cpu_reset() yet. This is what I have so far.
1. Redirect cpu_reset to c-function __cpu_reset_phy() that sets the pc to phy and then calls __cpu_reset() (the original one)
1.1 May add ifdefs in __cpu_reset_phy() to only do the virt to phy transition for some explicit ARM versions before calling __cpu_reset()
2. Rename cpu_v7_reset() to __cpu_v7_reset(). Only redirect cpu_v7_reset() to the c-function that goes to phy and then calls __cpu_v7_reset().
3. Add a new in parameter "phys_offset" to cpu_reset(). Modify only those CPU_reset() that needs this parameter. Redirect cpu_reset(x,y) to CPU_reset(x) or CPU_reset(x,y) based on ARM version.

Regards,
Per
