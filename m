From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 07 Dec 2015 09:47:43 +0100
Subject: [RFC PATCH 4/4] mfd: syscon: add ACPI support
In-Reply-To: <56652409.8070905@huawei.com>
References: <1449047368-5768-1-git-send-email-wangkefeng.wang@huawei.com>
 <20151203155612.GA2935@red-moon> <56652409.8070905@huawei.com>
Message-ID: <2666629.mh0RnUHbhb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 December 2015 14:15:37 Kefeng Wang wrote:
> On 2015/12/3 23:56, Lorenzo Pieralisi wrote:
> > On Thu, Dec 03, 2015 at 09:01:11PM +0800, Kefeng Wang wrote:
> >> Hi Graeme, Arnd, and Lorenzo,
> >>
> >> Firstly, we absolutely agree with the point which use AML to do some "special"
> >> initialisation and configuration.
> > 
> > Good.
> > 
> >> SAS and NIC driver were accepted by linux in hisilicon hip05 chip, and the drivers
> >> reset the control by syscon, we want to use "_RST" method, which is introduced by
> >> ACPI 6.0 spec in "7.3.25 _RST (Device Reset)", is it reasonable and standard for us?
> > 
> > Can you point me at the drivers you are referring to please ?
> 
> SAS? https://lkml.org/lkml/2015/11/17/572
>       [PATCH v5 19/32] scsi: hisi_sas: add v1 HW initialisation code
>       static int reset_hw_v1_hw(struct hisi_hba *hisi_hba);
> 
> HNS? drivers/net/ethernet/hisilicon/hns_mdio.c
>       static int hns_mdio_reset(struct mii_bus *bus)?

It seems that there is some commonality in here that there is more than
one device reset in this system control unit.

I'd suggest moving this out into a proper reset driver that of course
then has to be based on syscon for DT based systems so it doesn't conflict
with the other random stuff in the syscon space, and for backwards
compatibiltiy with old kernels that only know about the syscon based reset
you have currently implemented.

If there are additional devices that also use the same syscon node for
reset, they should of course only use the device_reset() method.

> >> But here is a scene, we can not find a suitable way to support ACPI. There is no
> >> independent memory region in some module(the driver not upstreamed), that is,
> >> when write and read the module's register, we must r/w by syscon. Any advice?
> > 
> > What do you mean ? You mean that the reset control is a piece of HW
> > that is shared between multiple "components" ? What's your concern
> > about AML code driving those registers here ?
> 
> This is unrelated to reset control.
> 
> I mean we have some driver(not upstreamed), like LLC(last level cache), when access the register
> of llc, we need help through syscon, because the llc has no independent registers region , steps
> of Read and Write register in those drivers is shown below,
> 
>  1) get the syscon base;
>  2) configure and choose the module which need to be accessed;
>  3) R/W the value from the syscon, that is, get/set the value from/to llc;
> 
> Every read and write the register in those drivers, we must through syscon. That is why we need
> syscon to support ACPI.

last level cache is something that should go through architecture code,
it has no business in syscon anyway. What do you control with this anyway?
AFAIK, ARMv8 has architected instructions to control caches and doesn't
need to talk to a cache controller the way we used to do on v6 and older v7
based systems.

	Arnd
