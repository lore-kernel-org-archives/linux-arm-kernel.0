From: mike.leach@linaro.org (Mike Leach)
Date: Wed, 28 Nov 2018 15:01:28 +0000
Subject: [RFC PATCH v2 1/3] drivers: amba: Updates to component
 identification for driver matching.
In-Reply-To: <69964a55-733a-0e45-7584-70c56ad52c2b@arm.com>
References: <20181128101423.15961-1-mike.leach@linaro.org>
 <20181128101423.15961-2-mike.leach@linaro.org>
 <16a3cb27-bc7c-36ff-d8fd-bac17f5fc28d@arm.com>
 <69964a55-733a-0e45-7584-70c56ad52c2b@arm.com>
Message-ID: <CAJ9a7Vjv0fN=26Y5A17v2N6=qZP+2QYVbgJXA_Kee5D4vxn7gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Suzuki
On Wed, 28 Nov 2018 at 10:55, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
>
>
> On 28/11/2018 10:44, Suzuki K Poulose wrote:
> > Hi Mike,
> >
> > On 28/11/2018 10:14, Mike Leach wrote:
> >> The CoreSight specification (ARM IHI 0029E), updates the ID register
> >> requirements for components on an AMBA bus, to cover both traditional
> >> ARM Primecell type devices, and newer CoreSight and other components.
> >>
> >> The Peripheral ID (PID) / Component ID (CID) pair is extended in certain
> >> cases to uniquely identify components. CoreSight components related to
> >> a single function can share Peripheral ID values, and must be further
> >> identified using a Unique Component Identifier (UCI). e.g. the ETM, CTI,
> >> PMU and Debug hardware of the A35 all share the same PID.
> >>
> >> Bits 11:8 of the CID are defined to be the device class.
> >> Class 0xF remains for PrimeCell and legacy components.
> >> Class 0x9 defines the component as CoreSight (CORESIGHT_CID above)
> >> Class 0x0, 0x1, 0xB, 0xE define components that do not have driver
> >> support
> >> at present.
> >> Class 0x2-0x8,0xA and 0xD-0xD are presently reserved.
> >>
> >> The specification futher defines which classes of device use the standard
> >> CID/PID pair, and when additional ID registers are required.
> >>
> >> The patches provide an update of amba_device and matching code to handle
> >> the additional registers required for the Class 0x9 (CoreSight) UCI.
> >> The *data pointer in the amba_id is used by the driver to provide
> >> extended
> >> ID register values for matching.
> >>
> >> CoreSight components where PID/CID pair is currently sufficient for
> >> unique identification need not provide this additional information.
> >>
> >> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> >> ---
> >>   drivers/amba/bus.c       | 49 +++++++++++++++++++++++++++++++++-------
> >>   include/linux/amba/bus.h | 32 ++++++++++++++++++++++++++
> >>   2 files changed, 73 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> >> index 41b706403ef7..387ee8f7720b 100644
> >> --- a/drivers/amba/bus.c
> >> +++ b/drivers/amba/bus.c
> >> @@ -26,19 +26,40 @@
> >>   #define to_amba_driver(d)    container_of(d, struct amba_driver, drv)
> >> -static const struct amba_id *
> >> -amba_lookup(const struct amba_id *table, struct amba_device *dev)
> >> +/* called on periphid match and class 0x9 coresight device. */
> >> +static int
> >> +amba_cs_uci_id_match(const struct amba_id *table, struct amba_device
> >> *dev)
> >>   {
> >>       int ret = 0;
> >> +    struct amba_cs_uci_id *uci;
> >> +
> >> +    uci = table->data;
> >> +
> >> +    /* no table data - return match on periphid */
> >> +    if (!uci)
> >> +        return 1;
>
> Additionally, I see that the DEVARCH defines bit 20 to specify if the
> register is valid or not. So, do you think we should check if the device
> has the devarch set and the driver has not provided a matching UCI data
> and WARN us to detect such problems in the future ?
>
> i.e,
>
>         if (!uci) {
>                 WARN(dev->uci.devarch & UCI_DEVARCH_PRESENT,
>                      "Missing UCI match data for PID: %08x, devarch: %08x\n",
>                         dev->periphid, dev->uci.devarch);
>                 return 1;
>         }
>

I hadn't considered this, but I am trying to get this patch set not to
break existing values.
There are currently SoCs that have CS devices that all uniquely
identify themselves using the CID / PID values, which also implement
DEVARCH.
(e.g. DB410 Dragonboard has DEVARCH in the ETMv4, but also has unique
PID for the ETMs - so has but does not need UCI for driver binding)

I'd rather avoid a slew of new warnings on stuff that currently works
and allow UCI to work when required on newer silicon.

Cheers

Mike

>
> Cheers
> Suzuki



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
