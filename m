From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 21 Aug 2012 10:50:27 +0100
Subject: [PATCH 5/8] mfd: Provide the PRCMU with its own IRQ domain
In-Reply-To: <20120821085618.GA26899@gmail.com>
References: <CACRpkdZ7bMBytyDppV2sB1d1sUbDpPRqAQVOq8k4UOYdmg+Mkw@mail.gmail.com>
 <201208140942.54773.arnd@arndb.de>
 <CACRpkdYbOBEPNbCdfi+=gupdqS8_7t7MpOgXs7VCVTs8Y3j_mQ@mail.gmail.com>
 <20120820083640.GH8450@gmail.com>
 <20120820121055.GA26991@opensource.wolfsonmicro.com>
 <20120820125531.GA20242@gmail.com>
 <20120820162923.GF26991@opensource.wolfsonmicro.com>
 <20120820164949.GB22749@gmail.com>
 <20120820175155.GH26991@opensource.wolfsonmicro.com>
 <20120821085618.GA26899@gmail.com>
Message-ID: <20120821095026.GU26991@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 09:56:19AM +0100, Lee Jones wrote:

> Wherever we do this from to be able to obtain the IRQ domain pointer, 
> which is where I'm currently struggling. Our options are:

> - If we're only talking MFD here, we can handle this stuff in the MFD
> core, but we need more information. The IRQ domain subsystem only allows
> domain look-up via a Device Tree node, so we need to get our hands on

What makes you say this?  This is just a convenience for finding a
domain, irqdomains are *completely* indepentant of device tree.

> the domain another way in the case of non-DT enabled devices. Either we
> add another parameter to mfd_add_device(irq_domain, ...), or we
> standardise the 'irq_domain' variable name and use:
>         irq_domain = container_of(parent, struct irq_domain, irq_domain);

Passing the domain into mfd seems like the obvious solution here - it's
exactly what we currently do for legacy stuff (where we pass in the irq
base), ideally what we'd end up with over time is that we could just
remove the irq_base parameter entirely as everything would in time be
moved over to using irqdomains.

> - I know that you have interest in pushing the functionality into the
> IRQ domain subsystem, but I'm struggling to see how. It's calling into
> the IRQ domain where we're seeing issues in the first place, specifically
> irq_create_mapping(). How about if we passed 'irq_domain' as a parameter
> when requesting the IRQ? That way we can pass the correct IRQ without
> worry of conversion. If 'irq_domain' is !NULL the IRQ management subsystem
> can do the necessary conversions. If 'irq_domain' is NULL it continues to
> use the requested IRQ as a virq.

This is totally orthogonal to doing the mapping in the MFD subsystem
which is the issue here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120821/c4d1369d/attachment.sig>
