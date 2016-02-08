From: s-anna@ti.com (Suman Anna)
Date: Mon, 8 Feb 2016 14:23:34 -0600
Subject: [PATCH 1/2] Documentation: dt: mailbox: Add TI Message Manager
In-Reply-To: <20160208193706.GA333@rob-hp-laptop>
References: <1454690044-2560-1-git-send-email-nm@ti.com>
 <1454690044-2560-2-git-send-email-nm@ti.com>
 <20160208193706.GA333@rob-hp-laptop>
Message-ID: <56B8F946.9060301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 02/08/2016 01:37 PM, Rob Herring wrote:
> On Fri, Feb 05, 2016 at 10:34:03AM -0600, Nishanth Menon wrote:
>> Message Manager is a hardware block used to communicate with various
>> processor systems within certain Texas Instrument's Keystone
>> generation SoCs.
>>
>> This hardware engine is used to transfer messages from various compute
>> entities(or processors) within the SoC. It is designed to be self
>> contained without needing software initialization for operation.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>>  .../bindings/mailbox/ti,message-manager.txt        | 72 ++++++++++++++++++++++
>>  1 file changed, 72 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt b/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
>> new file mode 100644
>> index 000000000000..f3d73b0b3c66
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
>> @@ -0,0 +1,72 @@
>> +Texas Instruments' Message Manager Driver
>> +========================================
>> +
>> +The Texas Instruments' Message Manager is a mailbox controller that has
>> +configurable queues selectable at SoC(System on Chip) integration. The Message
>> +manager is broken up into queues in different address regions that are called
>> +"proxies" - each instance is unidirectional and is instantiated at SoC
>> +integration level to indicate receive or transmit path.
>> +
>> +Message Manager Device Node:
>> +===========================
>> +
>> +Required properties:
>> +--------------------
>> +- compatible:		Shall be:
>> +				"ti,k2g-message-manager"
>> +				"ti,message-manager"
> 
> Given that queues are configurable at integration time, does a generic 
> property really make sense here?
> 
>> +- reg-names 		queue_proxy_region - Map the queue Proxy region
>> +			queue_state_debug_region - Map the queue state debug
>> +			region.
>> +- reg:			Contains the register map per reg-names
>> +- #mbox-cells		Shall be 1
> 
> And the value contained is what?
> 
>> +
>> +Child Nodes:
>> +============
>> +A child node is used for representing the actual queue device that is
>> +used for the communication between the host processor and a remote processor.
>> +Each child node should have a unique node name across all the different
>> +message manager device nodes.
>> +
>> +Required Properties:
>> +--------------------
>> +- ti,queue-id:		Indicates the queue number this node represents
>> +- ti,proxy-id:		Proxy ID representing the processor in the SoC.
> 
> What determines these values?
> 
>> +
>> +Optional Properties:
>> +--------------------
>> +- interrupt-names:	'rx' - indicates a receive interrupt (mandatory ONLY if
>> +			this is a receive queue)
> 
> Kind of pointless if there is only 1.
> 
>> +- interrupts:		Contains the interrupt information corresponding to
>> +			interrupt-names property.
>> +
>> +Example:
>> +--------
>> +
>> +	msgmgr: msgmgr at 02a00000 {
>> +		compatible = "ti,k2g-message-manager", "ti,message-manager";
>> +		#mbox-cells = <1>;
>> +		reg-names = "queue_proxy_region", "queue_state_debug_region";
>> +		reg = <0x02a00000 0x400000>, <0x028c3400 0x400>;
>> +
>> +		msgmgr_proxy_pmmc_tx_prio0: pmmc_tx_prio0 {
>> +			ti,queue-id = <0>;
>> +			ti,proxy-id = <0>;
>> +		};
>> +
>> +		msgmgr_proxy_pmmc_rx: pmmc_rx {
>> +			ti,queue-id = <5>;
>> +			ti,proxy-id = <2>;
>> +			interrupt-names = "rx";
>> +			interrupts = <GIC_SPI 324 IRQ_TYPE_EDGE_RISING>;
>> +		};
>> +	};
>> +
>> +...
>> +	pmmc {
>> +		...
>> +		mbox-names = "tx", "rx";
>> +		mboxes = <&msgmgr &msgmgr_proxy_pmmc_tx>
>> +			 <&msgmgr &msgmgr_proxy_pmmc_rx>;
> 
> While I guess this is valid DT, it is a bit strange having the cell 
> values be phandles. Why not just make the queue and proxy ids be the 
> cell values? The interrupts could be moved to the parent and the child 
> nodes eliminated altogether.

The mailbox controller node (msgmgr) and its child nodes all are
registered with the mailbox core together and the client users request a
mailbox using the framework API that requires the controller node.
Usually the channels are given numbers and the request is done based on
indices, but that meant that we had to introduce a logical device id
just for the sake of the API. Instead, we just chose to go with the
phandles.

Doing a queue and proxy id as cell values requires the mailbox
controller node registration phase to parse through all the client nodes
with the matching controller node. The current approach was in-line with
how all the mailbox controller nodes are implemented today, except for
the usage of phandle instead of an index for the cell-value.

> 
> The alternative would be just drop msgmgr phandle and point to the child 
> nodes. I prefer getting rid of the child nodes though.

The 'mboxes' property is a standard property supported by the mailbox
framework core, and requires the phandle of the controller node along
with a cell-value to lookup a channel. So, we cannot use the child nodes
directly.

regards
Suman
