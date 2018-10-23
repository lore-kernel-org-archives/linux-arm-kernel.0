From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Tue, 23 Oct 2018 13:47:56 +0530
Subject: [PATCH v2 00/10] Add support for TISCI irqchip drivers
In-Reply-To: <942981b8-7536-2b6b-ad49-dc59671cbda6@oracle.com>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
 <942981b8-7536-2b6b-ad49-dc59671cbda6@oracle.com>
Message-ID: <050161aa-a257-9bf8-b3c9-35b13925b556@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

On Tuesday 23 October 2018 02:09 AM, Santosh Shilimkar wrote:
> On 10/18/2018 8:40 AM, Lokesh Vutla wrote:
>> TISCI abstracts the handling of IRQ routes where interrupt sources
>> are not directly connected to host interrupt controller. This series
>> adds support for:
>> - TISCI commands needed for IRQ configuration
>> - Interrupt Router(INTR) and Interrupt Aggregator(INTA) drivers
>>
>> More information on TISCI IRQ management can be found here[1].
>> Complete TISCI resource management information can be found here[2].
>> AM65x SoC related TISCI information can be found here[3].
>> INTR and INTA related information can be found in TRM[4].
>>
> I didn't read the specs but from what you described in
> INTA and INTR bindings, does the flow of IRQs like below ?
> 
> Device IRQ(e.g USB) -->INTR-->INTA--->HOST IRQ controller(GIC)

Not all devices in SoC are connected to INTA. Only the devices that are capable 
of generating events are connected to INTA. And INTA is connected to INTR.

So there are three ways in which IRQ can flow in AM65x SoC:
1) Device directly connected to GIC
	- Device IRQ --> GIC
	- (Most legacy peripherals like MMC, UART falls in this case)
2) Device connected to INTR.
	- Device IRQ --> INTR --> GIC
	- This is cases where you want to mux IRQs. Used for GPIOs and Mailboxes
	- (This is somewhat similar to crossbar on DRA7 devices)
3) Devices connected to INTA.
	- Device Event --> INTA --> INTR --> GIC
	- Used for DMA and networking devices.

Events are messages based on a hw protocol, sent by a master over a dedicated 
Event transport lane. Events are highly precise that no under/over flow of data 
transfer occurs at source/destination regardless of distance and latency. So 
this is mostly preferred in DMA and networking usecases. Now Interrupt 
Aggregator(IA) has the logic to converts these events to Interrupts.

Thanks and regards
Lokesh
