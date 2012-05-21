From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 May 2012 18:18:45 +0000
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <4FBA7C80.4080801@wwwdotorg.org>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <201205190844.03654.arnd@arndb.de> <4FBA7C80.4080801@wwwdotorg.org>
Message-ID: <201205211818.45646.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 May 2012, Stephen Warren wrote:
> > 
> > The point with the direction was that it covers most cases and makes
> > them rather simple, while for the rare case where you need more than
> > two channels, you just use the otherwise optional named interface
> > rather than the numbered one. My feeling is that this also makes a
> > lot of sense at the driver API level: most dirvers just ask for the
> > read and write channels using a very simple interface, and those drivers
> > that have more than two will want to name them anyway.
> 
> How are you thinking of representing the direction in DT - as part of
> the DMA request specifier, so in a DMAC-specific way?
> 
> If so, that seems a little odd; you have to request a DMA channel for
> "TX", but then end up having the common code check all the entries in
> the dmas property since it can't know which are TX, and then have the
> wrong ones almost accidentally fail, since the DMAC will then determine
> that it can't support TX on the RX DMA request IDs.

I think the direction must be encoded in a way that does not depend on
the binding for the specific controller. There are two ways I can see
how we might do it:

1. have separate property names for tx and rx channels, and probably
   one for combined rx/tx channels
2. define the second cell in each channel specifier to be the direction
   in a predefined format, followed by the other (controller specific)
   attributes, if any.
 

	Arnd
