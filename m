From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Mon, 22 Jun 2015 14:21:57 -0700
Subject: [PATCH] ARM: keystone: ecc: add ddr3 ecc interrupt handling
In-Reply-To: <55886ECF.9070402@ti.com>
References: <1434654589-28157-1-git-send-email-vitalya@ti.com>
 <558436C1.3050402@oracle.com> <55886ECF.9070402@ti.com>
Message-ID: <55887C75.7080708@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/22/2015 1:23 PM, Murali Karicheri wrote:
> On 06/19/2015 11:35 AM, santosh shilimkar wrote:
>> On 6/18/2015 12:09 PM, Vitaly Andrianov wrote:
>>> This patch adds ARM L1/L2 ECC handler support and DDR3 ECC interrupt
>>> handling for Keystone II devices, the kernel will reboot if the error
>>> is 2-bit error for DDR ECC or L1/L2 ECC error.
>>>
>>> Signed-off-by: Hao Zhang <hzhang@ti.com>
>>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>>> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
>>> ---
>>>   arch/arm/mach-keystone/Makefile       |  2 +-
>>>   arch/arm/mach-keystone/keystone.c     | 63 ++++++++++++++++++++++++--
>>>   arch/arm/mach-keystone/keystone.h     |  1 +
>>>   arch/arm/mach-keystone/keystone_ecc.c | 85
>>> +++++++++++++++++++++++++++++++++++
>>>   arch/arm/mach-keystone/platsmp.c      |  3 +-
>>>   5 files changed, 148 insertions(+), 6 deletions(-)
>>>   create mode 100644 arch/arm/mach-keystone/keystone_ecc.c
>>>
>>
>>> +/* DDR3 controller registers */
>>> +#define DDR3_EOI            0x0A0
>>> +#define DDR3_IRQ_STATUS_RAW_SYS        0x0A4
>>> +#define DDR3_IRQ_STATUS_SYS        0x0AC
>>> +#define DDR3_IRQ_ENABLE_SET_SYS        0x0B4
>>> +#define DDR3_IRQ_ENABLE_CLR_SYS        0x0BC
>>> +#define DDR3_ECC_CTRL            0x110
>>> +#define DDR3_ONE_BIT_ECC_ERR_CNT    0x130
>>> +
>>> +#define DDR3_1B_ECC_ERR            BIT(5)
>>> +#define DDR3_2B_ECC_ERR            BIT(4)
>>> +#define DDR3_WR_ECC_ERR            BIT(3)
>>> +
>>> +static irqreturn_t ddr3_ecc_err_irq_handler(int irq, void *reg_virt)
>>> +{
>>> +    int ret = IRQ_NONE;
>>> +    u32 irq_status;
>>> +    void __iomem *ddr_reg = (void __iomem *)reg_virt;
>>> +
>>> +    irq_status = readl(ddr_reg + DDR3_IRQ_STATUS_SYS);
>>> +    if ((irq_status & DDR3_2B_ECC_ERR) ||
>>> +        (irq_status & DDR3_WR_ECC_ERR)) {
>>> +        pr_err("Unrecoverable DDR3 ECC error, irq status 0x%x,
>>> rebooting kernel ..\n",
>>> +               irq_status);
>>> +        machine_restart(NULL);
>>> +        ret = IRQ_HANDLED;
>>> +    }
>>> +    return ret;
>>> +}
>>> +
>>> +int keystone_init_ddr3_ecc(struct device_node *node)
>>> +{
>>> +    void __iomem *ddr_reg;
>>> +    int error_irq = 0;
>>> +    int ret;
>>> +
>>> +    /* ddr3 controller reg is configured in the sysctrl node at index
>>> 0 */
>>> +    ddr_reg = of_iomap(node, 0);
>>> +    if (!ddr_reg) {
>>> +        pr_warn("Warning!! DDR3 controller regs not defined\n");
>>> +        return -ENODEV;
>>> +    }
>>> +
>>> +    /* add DDR3 ECC error handler */
>>> +    error_irq = irq_of_parse_and_map(node, 1);
>>> +    if (!error_irq) {
>>> +        /* No GIC interrupt, need to map CIC2 interrupt to GIC */
>>> +        pr_warn("Warning!! DDR3 ECC irq number not defined\n");
>>> +        return -ENODEV;
>>> +    }
>>> +
>> You should probably check here if there is already an ECC error happened
>> till you reach here and take appropriate action. If its not safe to
>> boot because of double bit error, you need to abort the boot.
>
> Santosh,
>
> How is this any different from the case when ECC error interrupt happen
> while the system is running? I would imagine the system can run the
> handler if the software can make it this far and handled uniformly
> through the handler in both cases.
>
Right. Both approaches have chances of failures though the IRQ
triggered error has to execute lot more code before arriving at
that conclusion thank just reading the register and doing it.

More over, its usually a good practice to clear the residual status
of any hardware IRQ in init before you enable it.

Regards,
Santosh
