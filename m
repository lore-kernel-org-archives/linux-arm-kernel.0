From: will.deacon@arm.com (Will Deacon)
Date: Tue, 15 Sep 2015 19:40:03 +0100
Subject: [PATCH] PCI: generic: Add support for Cavium ThunderX PCIe root
 complexes.
In-Reply-To: <1442016439-7636-1-git-send-email-ddaney.cavm@gmail.com>
References: <1442016439-7636-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20150915184003.GS31157@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 12, 2015 at 01:07:19AM +0100, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> The config space for external PCIe root complexes on some Cavium
> ThunderX SoCs is very similar to CAM and ECAM, but differs in the
> shift values that have to be applied to the bus and devfn numbers to
> compose that address window offset.  These root complexes also have
> the interesting property that there is no root bridge, so the standard
> manner of limiting scanning to only the first device doesn't work.  We
> can use the standard pci-host-generic driver if we make a minor
> addition to handle these differences, so we...
> 
> Add a mapping function for ThunderX PCIe root complexes with a bus
> shift of 24 and devfn shift of 16.  Ignore accesses for devices other
> than the first device on the primary bus.
> 
> Document the whole thing in devicetree/bindings/pci/host-generic-pci.txt
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
> 
> This patch depends on the set I recently sent:
> https://lkml.org/lkml/2015/9/11/764
> 
>  .../devicetree/bindings/pci/host-generic-pci.txt   |  5 +++-
>  drivers/pci/host/pci-host-generic.c                | 29 ++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.txt b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> index daa6942..51cc1d1 100644
> --- a/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> @@ -16,7 +16,10 @@ Properties of the host controller node:
>  
>  - compatible     : Must be "pci-host-cam-generic" or "pci-host-ecam-generic"
>                     depending on the layout of configuration space (CAM vs
> -                   ECAM respectively).
> +                   ECAM respectively). Also supported is
> +                   "cavium,pci-host-thunder-pem" which has bus:devfn:reg in
> +                   bits 24:16:0 respectively of the PCI config space address
> +                   window.

It's probably easier to read and maintain if we reword this as a list of
property + comment rather than continue the freeform text.

Other than that, I'm fine with special-casing your accessors if need-be.

Will
