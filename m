From: afzal@ti.com (Mohammed, Afzal)
Date: Tue, 10 Jul 2012 13:47:03 +0000
Subject: [PATCH v5 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
In-Reply-To: <20120710131734.GV1122@atomide.com>
References: <20120703081746.GJ1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A2BAC@DBDE01.ent.ti.com>
 <20120704075158.GQ1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A35E1@DBDE01.ent.ti.com>
 <20120705105535.GB1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A39DF@DBDE01.ent.ti.com>
 <20120706120533.GU1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A622E@DBDE01.ent.ti.com>
 <20120710094538.GT1122@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A64D0@DBDE01.ent.ti.com>
 <20120710131734.GV1122@atomide.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9A669D@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Tue, Jul 10, 2012 at 18:47:34, Tony Lindgren wrote:
> * Mohammed, Afzal <afzal@ti.com> [120710 03:09]:
> > On Tue, Jul 10, 2012 at 15:15:38, Tony Lindgren wrote:
> > > * Mohammed, Afzal <afzal@ti.com> [120709 23:24]:

> > > > For the peripherals requiring retime, we cannot (as otherwise whatever
> > > > retime does would have to be manually done based on the knowledge of
> > > > boot time gpmc clock period to calculate gpmc timings to be fed to DT)
> > > > pass gpmc timings via device tree, right ?
> > > 
> > > We can still do it when the connected peripheral probe registers with
> > > gpmc.

Were you actually referring to updating kernel view of device tree nodes, and
not the device tree file (not sure whether it is really possible) ?

> > We can, but would it be feasible practically ?, gpmc timings to update in
> > DT for a such a peripheral (requiring retime) can be found out only by
> > manual calculation similar to the way done in retime function (based on
> > peripheral's timings and boot time gpmc clock period), correct ?, Also
> > wouldn't this make it necessary to know gpmc clock period at boot time
> > for properly updating gpmc timing entry in DT ?
> 
> The gpmc clock period can be returned to the connected peripheral when
> it's registering. Well basically we can call the retime function upon
> registering and pass the gpmc clock period.

Won't this lead to the necessity of particular driver load order problem ?,
As per the above, to return gpmc clock period to the connected peripheral,
we need to ensure that gpmc driver is probed before peripheral driver.
And in that case how can gpmc driver rely on DT as gpmc timings for the
peripheral requiring retime would not yet be available as peripheral
driver is not yet probed, seems like a circular dependency.

>  
> > And in this case, we are going to register retime function, so instead of
> > relying on DT to provide gpmc timings for such a peripheral, won't it
> > be better to make use of retime that is already registered ?
> 
> No we need to pass the timings from device tree as they may be different
> for similar boards. For example, different level shifters used on
> similar boards may affect the timings, although the retime function
> can be the same.

Unless I am missing something, could not see this scenario taken care
in the existing retime functions, did see one comment for smc91x, but
seems in that case Kernel doesn't do any timing configuration and
leave timings as configured by bootloader

Regards
Afzal
