From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 24 Jul 2014 08:49:15 +0200
Subject: [PATCHv4 4/5] of/mtd/nand: add generic binding and helper for
 NAND_BBT_NO_OOB_BBM
In-Reply-To: <20140724020627.GD3711@ld-irv-0074>
References: <1402579245-13377-1-git-send-email-LW@KARO-electronics.de>
 <1402579245-13377-2-git-send-email-LW@KARO-electronics.de>
 <1402579245-13377-3-git-send-email-LW@KARO-electronics.de>
 <1402579245-13377-4-git-send-email-LW@KARO-electronics.de>
 <1402579245-13377-5-git-send-email-LW@KARO-electronics.de>
 <20140724020627.GD3711@ld-irv-0074>
Message-ID: <20140724084915.703a1fa0@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Brian Norris wrote:
> (BTW, that's a mighty CC list you have! I'm not sure all CC'd parties
> are interested in this series; e.g., Russel and the ARM list seem
> unrelated)
> 
> Hi Lothar,
> 
> Sorry for the delay on this. I get busy enough that I can't/don't reply
> to everything quickly...
> 
> On Thu, Jun 12, 2014 at 03:20:44PM +0200, Lothar Wa?mann wrote:
> > add a boolean property 'nand-no-oob-bbm' and helper function to be
> > able to set the NAND_BBT_NO_OOB_BBM flag in DT capable NAND drivers
> > and use it for i.MX and MXS nand drivers.
> 
> If I'm understanding your previous conversations with Huang correctly,
> you *must* use NAND_BBT_NO_OOB_BBM if you're going to use the
> fsl,no-blockmark-swap option. Correct? If so, then you might not need
> a separate 'nand-no-oob-bbm' binding; your driver should imply from
> 'fsl,no-blockmark-swap' that it must also enable NAND_BBT_NO_OOB_BBM.
> 
no-blockmark-swap implies NO_OOB_BBM but NO_OOB_BBM may also be used
independent from no-blockmark-swap.

IMO writing a bad block marker to flash (which is prevented by
the NAND_BBT_NO_OOB_BBM flag) is a misinterpretation of the purpose of
the BB mark in the first place. The manufacturer guarantees that blocks
which are initially bad will have at least one zero bit in the position
of the BB mark. That's all to it.

There is no guarantee, that you will even be able to write any
deterministic data to a block that has turned bad due to wearout or
other flash defects. It is rather bogus to rely on data written to a
known bad block to reflect the state of the block.

> Also, as I noted in [1], I don't really like exposing a ton of
> individual boolean DT properties like this. (At least this property is
> orthogonal to the bad block table; I was a little off-base in [1].)
> 
How else should this information be conveyed to the flash drivers?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
