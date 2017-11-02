From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 2 Nov 2017 11:19:22 -0700
Subject: [PATCH net-next 4/8] net: ethernet: add the Alpine Ethernet driver
In-Reply-To: <8023db8c8218450fb6c97049db054989@EX13D13UWA001.ant.amazon.com>
References: <20170203181216.30214-1-antoine.tenart@free-electrons.com>
 <20170203181216.30214-5-antoine.tenart@free-electrons.com>
 <20170203205823.GA22572@lunn.ch> <1503841641816.62526@amazon.com>
 <20170828180932.GG10418@lunn.ch>
 <8023db8c8218450fb6c97049db054989@EX13D13UWA001.ant.amazon.com>
Message-ID: <723d35ce-aaa2-9011-19d6-99e77eed846f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/2017 09:05 AM, Chocron, Jonathan wrote:
>  -----Original Message-----
>> From: Andrew Lunn [mailto:andrew at lunn.ch]
>> Sent: Monday, August 28, 2017 9:10 PM
>> To: Chocron, Jonathan <jonnyc@amazon.com>
>> Cc: Antoine Tenart <antoine.tenart@free-electrons.com>;
>> netdev at vger.kernel.org; davem at davemloft.net; linux-arm-
>> kernel at lists.infradead.org; thomas.petazzoni at free-electrons.com;
>> arnd at arndb.de
>> Subject: Re: [PATCH net-next 4/8] net: ethernet: add the Alpine Ethernet
>> driver
>>
>> On Sun, Aug 27, 2017 at 01:47:19PM +0000, Chocron, Jonathan wrote:
>>> This is a fixed version of my previous response (using proper indentation
>> and leaving only the specific questions responded to).
>>
>> Wow, this is old.  3 Feb 2017. I had to go dig into the archive to refresh my
>> memory.
>>
>>>>> +/* MDIO */
>>>>> +#define AL_ETH_MDIO_C45_DEV_MASK     0x1f0000
>>>>> +#define AL_ETH_MDIO_C45_DEV_SHIFT    16
>>>>> +#define AL_ETH_MDIO_C45_REG_MASK     0xffff
>>>>> +
>>>>> +static int al_mdio_read(struct mii_bus *bp, int mii_id, int reg)
>>>>> +{
>>>>> +     struct al_eth_adapter *adapter = bp->priv;
>>>>> +     u16 value = 0;
>>>>> +     int rc;
>>>>> +     int timeout = MDIO_TIMEOUT_MSEC;
>>>>> +
>>>>> +     while (timeout > 0) {
>>>>> +             if (reg & MII_ADDR_C45) {
>>>>> +                     netdev_dbg(adapter->netdev, "[c45]: dev %x reg %x val
>> %x\n",
>>>>> +                                ((reg & AL_ETH_MDIO_C45_DEV_MASK) >>
>> AL_ETH_MDIO_C45_DEV_SHIFT),
>>>>> +                                (reg & AL_ETH_MDIO_C45_REG_MASK), value);
>>>>> +                     rc = al_eth_mdio_read(&adapter->hw_adapter, adapter-
>>> phy_addr,
>>>>> +                             ((reg & AL_ETH_MDIO_C45_DEV_MASK) >>
>> AL_ETH_MDIO_C45_DEV_SHIFT),
>>>>> +                             (reg & AL_ETH_MDIO_C45_REG_MASK), &value);
>>>>> +             } else {
>>>>> +                     rc = al_eth_mdio_read(&adapter->hw_adapter, adapter-
>>> phy_addr,
>>>>> +                                           MDIO_DEVAD_NONE, reg, &value);
>>>>> +             }
>>>>> +
>>>>> +             if (rc == 0)
>>>>> +                     return value;
>>>>> +
>>>>> +             netdev_dbg(adapter->netdev,
>>>>> +                        "mdio read failed. try again in 10
>>>>> + msec\n");
>>>>> +
>>>>> +             timeout -= 10;
>>>>> +             msleep(10);
>>>>> +     }
>>>>
>>>> This is rather unusual, retrying MDIO operations. Are you working
>>>> around a hardware bug? I suspect this also opens up race conditions,
>>>> in particular with PHY interrupts, which can be clear on read.
>>>
>>> The MDIO bus is shared between the ethernet units. There is a HW lock
>>> used to arbitrate between different interfaces trying to access the
>>> bus, therefore there is a retry loop. The reg isn't accessed before
>>> obtaining the lock, so there shouldn't be any clear on read issues.
>>>
>>>>> +/* al_eth_mdiobus_setup - initialize mdiobus and register to
>>>>> +kernel */ static int al_eth_mdiobus_setup(struct al_eth_adapter
>>>>> +*adapter) {
>>>>> +     struct phy_device *phydev;
>>>>> +     int i;
>>>>> +     int ret = 0;
>>>>> +
>>>>> +     adapter->mdio_bus = mdiobus_alloc();
>>>>> +     if (!adapter->mdio_bus)
>>>>> +             return -ENOMEM;
>>>>> +
>>>>> +     adapter->mdio_bus->name     = "al mdio bus";
>>>>> +     snprintf(adapter->mdio_bus->id, MII_BUS_ID_SIZE, "%x",
>>>>> +              (adapter->pdev->bus->number << 8) | adapter->pdev-
>>> devfn);
>>>>> +     adapter->mdio_bus->priv     = adapter;
>>>>> +     adapter->mdio_bus->parent   = &adapter->pdev->dev;
>>>>> +     adapter->mdio_bus->read     = &al_mdio_read;
>>>>> +     adapter->mdio_bus->write    = &al_mdio_write;
>>>>> +     adapter->mdio_bus->phy_mask = ~BIT(adapter->phy_addr);
>>>>
>>>> Why do this?
>>>
>>> Since the MDIO bus is shared, we want each interface to probe only for the
>> PHY associated with it.
>>
>> So i think this is the core of the problem. You have one physical MDIO bus,
>> yet you register it twice with the MDIO framework.
>>
>> How about you only register it once? A lot of the complexity then goes away.
>> The mutex in the mdio core per bus means you don't need your hardware
>> locking. All that code goes away. All the retry code goes away. Life is simple.
>>
>> 	Andrew
> 
> We indeed have one physical MDIO bus, but have multiple masters on it,
> each "behind" a different internal PCIe device. Since the accesses to the bus
> are done "indirectly" through each master, we can't register the bus only once.

How do your multiple masters get arbitrated on the unique MDIO bus? Is
there hardware automatically doing that, or do you have to semaphore
those accesses at the software level?

> Think of the scenario that we register it in the driver context of PCIe device A,
> and then the driver is unbound from just this device. Device B won't be able
> to access the bus since it was registered with callbacks that use a PCIe BAR of
> device A, which is no longer valid.

You can have one single physical MDIO bus that you register once
throughout the SoC's power on lifecycle, and then you can create
"virtual" MDIO bus instances which map 1:1 with the PCIe device/function
and are nested from that single MDIO bus, this also gives you
serialization of accesses and arbitration for free.

> 
> Is it possible to register the mdio_bus struct as a global instance at driver load,
> and someway pass the offset to the specific device's MDIO master, as part of
> each read/write transaction towards the MDIO bus?

You can register how many instances of the MDIO bus you want in a
system, it can be a singleton for the purpose of supporting your
specific hardware, or you can build a layer on top like I just suggested
above.

> Or perhaps you have another suggestion which takes into account the issues I've described?

Considering that binding to a MDIO bus is done by MDIO bus name
(bus->id) and/or Device Tree parent/child hierarchy, if there is only
one, just have all instances reference the same MDIO bus when they want
to bind to their devices (pure mdio_device, or phy_device) on that MDIO bus.
-- 
Florian
