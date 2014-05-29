From: m-karicheri2@ti.com (Murali Karicheri)
Date: Thu, 29 May 2014 11:34:49 -0400
Subject: [PATCH v1 5/5] pci: keystone: add pcie driver based on designware
 core driver
In-Reply-To: <6048322.x3M3sdDEWO@wuerfel>
References: <1400169692-9677-1-git-send-email-m-karicheri2@ti.com>
 <1400169692-9677-6-git-send-email-m-karicheri2@ti.com>
 <6048322.x3M3sdDEWO@wuerfel>
Message-ID: <53875399.2020700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/15/2014 12:23 PM, Arnd Bergmann wrote:
> On Thursday 15 May 2014 12:01:32 Murali Karicheri wrote:
>
>> +static int
>> +keystone_pcie_fault(unsigned long addr, unsigned int fsr,
>> +		struct pt_regs *regs)
>> +{
>> +	unsigned long instr = *(unsigned long *) instruction_pointer(regs);
>> +
>> +	if ((instr & 0x0e100090) == 0x00100090) {
>> +		int reg = (instr >> 12) & 15;
>> +
>> +		regs->uregs[reg] = -1;
>> +		regs->ARM_pc += 4;
>> +	}
>> +
>> +	return 0;
>> +}
> This needs to check in the PCI host registers what happened and do
> some appropriate action. If the fault was not caused by PCIe, it
> should not be ignored here but get passed on to the next handler.
>
>
Arnd,

The PCI controller is not able to detect the abort error from the EP and 
this gets
reported to ARM as an Asynchronous external abort. PCI fault handler 
needs to
consume this fault, otherwise it can't work on the Keystone h/w.

For example pci-imx6.c has

/*  Added for PCI abort handling */
static int imx6q_pcie_abort_handler(unsigned long addr,
                 unsigned int fsr, struct pt_regs *regs)
{
         return 0;
}

Other examples are

1) arch/arm/mach-cns3xxx/pci.c
static int cns3xxx_pcie_abort_handler(unsigned long addr, unsigned int fsr,
                                       struct pt_regs *regs)
{
         if (fsr & (1 << 10))
                 regs->ARM_pc += 4;
         return 0;
}
2) arch/.arm/plat-iop/pci.c
/*
  * When a PCI device does not exist during config cycles, the 80200 gets a
  * bus error instead of returning 0xffffffff. This handler simply returns.
  */
static int
iop3xx_pci_abort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
{
         DBG("PCI abort: address = 0x%08lx fsr = 0x%03x PC = 0x%08lx LR 
= 0x%08lx\n",
                 addr, fsr, regs->ARM_pc, regs->ARM_lr);

         /*
          * If it was an imprecise abort, then we need to correct the
          * return address to be _after_ the instruction.
          */
         if (fsr & (1 << 10))
                 regs->ARM_pc += 4;

         return 0;
}

I suggest we document this as done in plat-iop. Let me know as I need to 
post my
v2 of the patch this week that incorporates all the comments so far on v1.

Murali
