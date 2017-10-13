From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 13 Oct 2017 11:51:52 -0500
Subject: [PATCH 1/3] Documentation/devicetree: Add pcie-reset-suspend
 property
In-Reply-To: <20171012205220.130048-2-briannorris@chromium.org>
References: <20171012205220.130048-1-briannorris@chromium.org>
 <20171012205220.130048-2-briannorris@chromium.org>
Message-ID: <20171013165152.GE25517@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+cc Doug]

On Thu, Oct 12, 2017 at 01:52:18PM -0700, Brian Norris wrote:
> The patch is self-descriptive. I've found that we may need
> platform-specific behavior for the PERST# signal in system suspend,
> depending on the type of PCIe endpoints are attached.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  Documentation/devicetree/bindings/pci/pci.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
> index c77981c5dd18..91339b6d0652 100644
> --- a/Documentation/devicetree/bindings/pci/pci.txt
> +++ b/Documentation/devicetree/bindings/pci/pci.txt
> @@ -24,3 +24,14 @@ driver implementation may support the following properties:
>     unsupported link speed, for instance, trying to do training for
>     unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
>     for gen2, and '1' for gen1. Any other values are invalid.
> +- pcie-reset-suspend:
> +   If present this property defines whether the PCIe Reset signal (referred to
> +   as PERST#) should be asserted when the system enters low-power suspend modes
> +   (e.g., S3). Depending on the form factor, the associated PCIe
> +   electromechanical specification may specify a particular behavior (e.g.,
> +   "PERST# is asserted in advance of the power being switched off in a
> +   power-managed state like S3") or it may be less clear. The net result is
> +   that some endpoints perform better (e.g., lower power consumption) with
> +   PERST# asserted, and others prefer PERST# deasserted. The value must be '0'
> +   or '1', where '0' means do not assert PERST# and '1' means assert PERST#.
> +   When absent, behavior may be platform-specific.

I don't understand this at all.  Are you suggesting that we need
different "pcie-reset-suspend" values based on what sort of endpoint
the user plugs in?

If so, I really don't want to get involved in that, because that's an
issue that needs to be resolved by the vendors and the PCI-SIG.  If we
put in a tweak like this, I think it would be a band-aid that only
delays getting a real solution figured out.

If you want a quirk to tune this based on specific devices, that might
make sense.  It would still sound like an interoperability issue and
an ongoing maintenance problem, but at least we would have specific
details about which devices are involved, and we'd have a chance to
make them work on more controllers than just Rockchip.

Bjorn
