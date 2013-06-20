From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 20 Jun 2013 13:25:31 -0400 (EDT)
Subject: [PATCH V2] USB: initialize or shutdown PHY when add or remove
 host controller
In-Reply-To: <20130620121749.GF9817@arwen.pp.htv.fi>
Message-ID: <Pine.LNX.4.44L0.1306201319580.2063-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Jun 2013, Felipe Balbi wrote:

> > In fact, the PHY setting and handling is related to platform or SOC,
> > and for different SOC they can
> > have same EHCI HCD but they PHY handling can be different.
> > Omap'a case is the example, and i think some other vendors may have
> > silimar cases.
> > From above point, It is better to leave the PHY initialization and
> > shutdown to be done by each echi-xxx driver.
> > 
> > So Alan and Felipe
> > What are your ideas about it?
> 
> If we have so many exceptions, then sure. But eventually, the common
> case should be added generically with a flag so that non-generic cases
> (like OMAP) can request to handle the PHY by themselves.
> 
> Alan ?

I don't have very strong feelings about this; Felipe has much more
experience with these things.

However, when the common case is added into the core, the simplest way
to indicate that the HCD wants to handle the PHY(s) by itself will be
to leave hcd->phy set to NULL or an ERR_PTR value.

One important thing that hasn't been pointed out yet: When we move
these calls into the core, the same patch must also remove those calls
from the glue drivers that currently do set hcd->phy.  And it must make
sure that the glue drivers which handle the PHY by themselves do not
set hcd->phy.

Alan Stern
