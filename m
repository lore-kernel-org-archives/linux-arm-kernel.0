From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Fri, 28 Apr 2017 09:12:57 +0000
Subject: [PATCH net-next 1/4] ixgbe: sparc: rename the
 ARCH_WANT_RELAX_ORDER to IXGBE_ALLOW_RELAXED_ORDER
In-Reply-To: <MWHPR12MB1600CB0756EA24211C93E053C8100@MWHPR12MB1600.namprd12.prod.outlook.com>
References: <20170401.112603.1991545644693496714.davem@davemloft.net>
 <42428725-89f1-1508-4e3d-723e087b3bbb@huawei.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E205199C0@FRAEML521-MBX.china.huawei.com>
 <063D6719AE5E284EB5DD2968C1650D6DCFFD3C52@AcuExch.aculab.com>
 <DB5PR05MB138288172B04713EB0C1DB55D3190@DB5PR05MB1382.eurprd05.prod.outlook.com>
 <a2239141-a185-1bb8-0abd-7a05b9fde015@huawei.com>
 <CAKgT0Uc4L=GgYbpO-Fm9OfN+_fLypbDP1c+X4T_ta90ecQiyGQ@mail.gmail.com>,
 <20170427171938.GA10705@bhelgaas-glaptop.roam.corp.google.com>
 <MWHPR12MB1600CB0756EA24211C93E053C8100@MWHPR12MB1600.namprd12.prod.outlook.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E205620E4@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Casey

Many thanks for the detailed explanation

> -----Original Message-----
> From: Casey Leedom [mailto:leedom at chelsio.com]
> Sent: 27 April 2017 21:35
> To: Bjorn Helgaas; Alexander Duyck
> Cc: Dingtianhong; Mark Rutland; Amir Ancel; Gabriele Paoloni; linux-
> pci at vger.kernel.org; Catalin Marinas; Will Deacon; Linuxarm; David
> Laight; jeffrey.t.kirsher at intel.com; netdev at vger.kernel.org; Robin
> Murphy; davem at davemloft.net; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH net-next 1/4] ixgbe: sparc: rename the
> ARCH_WANT_RELAX_ORDER to IXGBE_ALLOW_RELAXED_ORDER
> 
> | From: Bjorn Helgaas <helgaas@kernel.org>
> | Sent: Thursday, April 27, 2017 10:19 AM
> |
> | Are you hinting that the PCI core or arch code could actually
> *enable*
> | Relaxed Ordering without the driver doing anything?  Is it safe to do
> that?
> | Is there such a thing as a device that is capable of using RO, but
> where the
> | driver must be aware of it being enabled, so it programs the device
> | appropriately?
> 
>   I forgot to reply to this portion of Bjorn's email.
> 
>   The PCI Configuration Space PCI Capability Device Control[Enable
> Relaxed
> Ordering] bit governs enabling the _ability_ for the PCIe Device to
> send
> TLPs with the Relaxed Ordering Attribute set.  It does not _cause_ RO
> to be
> set on TLPs.  Doing that would almost certainly cause Data Corruption
> Bugs
> since you only want a subset of TLPs to have RO set.
> 
>   For instance, we typically use RO for Ingress Packet Data delivery
> but
> non-RO for messages notifying the Host that an Ingress Packet has been
> delivered.  This ensures that the "Ingress Packet Delivered" non-RO TLP
> is
> processed _after_ any preceding RO TLPs delivering the actual Ingress
> Packet
> Data.
> 
>   In the above scenario, if one were to turn off Enable Relaxed
> Ordering via
> the PCIe Capability, then the on-chip PCIe engine would simply never
> send a
> TLP with the Relaxed Ordering Attribute set, regardless of any other
> chip
> programming.
> 
>   And finally, just to be absolutely clear, using Relaxed Ordering
> isn't and
> "Architecture Thing".  It's a PCIe Fabric End Point Thing.  Many End
> Points
> simply ignore the Relaxed Ordering Attribute (except to reflect it back
> in
> Response TLPs).  In this sense, Relaxed Ordering simply provides
> potentially useful optimization information to the PCIe End Point.

I think your view matches what I found out about the current usage of the
"Enable Relaxed Ordering" bit in Linux mainline: i.e. looking at where and
why the other drivers set/clear the "Enable Relaxed Ordering" they do not
look for any global symbol, nor they look at the host architecture.

So with respect to this specific ixgbe driver I guess the main question is
why RO was disabled by default by Intel for this EP (commit 3d5c520727ce
mentions issues with "some chipsets"), then why it is safe to enable it back
on SPARC....?

Thanks
Gab

> 
> Casey
