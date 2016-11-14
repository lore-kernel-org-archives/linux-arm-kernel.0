From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Nov 2016 13:03:09 +0100
Subject: [PATCH 01/16] ARM: scu: Provide support for parsing SCU device
 node to enable SCU
In-Reply-To: <71596b86-7653-5c02-fc46-59409a91243f@samsung.com>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
 <20161114141251.7ea86e7a@xhacker>
 <71596b86-7653-5c02-fc46-59409a91243f@samsung.com>
Message-ID: <2479429.Js1FDSdQzs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, November 14, 2016 2:10:16 PM CET pankaj.dubey wrote:
> >> +    scu_base = of_iomap(np, 0);
> >> +    of_node_put(np);
> >> +    if (!scu_base) {
> >> +            pr_err("%s failed to map scu_base via DT\n", __func__);
> > 
> > For non-ca5, non-ca9 based SoCs, we'll see this error msg. We understand
> > what does it mean, but it may confuse normal users. In current version,
> > berlin doesn't complain like this for non-ca9 SoCs
> > 
> 
> OK, let me see other reviewer's comment on this. Then we will decide if
> this error message is required or can be omitted.

We need to look at all callers here, to see if the function ever gets
called for a CPU that doesn't have an SCU. I'd say we should warn if
we know there is an SCU but we cannot map it, but never warn on
any of the CPU cores that don't support an SCU.

	Arnd
