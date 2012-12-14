From: robherring2@gmail.com (Rob Herring)
Date: Fri, 14 Dec 2012 13:53:31 -0600
Subject: [RFC 2/5] ARM: dts: Add Cross Trigger Interface binding
In-Reply-To: <50C9120F.7080809@ti.com>
References: <1355348588-22318-1-git-send-email-jon-hunter@ti.com>
 <1355348588-22318-3-git-send-email-jon-hunter@ti.com>
 <50C90153.9070002@gmail.com> <50C9120F.7080809@ti.com>
Message-ID: <50CB83BB.6080901@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2012 05:23 PM, Jon Hunter wrote:
> 
> On 12/12/2012 04:12 PM, Rob Herring wrote:
>> On 12/12/2012 03:43 PM, Jon Hunter wrote:
>>> Adds a device-tree binding for the ARM Cross Trigger Interface (CTI).
>>> The ARM Cross Trigger Interface provides a way to route events between
>>> processor modules. For example, on OMAP4430 we use the CTI module to
>>> route PMU events to the GIC interrupt module.
>>
>> Do you need to describe the PMU-CTI-GIC connection in DT?
> 
> We definitely could. This is achieved by mapping a trigger-input to a
> trigger-output. So we could list the trigger outputs and inputs in the
> binding. For omap4430 we would have ...
> 
> arm,cti-trigin = <0 1 2 3 4 5 6>;

I'd prefer to just spell it out: arm,cti-trigger-in

> arm,cti-trigin-names =  "dbgack", "pmuirq", "ptmextout0",
> 			"ptmextout1", "commtx", "commrx",
> 			"ptmtrigger";
> arm,cti-trigout = <0 1 2 3 4 6 7>;
> arm,cti-trigout-names = "edbgreq", "ptmextin0", "ptmextin1",
> 			"ptmextin2", "ptmextin3","mpuirq",
> 			"dbgrestart";
> 
> So to map the PMU to GIC, we would map the "pmuirq" trigger input to the
> "mpuirq" trigger output. Then we could setup the mapping by name instead
> of index.

I'm not crazy about the name strings and would prefer something with
phandles. The above binding doesn't really describe the connection of
the CTI to the GIC. The GIC node would need to define some inputs and
then you show the connection to the CTI outputs. This may be similar to
an interrupt nexus node.

Rob
