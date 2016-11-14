From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Nov 2016 13:50:18 +0000
Subject: [PATCH 01/16] ARM: scu: Provide support for parsing SCU device
 node to enable SCU
In-Reply-To: <2479429.Js1FDSdQzs@wuerfel>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
 <20161114141251.7ea86e7a@xhacker>
 <71596b86-7653-5c02-fc46-59409a91243f@samsung.com>
 <2479429.Js1FDSdQzs@wuerfel>
Message-ID: <20161114135018.GL1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 14, 2016 at 01:03:09PM +0100, Arnd Bergmann wrote:
> On Monday, November 14, 2016 2:10:16 PM CET pankaj.dubey wrote:
> > >> +    scu_base = of_iomap(np, 0);
> > >> +    of_node_put(np);
> > >> +    if (!scu_base) {
> > >> +            pr_err("%s failed to map scu_base via DT\n", __func__);
> > > 
> > > For non-ca5, non-ca9 based SoCs, we'll see this error msg. We understand
> > > what does it mean, but it may confuse normal users. In current version,
> > > berlin doesn't complain like this for non-ca9 SoCs
> > > 
> > 
> > OK, let me see other reviewer's comment on this. Then we will decide if
> > this error message is required or can be omitted.
> 
> We need to look at all callers here, to see if the function ever gets
> called for a CPU that doesn't have an SCU. I'd say we should warn if
> we know there is an SCU but we cannot map it, but never warn on
> any of the CPU cores that don't support an SCU.

Maybe there should be two helpers:

of_scu_enable() which _only_ looks up the SCU address in DT and enables
it if it finds it, otherwise returning failure.

a9_scu_enable() which tries to use the A9 provided SCU address and
enables it if it finds it, otherwise returning failure.

Then callers can decide which of these to call, and what error messages
to print on their failures.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
