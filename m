From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 10 Apr 2017 11:39:42 +0100
Subject: [PATCH] arm64/dts: fix legacy interrupt routing for AMD Seattle
In-Reply-To: <20170407111733.18828-1-ard.biesheuvel@linaro.org>
References: <20170407111733.18828-1-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu-C0Zvo-3YJQEnsPCLQwQxzNMdMT4YQG7_RyDTfNZjvvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(+ Rob)

On 7 April 2017 at 12:17, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> The Seattle SOC internally supports 3 PCIe slots, although only two
> are wired up on the Overdrive board. For each of those slots, a bank
> of four GIC interrupts is allocated, the legacy PCI interrupts INTA,
> INTB, INTC and INTD.
>
> So fix the interrupt-map property in the Seattle SOC DTS to reflect
> this, and provide three separate mappings for the three bridge devices
> connecting to each of the three slots.
>
> Tested on Cello with the MSI bits removed from the DT. This board has
> the following PCI topology
>
> -[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD] Device 1a00
>            +-02.0  Advanced Micro Devices, Inc. [AMD] Device 1a01
>            +-02.2-[01]----00.0  uPD720202 USB 3.0 Host Controller
>            \-02.3-[02]----00.0  Realtek R8169 PCIe Gigabit Ethernet Controller
>
> and ends up using the following legacy interrupts with MSI disabled
>
>  36:    GICv2 324 Edge      PCIe PME, xhci-hcd:usb1
>  37:    GICv2 328 Edge      PCIe PME, enp2s0
>

Actually, while this routing is correct for the NIC and USB
controllers (and results in a working system), the PME interrupts are
routed incorrectly, given that all functions on the bridge device
route their own interrupts to INTA.

So question to the AMD folk (if they aren't filtering emails with
'Seattle' in the subject line): which legacy interrupt is INTA of the
bridge device wired to?

And question to the DT 'camp': assuming that 02.1, 02.2 and 02.3 all
use the same INTA interrupt, which may be different from the legacy
interrupts wired to the slots behind the respective bridges, is there
a way to describe this in the interrupt-map property?



> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 23 +++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
> index bd3adeac374f..4679e4f2c985 100644
> --- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
> +++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
> @@ -212,12 +212,25 @@
>                         msi-parent = <&v2m0>;
>                         reg = <0 0xf0000000 0 0x10000000>;
>
> -                       interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
> +                       interrupt-map-mask = <0xff00 0x0 0x0 0x7>;
>                         interrupt-map =
> -                               <0x1000 0x0 0x0 0x1 &gic0 0x0 0x0 0x0 0x120 0x1>,
> -                               <0x1000 0x0 0x0 0x2 &gic0 0x0 0x0 0x0 0x121 0x1>,
> -                               <0x1000 0x0 0x0 0x3 &gic0 0x0 0x0 0x0 0x122 0x1>,
> -                               <0x1000 0x0 0x0 0x4 &gic0 0x0 0x0 0x0 0x123 0x1>;
> +                               /* slot 1: dev 2 fn 1 */
> +                               <0x1100 0x0 0x0 0x1 &gic0 0x0 0x0 0x0 0x120 0x1>,
> +                               <0x1100 0x0 0x0 0x2 &gic0 0x0 0x0 0x0 0x121 0x1>,
> +                               <0x1100 0x0 0x0 0x3 &gic0 0x0 0x0 0x0 0x122 0x1>,
> +                               <0x1100 0x0 0x0 0x4 &gic0 0x0 0x0 0x0 0x123 0x1>,
> +
> +                               /* slot 2: dev 2 fn 2 */
> +                               <0x1200 0x0 0x0 0x1 &gic0 0x0 0x0 0x0 0x124 0x1>,
> +                               <0x1200 0x0 0x0 0x2 &gic0 0x0 0x0 0x0 0x125 0x1>,
> +                               <0x1200 0x0 0x0 0x3 &gic0 0x0 0x0 0x0 0x126 0x1>,
> +                               <0x1200 0x0 0x0 0x4 &gic0 0x0 0x0 0x0 0x127 0x1>,
> +
> +                               /* slot 3: dev 2 fn 3 */
> +                               <0x1300 0x0 0x0 0x1 &gic0 0x0 0x0 0x0 0x128 0x1>,
> +                               <0x1300 0x0 0x0 0x2 &gic0 0x0 0x0 0x0 0x129 0x1>,
> +                               <0x1300 0x0 0x0 0x3 &gic0 0x0 0x0 0x0 0x12a 0x1>,
> +                               <0x1300 0x0 0x0 0x4 &gic0 0x0 0x0 0x0 0x12b 0x1>;
>
>                         dma-coherent;
>                         dma-ranges = <0x43000000 0x0 0x0 0x0 0x0 0x100 0x0>;
> --
> 2.9.3
>
