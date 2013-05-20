From: itooo@itooo.com (Greg)
Date: Mon, 20 May 2013 18:25:46 +0200
Subject: mvebu: mbus device tree binding
In-Reply-To: <20130520124420.GA3030@localhost>
References: <20130520123153.GA2904@localhost> <20130520124420.GA3030@localhost>
Message-ID: <519A4E8A.80608@itooo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 20/05/2013 14:44, Ezequiel Garcia a ?crit :
> Hi,
>
> Adding Jason to the discussion.
>
> On Mon, May 20, 2013 at 09:31:53AM -0300, Ezequiel Garcia wrote:
>> Hello Arnd and Jason,
>>
>> Let's advance with the DT binding for mvebu-mbus,
>> and perhaps have it ready for v3.11.
>>
>> Our current approach to the mbus-windows allocation is as follows:
>>
>> 1. Every device is located as a child of the soc/internal-regs node.
>>     The DT contains information for the assigned address space,
>>     encoded in the 'ranges' property, like this:
>>
>>     soc {
>>     
>>     	ranges =  < internal-regs
>>          	    PCIe
>> 		    NOR
>> 		    ... >;
>>     	internal-regs {
>> 		...
>>     	};
>>     }
>>
>>
>> 2. Each driver is in charge of allocating the mbus windows, using
>>     the mbus API and the address region obtained through the information
>>     on the device tree.
>>
>> Now, this approach is particularly error-prone because of (1). The
>> 'ranges' entry in a given .dtsi file is overrided by the 'ranges'
>> in the per-board .dts file. So, when if we need to declare a node for a
>> NOR device, we need to duplicate all ranges entries from the parent
>> .dtsi files.
>>
>> This does not seem to be hugely problematic, for one could put the
>> 'ranges' property only in the per-board files, and remove it from the
>> common dtsi.
>>
>> Therefore, first of all I'd like to know:
>>
>> **1** What's so broken with the current approach that makes us seek for
>>        solution, in the form of an mbus DT binding?
>>
>> In addition, reading the previous discussion you've had about this, I
>> noticed Arnd suggested (and even required) that the mbus binding should
>> update the ranges property in the DT blob each time an address window
>> is dynamically allocated.
>>
>> **2** Why is this required? Who will read the updated ranges
>>        information?
>>        Why can't the kernel access the mbus API to obtain information
>>        about currently allocated windows?
>>
>> Those are my questions for now and I'm quite sure many more will come
>> in the future, so please bare with me!
>>
I might be completely off-topic (I'm very new to the discussion) but 
here is my opinion : I would not to let the device drivers configure the 
MBUS if this is possible to avoid. I'd configure the MBUS globally and 
the drivers should just use whatever configuration is applied to the 
MBUS by calling the API.
This would allow a centralized configuration of the MBUS where it is 
easy to find mistakes and conflicts.
This would also place this configuration "deeper" in the DT files, most 
people will not really care about configuring this and don't even need 
to know about this, if this is "hidden" to them, they can focus on what 
they really need to do.

These questions will arise again when implementing the SERDES pins 
multiplexer I guess (I didn't see any code for this yet).

Cheers,
