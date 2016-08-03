From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 3 Aug 2016 11:33:19 +0530
Subject: Support for configurable PCIe endpoint
Message-ID: <57A18927.9070003@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The PCIe controller present in TI's DRA7 SoC is capable of operating either in
Root Complex mode or Endpoint mode. (It uses Synopsys Designware Core).I'd
assume most of the PCIe controllers on other platforms that use Designware core
should also be capable to operate in endpoint mode. But linux kernel right now
supports only RC mode.

PCIe endpoint support discussion came up briefly before [1] but it was felt the
practical use case will find firmware more suitable and endpoint support in
kernel can be used only for validation or demo.

Validation or demo is itself a valid use case in my opinion (consider something
similar to gadget zero for USB). There can be other use cases as well. The RC
can use the SoC with EP mode support as an accelerator to accomplish specific
task. Here RC gives data to the EP. The EP processes the data. The processing
can be done either in ARM itself or it can use other hardware accelerators
(like DSP, IVA-HD etc..) present in the EP system. If HW accelerator is used,
the linux kernel running in ARM can be used to accomplish other tasks. Once EP
mode support is added, I think more use cases will be added.

>From the high level this should look _similar_ to the gadget framework of USB.
One difference from USB would be this should allow HW components (like DSP, PRU
etc.. and maybe even some peripheral) in the EP system to be used by RC system.

So these are the high-level steps that I thought would be needed to add EP
support in linux.
*) move pcie-designware.c out of drivers/pci/host (maybe create a
drivers/pci/designware/ folder?). All users of pcie-designware.c should be
moved here.
This is in preparation for adding EP mode support to designware.

*) Add library functions in pcie-designware.c specific to EP mode like
initializing general ecam registers, BAR registers etc.. These functions should
be invoked from a *function* driver (function driver should determine the use
of a particular EP).

*) Add a sample *function* driver that can be used just for validation. This
function driver will invoke the previously added functions in PCIe controller
to initialize ecam, BAR etc.. This will invoke the PCIe controller functions
through *ep-core* layer. That way the same function driver can be made to work
with different PCIe controllers. (A PCIe driver corresponding to this function
driver should also be implemented in RC side)

*) Add *ep-core* layer to bind the function driver to the controller driver and
using which the function driver will invoke controller driver callbacks (to
initialize ecam, BAR registers etc..)

*) Modify platform driver to support EP mode (in my case pci-dra7xx.c).

*) dt binding specific to EP mode should be created.

Once I complete the implementation and start posting RFC patches, a lot of
these will become clear. But I want to check if this sounds okay to you guys
before starting the implementation.

Let me know if you have some other ideas too.

Cheers
Kishon

[1] -> http://www.spinics.net/lists/linux-pci/msg26026.html
