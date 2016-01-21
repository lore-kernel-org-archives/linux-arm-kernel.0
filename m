From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Jan 2016 09:41:20 +0100
Subject: [PATCH v3 1/1] USB: core: let USB device know device node
In-Reply-To: <20160121031524.GA29893@shlinux2>
References: <4405270.vcz87Q878u@wuerfel> <5639398.uJHXq6DsMC@wuerfel>
 <20160121031524.GA29893@shlinux2>
Message-ID: <1989217.907WTZoGvq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 January 2016 11:15:24 Peter Chen wrote:
> 
> Just adding from device driver view and change the name from "roohub" to
> "port".
> 
> It is the port number (1-9), but not the root hub number.
> 
> At the most of embedded platforms, we have only one port per controller.
> For example, at the non-hub boards, if there are two Standard-A ports,
> there are from two different USB controllers.
> But for Alan's case, it has six ports, and all from the one USB controller,
> port 1 to port 6 are from the HS root hub, port 7 to port 9 are from the SS
> root hub.
> 
> For the single port controller platform, the dts will be like below, port_1 is
> under the HS root hub, port_2 is under the SS root hub.
> 
> &usb1 {
>         port_1: nxp at 1 {
>                 compatible = "usb15a2,007d";
>                 reg = <0x01>;
> 
>                 hub: genesys at 1 {
>                         compatible = "usb05e3,0608";
>                         reg = <0x01>;
>                 };
>         };
> 
>         port_2: nxp at 2 {
>                 compatible = "usb15a2,007d";
>                 reg = <0x02>;
> 
>                 hub: genesys at 1 {
>                         compatible = "usb05e3,0608";
>                         reg = <0x01>;
>                 };
>         };
> };

But why are you modeling ports of the root hub as hubs themselves?

I would expect the example above to look like

&usb1 {
        hub at 1 {
                compatible = "usb05e3,0608";
                reg = <0x01>;
        };

	hub at 2 {
                compatible = "usb05e3,0608";
                reg = <0x01>;
        };
};

So two hubs at ports 1 and 2 of the USB controller that integrates
the root hub and shares a device node with it.

	Arnd
