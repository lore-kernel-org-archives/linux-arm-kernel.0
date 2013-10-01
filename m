From: r.sricharan@ti.com (Sricharan R)
Date: Tue, 1 Oct 2013 16:43:45 +0530
Subject: [RFC PATCH 0/6] DRIVERS: IRQCHIP: Add support for crossbar IP
In-Reply-To: <52499441.1030403@gmail.com>
References: <1380549564-31045-1-git-send-email-r.sricharan@ti.com>
 <52499441.1030403@gmail.com>
Message-ID: <524AAE69.8060703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 30 September 2013 08:39 PM, Rob Herring wrote:
> On 09/30/2013 08:59 AM, Sricharan R wrote:
>> Some socs have a large number of interrupts requests to service
>> the needs of its many peripherals and subsystems. All of the interrupt
>> requests lines from the subsystems are not needed at the same
>> time, so they have to be muxed to the controllers appropriately.
>> In such places a interrupt controllers are preceded by an
>> IRQ CROSSBAR that provides flexibility in muxing the device interrupt
>> requests to the controller inputs.
>>
>> This series models the peripheral interrupts that can be routed through
>> the crossbar to the GIC as 'routable-irqs'. The routable irqs are added
>> in a separate linear domain inside the GIC. The registered routable domain's
>> callback are invoked as a part of the GIC's callback, which in turn should
>> allocate a free irq line and configure the IP accordingly. So every peripheral
>> in the dts files mentions the fixed crossbar number as its interrupt. A free
>> gic line for that gets allocated and configured when the peripheral's interrupt
>> is mapped.
>>
>> The minimal crossbar driver to track and allocate free GIC lines and configure the
>> crossbar is added here, along with the DT bindings.
> Seems like interrupt-map property is what you need here.
>
> http://devicetree.org/Device_Tree_Usage#Advanced_Interrupt_Mapping
>
> Versatile Express also has an example.
   OK, but the idea was not to tie up the crossbar<->interrupt numbers at the
   DTS level, but to assign it dynamically during runtime. This was one of the
  comments that came up with first crossbar support patches, which was assigning a
  interrupt line to crossbar number in the DTS and setting it up in crossbar probe.

    https://lkml.org/lkml/2013/7/18/416

   Since this approach of assigning in DTS was opposed, we moved to IRQCHIP and
   that did not go as well. Finally was asked to handle this as a part of GIC driver with
   a separate domain.
   
  http://www.spinics.net/lists/linux-omap/msg97085.html
  
Regards,
 Sricharan

 
