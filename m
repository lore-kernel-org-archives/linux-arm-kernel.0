From: robherring2@gmail.com (Rob Herring)
Date: Mon, 05 Nov 2012 15:48:18 -0600
Subject: [PATCH v2] ARM: plat-versatile: move FPGA irq driver to
 drivers/irqchip
In-Reply-To: <20121102121556.GV21164@n2100.arm.linux.org.uk>
References: <1351805329-19576-1-git-send-email-linus.walleij@linaro.org>
 <20121101232010.78269291@skate>
 <20121102121556.GV21164@n2100.arm.linux.org.uk>
Message-ID: <50983422.9090301@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/2012 07:15 AM, Russell King - ARM Linux wrote:
> On Thu, Nov 01, 2012 at 11:20:10PM +0100, Thomas Petazzoni wrote:
>> Linus,
>>
>> On Thu,  1 Nov 2012 22:28:49 +0100, Linus Walleij wrote:
>>
>>> +void fpga_handle_irq(struct pt_regs *regs);
>>
>> This function does not need to be exposed in a public header: as
>> proposed for the bcm2835 and armada-370-xp IRQ controller drivers, the
>> driver should directly do handle_arch_irq = fpga_handle_irq, and
>> therefore there is no need for the machine desc structure to reference
>> fpga_handle_irq anymore.
> 
> Err no, then you don't understand what's going on here.  This may or may
> not be a top-level IRQ handler.  Some ARM platforms have three of these
> cascaded, others have one of these cascaded off a VIC or GIC.
> 
> To override the top level IRQ handler unconditionally is going to break
> platforms.

But this should work:

if (!handle_arch_irq)
	handle_arch_irq = fpga_handle_irq;

As long as the primary controller is always initialized first, this will
work. This is guaranteed by DT of_irq_init, and you will probably have
other problems if that wasn't the case for non-DT.

Rob
