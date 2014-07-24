From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 24 Jul 2014 00:47:53 -0700
Subject: [PATCHv4 4/5] of/mtd/nand: add generic binding and helper for
 NAND_BBT_NO_OOB_BBM
In-Reply-To: <20140724084915.703a1fa0@ipc1.ka-ro>
References: <1402579245-13377-1-git-send-email-LW@KARO-electronics.de>
 <1402579245-13377-2-git-send-email-LW@KARO-electronics.de>
 <1402579245-13377-3-git-send-email-LW@KARO-electronics.de>
 <1402579245-13377-4-git-send-email-LW@KARO-electronics.de>
 <1402579245-13377-5-git-send-email-LW@KARO-electronics.de>
 <20140724020627.GD3711@ld-irv-0074>
 <20140724084915.703a1fa0@ipc1.ka-ro>
Message-ID: <20140724074753.GJ23883@brian-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 08:49:15AM +0200, Lothar Wa?mann wrote:
> Brian Norris wrote:
> > On Thu, Jun 12, 2014 at 03:20:44PM +0200, Lothar Wa?mann wrote:
> > > add a boolean property 'nand-no-oob-bbm' and helper function to be
> > > able to set the NAND_BBT_NO_OOB_BBM flag in DT capable NAND drivers
> > > and use it for i.MX and MXS nand drivers.
> > 
> > If I'm understanding your previous conversations with Huang correctly,
> > you *must* use NAND_BBT_NO_OOB_BBM if you're going to use the
> > fsl,no-blockmark-swap option. Correct? If so, then you might not need
> > a separate 'nand-no-oob-bbm' binding; your driver should imply from
> > 'fsl,no-blockmark-swap' that it must also enable NAND_BBT_NO_OOB_BBM.
> > 
> no-blockmark-swap implies NO_OOB_BBM but NO_OOB_BBM may also be used
> independent from no-blockmark-swap.

Why would you want NO_OOB_BBM without no-blockmark-swap? If the block is
bad, why do you care what's written to it? (For that matter, why is it
ever important to use NO_OOB_BBM? At worst, the extra BB marks are
useless / written to the wrong place.)

> IMO writing a bad block marker to flash (which is prevented by
> the NAND_BBT_NO_OOB_BBM flag) is a misinterpretation of the purpose of
> the BB mark in the first place. The manufacturer guarantees that blocks
> which are initially bad will have at least one zero bit in the position
> of the BB mark. That's all to it.

Yes, it is a misinterpretation, and it's really irrelevant in many cases
whether or not the BB mark is written to each block's OOB. But it does
still provide some resilience in case the on-flash table ever gets
completely corrupted -- nand_bbt will rescan the flash for BB marks on
the next boot (and this will be totally broken--with or without
NO_OOB_BBM--for hardware like yours). Or to put it another way, it
supports some legacy scenarios without (AFAICT) any real negative
effects.

> There is no guarantee, that you will even be able to write any
> deterministic data to a block that has turned bad due to wearout or
> other flash defects.

Certainly. But that's not an argument against attempting.

> It is rather bogus to rely on data written to a
> known bad block to reflect the state of the block.

We don't "rely" on this. If the BBT (and its mirrors) never completely
fails, these marks are never used.

> > Also, as I noted in [1], I don't really like exposing a ton of
> > individual boolean DT properties like this. (At least this property is
> > orthogonal to the bad block table; I was a little off-base in [1].)
> > 
> How else should this information be conveyed to the flash drivers?

I'm not convinced the NO_OOB_BBM DT property is actually necessary at
all.

I was more concerned about bad block *table* properties, where I see
that at least some users (e.g. ST Micro's BCH NAND driver) expect a
different BBT format than the default, and we might begin to see extra
boolean flags for random bits of differentiation. This is apparently
still just a theoretical concern, though.

Brian
