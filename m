From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Feb 2016 14:47:29 +0000
Subject: [PATCH v3] irqchip: irq-mvebu-odmi: new driver for platform MSI
 on Marvell 7K/8K
In-Reply-To: <20160219142848.GA958@io.lakedaemon.net>
References: <1455888883-5127-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <56C72392.5010202@arm.com> <20160219142848.GA958@io.lakedaemon.net>
Message-ID: <56C72B01.4060005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/02/16 14:28, Jason Cooper wrote:
> On Fri, Feb 19, 2016 at 02:15:46PM +0000, Marc Zyngier wrote:
>> On 19/02/16 13:34, Thomas Petazzoni wrote:
>>> This commits adds a new irqchip driver that handles the ODMI
>>> controller found on Marvell 7K/8K processors. The ODMI controller
>>> provide MSI interrupt functionality to on-board peripherals, much like
>>> the GIC-v2m.
>>>
>>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>>> ---
>>> Changes v2 -> v2:
>>>  - Express NODMIS_SHIFT, NODMIS_PER_FRAME, NODMIS_MASK in term of each
>>>    other. Suggested by Marc Zyngier.
>>>  - Rework the global bitmask allocation to make sure we allocate a
>>>    number of longs rather than a number of bytes, to avoid having the
>>>    bitmap API (which operates on longs) access memory we haven't
>>>    explicitly allocated. Reported by Marc Zyngier.
>>>
>>> Changes v1 -> v2:
>>>  - Better commit title, as suggested by Marc Zyngier.
>>>  - Improve the DT binding documentation, as suggested by Marc Zingier:
>>>    add a reference to the GIC documentation, be more specific about
>>>    the marvell,spi-base values, and add the requirement of the
>>>    interrupt-parent property.
>>>  - As suggested by Marc Zyngier, use a single global bitmap to
>>>    allocate all ODMIs, regardless of the frame they belong to. As part
>>>    of this change, the hwirq used to identify the interrupt inside the
>>>    ODMI irqdomain are 0-based (instead of being based on their
>>>    corresponding SPI base value), which allows to significantly
>>>    simplify the allocation/free logic.
>>> ---
>>>  .../marvell,odmi-controller.txt                    |  41 ++++
>>>  drivers/irqchip/Kconfig                            |   4 +
>>>  drivers/irqchip/Makefile                           |   1 +
>>>  drivers/irqchip/irq-mvebu-odmi.c                   | 248 +++++++++++++++++++++
>>>  4 files changed, 294 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,odmi-controller.txt
>>>  create mode 100644 drivers/irqchip/irq-mvebu-odmi.c
>>
>> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
>>
>> I'll queue that for 4.6.
> 
> I had it on my list to queue up, but you beat me to it.  :-)

Ah, sorry! The reason I was eager to queue it is because I have some
related changes in the GIC/GICv2m department, simplifying a few things
there:

http://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/gic-4.6&id=9b29f74f6b4b56aa4bb5cc91474aa2451de5c628

I'll post this on the list later today.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
