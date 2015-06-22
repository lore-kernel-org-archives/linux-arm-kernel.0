From: tharvey@gateworks.com (Tim Harvey)
Date: Mon, 22 Jun 2015 06:34:37 -0700
Subject: IMX6 - PCIe device tree assignments
In-Reply-To: <m34mm5tj4b.fsf@t19.piap.pl>
References: <m34mm5tj4b.fsf@t19.piap.pl>
Message-ID: <CAJ+vNU098bwhdhBPrnCWOy83=oCD0vP+7sRxVcpSGYNu52HDsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 3:18 AM, Krzysztof Ha?asa <khalasa@piap.pl> wrote:
> Hello,
>
> The situation: Gateworks Ventana with IMX6q, 8-port PCIe bridge (PLX
> tech PEX 8609), two PCIe devices behind the bridge (one of those is an
> Ethernet controller).
>
> The Ethernet controller lacks EEPROM/etc. and it's MAC address has to be
> initialized using the device tree.
>
> IMX6                      [1]           PEX [2]
> -[0000:00]---00.0-[01-0a]--+-00.0-[02-0a]--+-01.0-[03]--
>                            |               +-04.0-[04]----00.0
>                            |               +-05.0-[05]--
>                            |               +-06.0-[06-07]----00.0-[07]--
>                            |               +-07.0-[08]----00.0
>                            |               +-08.0-[09]----00.0 Ethernet
>                            |               \-09.0-[0a]--
>                            \-00.1 (PEX special device)
>
> Gateworks have the following patch for this (and the MAC address
> assignment works):
>
> --- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
> @@ -369,8 +369,42 @@
>         reset-gpio = <&gpio1 29 GPIO_ACTIVE_LOW>;
>         status = "okay";
>
> -       eth1: sky2 at 8 { /* MAC/PHY on bus 8 */
> -               compatible = "marvell,sky2";
> +       pcie at 0,0 {
> +               /* 00:00.0 0604: 16c3:abcd root host-bridge */
> +               #address-cells = <3>;
> +               #size-cells = <2>;
> +               device_type = "pci";
> +               reg = <0x0 0 0 0 0>;
> +
> +               pcie at 0,0 {
> +                       /* 01:00.0 0604: 10b5:8609 PEX switch bridge */
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +                       device_type = "pci";
> +                       reg = <0x0 0 0 0 0>;
> +
> +                       /*
> +                        * GigE PCI dev node needs to be defined so that enet
> +                        * driver can use it to obtain its boot-loader
> +                        * specified MAC
> +                        */
> +                       pcie at 8,0 {
> +                               /* 02:08.0 0604: 10b5:8609: PEX port bridge */
> +                               #address-cells = <3>;
> +                               #size-cells = <2>;
> +                               device_type = "pci";
> +                               reg = <0x4000 0 0 0 0>;
> +
> +                               eth1: pci at 0,0 {
> +                                       /* 08:00.0 0200: 11ab:4380: GigE */
> +                                       #address-cells = <3>;
> +                                       #size-cells = <2>;
> +                                       device_type = "pci";
> +                                       reg = <0x0 0 0 0 0>;
> +                                       compatible = "marvell,sky2";
> +                               };
> +                       };
> +               };
>         };
>  };
>
> Unfortunately the patch has a side effect - it messes up the PCIe
> interrupts. Basically all PCI IRQs except for the special device handled
> internally by the PEX 8609 bridge are set to 155:
>
>                                       good    bad (with patch)
> 00:00.0 PCI bridge: (IMX6 host bridge)
>         Interrupt: pin A routed to IRQ 155
> 01:00.0 PCI bridge: PEX-8609
>         Interrupt: pin A routed to IRQ 155
> 01:00.1 System peripheral: PEX-8609
>         Interrupt: pin B routed to IRQ 154 (not changed)
> 02:01.0 PCI bridge: PEX-8609
>         Interrupt: pin A routed to IRQ 154 -> 155
> 02:04.0 PCI bridge: PEX-8609
>         Interrupt: pin A routed to IRQ 155
> 02:05.0 PCI bridge: PEX-8609
>         Interrupt: pin A routed to IRQ 154 -> 155
> 02:06.0 PCI bridge: PEX-8609
>         Interrupt: pin A routed to IRQ 153 -> 155
> 02:07.0 PCI bridge: PEX-8609
>         Interrupt: pin A routed to IRQ 152 -> 155
> 02:08.0 PCI bridge: PEX-8609
>         Interrupt: pin A routed to IRQ 155
> 02:09.0 PCI bridge: PEX-8609
>         Interrupt: pin A routed to IRQ 154 -> 155
> 04:00.0 Techwell Device 6864
>         Interrupt: pin A routed to IRQ 155
> 06:00.0 PCI bridge
> 08:00.0 Techwell Device 6869
>         Interrupt: pin A routed to IRQ 152 -> 155
> 09:00.0 Ethernet controller
>         Interrupt: pin A routed to IRQ 155
>
> This is the case with v3.18 + the Ventana patchset from Gateworks, and
> with vanilla v4.0 with only the above DT patch applied.
>
> The question is: what's wrong in the patch, and how do I fix it?
> --
> Krzysztof Halasa
>
> Industrial Research Institute for Automation and Measurements PIAP
> Al. Jerozolimskie 202, 02-486 Warsaw, Poland

Krzysztof,

I became aware of the interrupt mapping side-effect recently of this
downstream patch as well. I believe the issue is that the pci nodes
need to be fully described including the interrupt* properties. My
plan is to address this with a bootloader fixup which will dynamically
build the device-tree representation of the pcie nodes on the bus
(because some boards have PCI switches with differing number of
ports).

For now, do not use the down-stream patch and assign the mac addresses
in a different fashion if using mainline linux on the GW54xx/GW53xx.
You can contact support at gateworks.com for more information on how to
obtain the MAC addr's from the board's EEPROM.

Regards,

Tim
