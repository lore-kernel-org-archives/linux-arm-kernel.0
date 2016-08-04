From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 4 Aug 2016 14:19:07 +0530
Subject: Support for configurable PCIe endpoint
In-Reply-To: <20160803094747.GA10170@infradead.org>
References: <57A18927.9070003@ti.com> <20160803094747.GA10170@infradead.org>
Message-ID: <57A30183.2060800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 03 August 2016 03:17 PM, Christoph Hellwig wrote:
> On Wed, Aug 03, 2016 at 11:33:19AM +0530, Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> The PCIe controller present in TI's DRA7 SoC is capable of operating either in
>> Root Complex mode or Endpoint mode. (It uses Synopsys Designware Core).I'd
>> assume most of the PCIe controllers on other platforms that use Designware core
>> should also be capable to operate in endpoint mode. But linux kernel right now
>> supports only RC mode.
>>
>> PCIe endpoint support discussion came up briefly before [1] but it was felt the
>> practical use case will find firmware more suitable and endpoint support in
>> kernel can be used only for validation or demo.
> 
> I disagree.  It's highly useful for rapid prototyping of hardware
> interfaces, and I've been looking into PCIe EP drivers for exactly
> that reason recently.  Going a little offtopic: any good DRA7 eval
> boards you'd recommend to try for this purpose?

I think the only publicly available DRA7 based board with PCIe (mPCIe slot) is
AM572x EVM (http://www.ti.com/tool/TMDSEVM572X). The board comes only with a
female PCIe slot. So a special cable would be required to connect it to a PCIe
host.

However for my development I'm planning to use dra7-evm which has standard
female PCIe connector and I'll use a cable like PE-FLEX1 male-to-male (in
http://www.adexelec.com/pciexp.htm) to connect back-to-back boards.
> 
> We already have a EP driver in the tree:
> 
> drivers/misc/spear13xx_pcie_gadget.c
> 
> but as far as I can tell it doesn't really work at the moment.

Okay. I wasn't aware of that. I'll take a look at that one.
> 
>> Validation or demo is itself a valid use case in my opinion (consider something
>> similar to gadget zero for USB). There can be other use cases as well. The RC
>> can use the SoC with EP mode support as an accelerator to accomplish specific
>> task. Here RC gives data to the EP. The EP processes the data. The processing
>> can be done either in ARM itself or it can use other hardware accelerators
>> (like DSP, IVA-HD etc..) present in the EP system. If HW accelerator is used,
>> the linux kernel running in ARM can be used to accomplish other tasks. Once EP
>> mode support is added, I think more use cases will be added.
> 
> That sounds useful as well.
> 
>> >From the high level this should look _similar_ to the gadget framework of USB.
>> One difference from USB would be this should allow HW components (like DSP, PRU
>> etc.. and maybe even some peripheral) in the EP system to be used by RC system.
> 
> Indeed.
> 
>> So these are the high-level steps that I thought would be needed to add EP
>> support in linux.
>> *) move pcie-designware.c out of drivers/pci/host (maybe create a
>> drivers/pci/designware/ folder?). All users of pcie-designware.c should be
>> moved here.
>> This is in preparation for adding EP mode support to designware.
> 
> I'd use a new drivers/pci/controller.  Or maybe just skip the rename
> for now and see how this evolves.

Sure. That makes more sense.
> 
> The rest of the plan sounds fine to me.

cool.

Thanks
Kishon
