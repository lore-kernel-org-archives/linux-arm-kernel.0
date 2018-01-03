From: mw@semihalf.com (Marcin Wojtas)
Date: Wed, 3 Jan 2018 14:13:09 +0100
Subject: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
In-Reply-To: <20180103124720.GG15036@lunn.ch>
References: <1513588684-15647-1-git-send-email-mw@semihalf.com>
 <CAKv+Gu8_6y3dU81ZS4WWCfpRZkfjGo_+_K--e3go_3_xXwBErQ@mail.gmail.com>
 <20180103110048.GA21230@xora-haswell>
 <CAPv3WKcM8WWvh64A=FTtuWkEr6V_QSKjBpNpWnMpp_P=cMU9sw@mail.gmail.com>
 <20180103124720.GG15036@lunn.ch>
Message-ID: <CAPv3WKfZN+=9wFJ5ct+8nttd=bikaZ=Ei741pyTVXjQz2zq2dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

2018-01-03 13:47 GMT+01:00 Andrew Lunn <andrew@lunn.ch>:
>> I already agreed with 'reg' being awkward in the later emails.
>> Wouldn't _ADR be more appropriate to specify PHY address on MDIO bus?
>
> Also, how do you specify which MDIO bus the PHY is on. To fully
> specify a PHY, you need both bits of information.
>
> In DT, the phy-handle phandle can point to any PHY anywhere in the
> system. This is particularly important when a Ethernet device has two
> MDIO busses.
>

For now, my local MDIO bus description is pretty DT-like, i.e. master
bus with children PHYs:
        Device (MDIO)
        {
            Name (_HID, "MRVL0100")                             //
_HID: Hardware ID
            Name (_UID, 0x00)                                   //
_UID: Unique ID
            Name (_CRS, ResourceTemplate ()
            {
                Memory32Fixed (ReadWrite,
                    0xf212a200,                                 // Address Base
                    0x00000010,                                 //
Address Length
                    )
            })
            Device (GPHY)
            {
              Name (_ADR, 0x0)
            }
        }

        Device (XSMI)
        {
            Name (_HID, "MRVL0101")                             //
_HID: Hardware ID
            Name (_UID, 0x00)                                   //
_UID: Unique ID
            Name (_CRS, ResourceTemplate ()
            {
                Memory32Fixed (ReadWrite,
                    0xf212a600,                                 // Address Base
                    0x00000010,                                 //
Address Length
                    )
            })
            Device (PHY0)
            {
              Name (_ADR, 0x0)
              Name (_CID, "ethernet-phy-ieee802.3-c45")
            }
            Device (PHY8)
            {
              Name (_ADR, 0x8)
              Name (_CID, "ethernet-phy-ieee802.3-c45")
            }
        }

Which is referenced in the port's node:

Package () { "phy", Package (){\_SB.XSMI.PHY0}},

I'm studying an alternatives with graphs, as suggested by Tomasz
Nowicki, but to me above is pretty natural and not complicated.

Best regards,
Marcin
