From: mw@semihalf.com (Marcin Wojtas)
Date: Tue, 2 Jan 2018 14:55:39 +0100
Subject: [net-next: PATCH v2 5/5] net: mvpp2: enable ACPI support in the
 driver
In-Reply-To: <20180102133347.GB15036@lunn.ch>
References: <1514721520-18964-1-git-send-email-mw@semihalf.com>
 <1514721520-18964-6-git-send-email-mw@semihalf.com>
 <20171231192354.GB20455@lunn.ch>
 <CAPv3WKdr8MaPJi1_PnMfmmk3PeSrJBLUoE8gRCEzwbJsMKBaZg@mail.gmail.com>
 <20180102133347.GB15036@lunn.ch>
Message-ID: <CAPv3WKfB6_5hPw2M_GOMHVc_soPyzgMqQJ=tG5qOfSe_397z9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

2018-01-02 14:33 GMT+01:00 Andrew Lunn <andrew@lunn.ch>:
>> Apart from the phylink's SFP support that may require in-band
>> management, it's an alternative to the normal PHY handling. Once MDIO
>> bus + PHYs are supported for ACPI, phylib support will be used instead
>> of the IRQs, so there should be no problem here.
>
> Hi Marcin
>
> However, phylib and phylink can use IRQs. The PHY can interrupt when
> there is a change of state. This can be seen in the DT binding
> documentation example:
>
> ethernet-phy at 0 {
>         compatible = "ethernet-phy-id0141.0e90", "ethernet-phy-ieee802.3-c22";
>         interrupt-parent = <&PIC>;
>         interrupts = <35 IRQ_TYPE_EDGE_RISING>;
>         reg = <0>;
>
> Whatever ACPI support you propose needs to include interrupts.
>
> May i suggest you take a look at
> arch/arm/boot/dts/vf610-zii-dev-rev-c.dts and ensure your ACPI work
> can support this. I know you tend to concentrate of Marvell parts.
> Although it is a Freescale SoC, the Ethernet parts are all Marvell.
>
> The SoC exports an MDIO bus. We then have an MDIO multiplexer, which
> exports 8 MDIO busses. Of these only 2 are used in this design. Each
> bus has an Ethernet switch. Each switch has an MDIO bus, which the
> embedded PHYs are on. The Ethernet switch is also an interrupt
> controller for the PHYs interrupts. So the PHYs have interrupt
> properties pointing back to the switch.
>

I thought you were pointing possible problems in mvpp2 with PHY/link
interrupts, sorry. Now I get it :)

Indeed in of_mdio_bus_register_phy, there is of_irq_get. This is more
a discussion for a MDIO bus / ACPI patchset, but we either find a way
to use IRQs with ACPI obtained from child nodes or for this world the
functionality will be limited (at least for the beginning).

Best regards,
Marcin
