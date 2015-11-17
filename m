From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Nov 2015 23:00:18 +0100
Subject: [PATCH] USB: USB_OTG does not depend on PM
In-Reply-To: <874mgkjoh2.fsf@saruman.tx.rr.com>
References: <7521777.8ZmnT3AlIC@wuerfel> <874mgkjoh2.fsf@saruman.tx.rr.com>
Message-ID: <5647698.81XCu85L5D@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 November 2015 15:38:33 Felipe Balbi wrote:
> 
> Arnd Bergmann <arnd@arndb.de> writes:
> > USB_OTG initially depended on USB_SUSPEND, which was later turned into
> > PM_RUNTIME and finally into PM. I don't know at what point the dependency
> > became unnecessary but it appears to work fine without CONFIG_PM now.
> >
> > However, we get lots of warnings in randconfig kernels like:
> >
> > warning: (USB_OTG_FSM && FSL_USB2_OTG && USB_MV_OTG) selects USB_OTG which has unmet direct dependencies (USB_SUPPORT && USB && PM)
> >
> > whenever CONFIG_PM is disabled and something else selects USB_OTG.
> > Let's just drop the dependency to avoid the warnings.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > I keep seeing this one in my ARM randconfig test
> 
> and how did you test this ? Did you make sure you're not breaking HNP ?
> For HNP to happen we depend on a bus_suspend and bus_suspend is only
> available on CONFIG_PM, unless that has changed.
> 
> Seems like you've only compile tested this patch, is that correct ?

Yes, I compile-tested only and inspected the code briefly without finding
anything that contradicted this. It seems I missed the important part
as you say, so we should instead add 'depends on PM' for the other
symbols.

	Arnd
