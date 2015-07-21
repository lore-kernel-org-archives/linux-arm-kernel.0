From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 21 Jul 2015 23:37:34 +0200 (CEST)
Subject: [PATCH V5 1/2] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
 sources
In-Reply-To: <BL2PR03MB370168620C55576F4A7750683840@BL2PR03MB370.namprd03.prod.outlook.com>
References: <1437150300-8134-1-git-send-email-shenwei.wang@freescale.com>
 <1437150300-8134-2-git-send-email-shenwei.wang@freescale.com>
 <alpine.DEB.2.11.1507172253520.18576@nanos>
 <BL2PR03MB370B72098E511CFE551588B83840@BL2PR03MB370.namprd03.prod.outlook.com>
 <alpine.DEB.2.11.1507211827150.18576@nanos>
 <BL2PR03MB370168620C55576F4A7750683840@BL2PR03MB370.namprd03.prod.outlook.com>
Message-ID: <alpine.DEB.2.11.1507212324230.18576@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Jul 2015, Shenwei Wang wrote:
> > On Tue, 21 Jul 2015, Shenwei Wang wrote:
> > > This struct defines the properties and functions that GPCv2 block
> > > provides. Since GPCv2 has two key functions: Irq wakeup source
> > > management and power management, the intention of the struct is to
> > > share data and methods among irqchip, suspend, and cpuidle drivers.
> > 
> > I don't think this is a good idea. The cpuidle driver has nothing to know about the
> > internals of the irq driver and vice versa. Neither does the suspend code.
> > 
> > If you failed to split that proper then your design is wrong.
> > 
> The implementation has already been spitted totally. The question is
> if we use the same structure among those drivers or not, since they
> do share some common data like gpc_base address, enabled_irq, and
> mfmix_mask. The suspend and cpuidle driver will use those data to
> decide the hardware power modes and the relating power down sequence
> of the power domains. The structure is the abstract of the GPCv2
> hardware, and the current struct declaration matches the low level
> hardware well. Although it is possible and easy to split it into
> two, it may introduce either redundant definition for the common
> properties or have to create a global variable to enable them
> visible to both the irqchip and the suspend codes.

So the proper way to do this is:

Have a data structure which contains only the shared information. The
pointer to this structure can be global.

Have per driver data structures which contain the driver private
stuff.

Think about whether you need all the function pointers in one of the
structs. IOW, you need them only if a pointer can be changed at
runtime. If not you can call the function directly as I doubt that any
of these drivers can be modular.

Thanks,

	tglx
