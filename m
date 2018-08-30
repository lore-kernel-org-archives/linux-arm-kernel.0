From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Fri, 31 Aug 2018 00:01:11 +0530
Subject: [PATCH 00/15] soc: octeontx2: Add RVU admin function driver
In-Reply-To: <20180830132658.GA27566@lunn.ch>
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a1xC6XjwDAmocpE5TZO7j6uVGtvBtWLPVcYwKqN6Z+seQ@mail.gmail.com>
 <CA+sq2Cd3R0V5hcaF+ESfkOEBHgBwOB6b8Uwx7K+CeUN6gLFTOg@mail.gmail.com>
 <CA+sq2CfbpQKas7TbQfrcw=Drpb7yO_gqH31iXabjNEQEG4xYrQ@mail.gmail.com>
 <20180830132658.GA27566@lunn.ch>
Message-ID: <CA+sq2CfX+BGE1Ub0H9G21Vqg+vmQSukZj4gwz=B8wsqTLgE7mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 6:57 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > > My feeling overall is that we need a review from the network driver
> > > > folks more than the arm-soc team etc, and that maybe the driver
> > > > as a whole should go into drivers/net/ethernet.
> > >
> > > This driver doesn't handle any network IO and moreever this driver has to handle
> > > configuration requests from crypto driver as well. There will be
> > > separate network and
> > > crypto drivers which will be upstreamed into drivers/net/ethernet and
> > > drivers/crypto.
> > > And in future silicons there will be different types of functional
> > > blocks which will be
> > > added into this resource virtualization unit (RVU). Hence i thought
> > > this driver is not a
> > > right fit in drivers/net/ethernet.
>
> Hi Sunil
>
> Do you have a git branch for everything? I would like to look at the
> actual Ethernet driver, and the full API this driver exports to other
> drivers.

Hi Andrew,

I have pushed all patches into a github repo for your reference.
These are not the final patches, i still need to do some minor changes
before submitting
(i mean otherthan the ones i already submitted).

AF driver & CGX drivers:
https://github.com/sunilkovvuri/rvu_drivers/tree/master/drivers/soc/marvell/octeontx2

Ethernet drivers PF and VF
https://github.com/sunilkovvuri/rvu_drivers/tree/master/drivers/net/ethernet/marvell/octeontx2

Info exported/shared by AF driver with other drivers is
# Mailbox communication APIs, message IDs, message structs e.t.c
   https://github.com/sunilkovvuri/rvu_drivers/blob/master/drivers/soc/marvell/octeontx2/mbox.c
   https://github.com/sunilkovvuri/rvu_drivers/blob/master/drivers/soc/marvell/octeontx2/mbox.h
# Other structs and APIs
    https://github.com/sunilkovvuri/rvu_drivers/blob/master/drivers/soc/marvell/octeontx2/common.h
    https://github.com/sunilkovvuri/rvu_drivers/blob/master/drivers/soc/marvell/octeontx2/rvu_struct.h

>
> I think there real question here is, do you have split between this
> driver and the actual device drivers in the right place? For me, link
> up/down detection should be in the Ethernet driver, since it is not
> shared with the crypto driver.
>

As mentioned in the patch '[PATCH 13/15] soc: octeontx2: Add support
for CGX link management',
link up/down is detected by firmware. And firmware triggers a IRQ to
CGX driver, which then
takes the new status and sends a update to ethernet driver via a
mailbox communication.

Ethernet driver detects the link change and does the necessary stuff.
https://github.com/sunilkovvuri/rvu_drivers/blob/master/drivers/net/ethernet/marvell/octeontx2/otx2_pf.c#L116


>        Thanks
>         Andrew
