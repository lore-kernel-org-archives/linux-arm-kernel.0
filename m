From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 27 Jun 2016 10:08:29 -0600
Subject: [PATCH 03/10] Documentation: dt-bindings: firmware: tegra: add
 bindings of the BPMP
In-Reply-To: <20160627090248.23621-4-josephl@nvidia.com>
References: <20160627090248.23621-1-josephl@nvidia.com>
 <20160627090248.23621-4-josephl@nvidia.com>
Message-ID: <57714F7D.1040301@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2016 03:02 AM, Joseph Lo wrote:
> The BPMP is a specific processor in Tegra chip, which is designed for
> booting process handling and offloading the power management tasks
> from the CPU. The binding document defines the resources that would be
> used by the BPMP firmware driver, which can create the interprocessor
> communication (IPC) between the CPU and BPMP.

> diff --git a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt

> +The BPMP is a specific processor in Tegra chip, which is designed for
> +booting process handling and offloading the power management tasks from
> +the CPU. The binding document defines the resources that would be used by
> +the BPMP firmware driver, which can create the interprocessor
> +communication (IPC) between the CPU and BPMP.

s/power management/power management, clock management, and reset control/?

> +Required properties:
> +- name : Should be bpmp
> +- compatible : Should be "nvidia,tegra<chip>-bpmp"

Again, I'd suggest wording this as:

- compatible
     Array of strings.
     One of:
   - "nvidia,tegra186-bpmp"

> +- mboxes : The phandle of mailbox controller and the channel ID

s/channel ID/mailbox specifier/.

> +           See "Documentation/devicetree/bindings/mailbox/
> +	   nvidia,tegra186-hsp.txt" and "Documentation/devicetree/
> +	   bindings/mailbox/mailbox.txt" for more details about the generic
> +	   mailbox controller and mailbox client driver bindings.

I'd rather not split the filenames across lines, since that makes grep 
fail to match. Perhaps add the following text to the introductory 
section at the start of the file to avoid having to mention some of the 
filenames in an indented block of text:

==========
This node is a mailbox consumer. See the following file for details of 
the mailbox subsystem, and the specifiers implemented by the relevant 
provider(s):

- Documentation/devicetree/bindings/mailbox/mailbox.txt
- Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt

This node is a clock and reset provider. See the following files for 
general documentation of those features, and the specifiers implemented 
by this node:

- Documentation/devicetree/bindings/clock/clock-bindings.txt
- include/dt-bindings/clock/tegra186-clock.h
- Documentation/devicetree/bindings/reset/reset.txt
- include/dt-bindings/reset/tegra186-reset.h
==========

Related, I would expect those two header files (tegra186-clock.h and 
tegra186-reset.h) to be part of this patch, since they form part of the 
definition of this binding.

> +The shared memory bindings for BPMP
> +-----------------------------------
> +
> +The shared memory area for the IPC TX and RX between CPU and BPMP are
> +predefined and work on top of sysram, which is a sram inside the chip.

s/a sram/an SRAM/.

> +Example:
...
> +bpmp at d0000000 {

There should be no unit address ("@d0000000") in the node name, since 
there's no reg property.
