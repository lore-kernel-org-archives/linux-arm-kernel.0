From: julien.grall@arm.com (Julien Grall)
Date: Tue, 5 Jul 2016 15:02:19 +0100
Subject: [PATCH v2] xen/arm: register clocks used by the hypervisor
In-Reply-To: <577BBC1A.8020209@arm.com>
References: <1467282752-14053-1-git-send-email-dirk.behme@de.bosch.com>
 <alpine.DEB.2.10.1607051449370.2575@sstabellini-ThinkPad-X260>
 <577BBC1A.8020209@arm.com>
Message-ID: <577BBDEB.7000305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/07/16 14:54, Julien Grall wrote:
>
>
> On 05/07/16 14:53, Stefano Stabellini wrote:
>> On Thu, 30 Jun 2016, Dirk Behme wrote:
>>> +- clocks: one or more clocks to be registered.
>>> +  Xen hypervisor drivers might replace native drivers, resulting in
>>> +  clocks not registered by these native drivers. To avoid that these
>>> +  unregistered clocks are disabled, then, e.g. by clk_disable_unused(),
>>> +  register them in the hypervisor node.
>>> +  An example for this are the clocks of the serial driver. If the
>>> clocks
>>> +  used by the serial hardware interface are not registered by the
>>> serial
>>> +  driver the serial output might stop once clk_disable_unused() is
>>> called.
>>
>> What if we use the "status" property of the clocks? Could we set it to
>> "disabled" in Xen? Would that be enough for Linux to leave them alone?
>
> clocks could be shared between multiple devices. So it is not possible
> to disable the clock.

To give an example, below the UART node for juno 
(arch/arm64/boot/dts/arm/juno-base.dtsi):

         soc_uart0: uart at 7ff80000 {
                 compatible = "arm,pl011", "arm,primecell";
                 reg = <0x0 0x7ff80000 0x0 0x1000>;
                 interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
                 clocks = <&soc_uartclk>, <&soc_refclk100mhz>;
                 clock-names = "uartclk", "apb_pclk";
         };

The clock soc_refclk100mhz is shared with the mailbox.

Regards,

-- 
Julien Grall
