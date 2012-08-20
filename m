From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 20 Aug 2012 18:51:55 +0100
Subject: [PATCH 5/8] mfd: Provide the PRCMU with its own IRQ domain
In-Reply-To: <20120820164949.GB22749@gmail.com>
References: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
 <1344527635-6163-6-git-send-email-lee.jones@linaro.org>
 <CACRpkdZ7bMBytyDppV2sB1d1sUbDpPRqAQVOq8k4UOYdmg+Mkw@mail.gmail.com>
 <201208140942.54773.arnd@arndb.de>
 <CACRpkdYbOBEPNbCdfi+=gupdqS8_7t7MpOgXs7VCVTs8Y3j_mQ@mail.gmail.com>
 <20120820083640.GH8450@gmail.com>
 <20120820121055.GA26991@opensource.wolfsonmicro.com>
 <20120820125531.GA20242@gmail.com>
 <20120820162923.GF26991@opensource.wolfsonmicro.com>
 <20120820164949.GB22749@gmail.com>
Message-ID: <20120820175155.GH26991@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 05:49:50PM +0100, Lee Jones wrote:
> On Mon, Aug 20, 2012 at 05:29:23PM +0100, Mark Brown wrote:

> > All of the regmap devices could use this.

> Only if they have linear domains and don't support DT.

Neither of those restrictions really apply...

> If they don't have linear domains there's no point, if they support DT
> then they can use it as it is.

All this stuff just works for any IRQ domain type, there's no
requirement for a particular one.  It's not urgently exciting for legacy
domains but it's not harmful either and pushes all the handling of this
stuff out of the MFD core and into the irqdomain code which is
definitely an abstraction win.

As far as DT goes supporting DT isn't enough, the current code will only
work on systems that actively use DT and do so using a particular style
of binding.  Since the majority of Linux architectures don't support DT
at all and it's not universally deployed on those that do this means
that generic drivers can't rely on it, and even drivers that use DT
might not be using the binding pattern which the framework code now
uses.

Indeed now that I think about the above isn't this going to be actively
harmful for generic drivers if they use this pattern for their bindings?
On DT systems the framework will unconditionally do the mapping but on
others no mapping will be done.  The function drivers don't know if the
mapping has been performed or not.

Unless I'm missing something here we need to fix this before the merge
window...

> To stop being DT dependent we'd need to remove all hand-rolled stuff 
> that these drivers are currently using, or else they will be attempting
> to convert and already converted VIRQ value. 

Well, yes - using framework code would be the goal here...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120820/febc6aa3/attachment.sig>
