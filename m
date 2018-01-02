From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 02 Jan 2018 09:22:37 -0800
Subject: [net-next: PATCH v2 5/5] net: mvpp2: enable ACPI support in the
 driver
In-Reply-To: <CAPv3WKdD0HwdFVOBx-yeTCfcMF7DXxxFaUt+Zm06oxuVuty8Rg@mail.gmail.com>
References: <1514721520-18964-1-git-send-email-mw@semihalf.com>
 <1514721520-18964-6-git-send-email-mw@semihalf.com>
 <20171231192354.GB20455@lunn.ch>
 <CAPv3WKdr8MaPJi1_PnMfmmk3PeSrJBLUoE8gRCEzwbJsMKBaZg@mail.gmail.com>
 <20180102133347.GB15036@lunn.ch>
 <CAPv3WKfB6_5hPw2M_GOMHVc_soPyzgMqQJ=tG5qOfSe_397z9A@mail.gmail.com>
 <20180102140852.GE15036@lunn.ch>
 <CAPv3WKdD0HwdFVOBx-yeTCfcMF7DXxxFaUt+Zm06oxuVuty8Rg@mail.gmail.com>
Message-ID: <F28C325E-AF06-45A6-B492-6F0F6C546509@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On January 2, 2018 7:05:35 AM PST, Marcin Wojtas <mw@semihalf.com> wrote:
>2018-01-02 15:08 GMT+01:00 Andrew Lunn <andrew@lunn.ch>:
>>> Indeed in of_mdio_bus_register_phy, there is of_irq_get. This is
>more
>>> a discussion for a MDIO bus / ACPI patchset, but we either find a
>way
>>> to use IRQs with ACPI obtained from child nodes or for this world
>the
>>> functionality will be limited (at least for the beginning).
>>
>> Hi Marcin
>>
>> What i want to avoid is adding something which partially works, and
>> then have to throw it all away and start again in order to add full
>> support.
>>
>> If ACPI really limits interrupts to devices, maybe we need a totally
>> different representation of MDIO and PHYs in ACPI to what it used in
>> device tree? The same may be true for the Ethernet ports of the
>mvpp2?
>> They might have to be represented as real devices, not children of a
>> device? Maybe trying to map DT to ACPI on a one-to-one basis is the
>> wrong approach?
>>
>
>In terms of PP2 controller, I'd prefer to keep as much as possible to
>describing how real hardware looks like, i.e. single common controller
>with multiple ports as its children. Those considerations are
>reflected in the DT description shape and how the driver enumerates,
>which was part of the design of the initial support. Bending the
>driver (huge amount of shared initialization and resources) to
>multiple instances just for the sake of possible avoidance of IRQ
>description in ACPI is IMO a huge and unnecessary overkill.

True, although keep in mind that Device Tree, as implemented in Linux allows for a lot of flexibility in how parent/child nodes are represented and backed or not by a corresponding struct device. I suspect ACPI is much less permissive than that and we might want to have a struct device for the whole mvpp2 controller as well as for the child ports within that controller (something you could today with device tree too, just it would be more overhead). This does not necessarily have to influence the representation within the description language but we should not be biased by how the current implementation using Device Tree has shaped both representation and implementation.

-- 
Florian
