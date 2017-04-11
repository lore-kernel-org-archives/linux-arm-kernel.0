From: broonie@kernel.org (Mark Brown)
Date: Tue, 11 Apr 2017 21:31:24 +0100
Subject: [PATCH 2/6] regulator: anatop: only set supply regulator when it
 actually exists
In-Reply-To: <1491962327-12477-2-git-send-email-aisheng.dong@nxp.com>
References: <1491962327-12477-1-git-send-email-aisheng.dong@nxp.com>
 <1491962327-12477-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170411203124.y7cwyttqfu4a2aov@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 09:58:43AM +0800, Dong Aisheng wrote:
> Mandatorily set the initdata->supply_regulator while it actually not
> exist will cause regulator core to resolve supply each time whenever
> a new regulator registered which is meaningless and waste CPU mips.
> 
> We can observe more than one hundred times of iteration of resolving
> during a MX6Q SDB board booting up.
> 
> This patch adds the condition check for vin-supply to avoid the issue.

This is an obvious abstraction failure - there is nothing magical about
your driver which means that we need special casing in it to handle
badly written DTs that don't specify supplies.  Exactly the same
argument applies to all other regulators so if this is worth fixing it's
worth fixing in the core so we substitute in a dummy regulator if the
supply is genuinely missing.  Which is something we in fact have code to
do already though for some reason I can't see we bypass it, I'll send a
patch just now...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170411/ff6b4591/attachment.sig>
