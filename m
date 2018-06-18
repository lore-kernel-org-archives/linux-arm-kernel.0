From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 18 Jun 2018 19:16:47 +0300
Subject: [PATCH v2 0/2] Add R8A77980/Condor PCIe support
In-Reply-To: <20180618093623.s33bkiptazxem463@verge.net.au>
References: <b37d458c-071a-833a-2057-be8a07c880be@cogentembedded.com>
 <20180618093623.s33bkiptazxem463@verge.net.au>
Message-ID: <cfa599bd-d244-0032-490b-553f7870d07c@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2018 12:36 PM, Simon Horman wrote:

>> Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
>> 'renesas-devel-20180614v2-v4.17' tag. We're adding the R8A77980 PCIe related
>> device nodes and then enable PCIe on the Condor board. These patches depend
>> on the R8A77980 PCIe PHY driver support in order to work properly. Note that
>> in case the PCIe PHY driver is not enabled, the kernel will BUG() due to I/O
>> space page leak in the PCIe driver...
> 
> Is that problem specific to the presence of PCIe nodes for
> condor/r8a77980

   The nodes are safe unless they are enabled, so the Condor patch may be
deferred untl I fix the PCI code.
> condor/r8a77980 or is it also true of other (R-Car) boards where
> PCIe is enabled?

   The leak happens every time the driver fails to probe later than
pci_remap_iospace() is called but the BUG_ON() is only triggered by rhe 2nd try
with EPROBE_DEFER returned previously.

> Regardless, it sounds like these patches expose a kernel bug.
> Is it being fixed?

   I'm working on a fix (which embraces several PCI drivers)...

>> [1/2] arm64: dts: renesas: r8a77980: add PCIe support
>> [2/2] arm64: dts: renesas: condor: add PCIe support

WBR, Sergei
