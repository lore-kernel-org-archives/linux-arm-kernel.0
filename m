From: miquel.raynal@free-electrons.com (Miquel RAYNAL)
Date: Tue, 2 Jan 2018 12:03:26 +0100
Subject: [PATCH 00/12] Marvell NAND controller rework with ->exec_op()
In-Reply-To: <87fu81bc45.fsf@belgarion.home>
References: <20171207201814.30411-1-miquel.raynal@free-electrons.com>
 <20171214070930.0b885f6d@bbrezillon>
 <877etkecig.fsf@belgarion.home> <20171218092535.2ca1fe13@xps13>
 <87y3lxccr7.fsf@belgarion.home>
 <20171220224121.2cb6f690@bbrezillon>
 <87lghucykr.fsf@belgarion.home>
 <20171222222441.0fd77df9@bbrezillon>
 <20171222233730.68d9cb9d@xps13> <87k1xdblxf.fsf@belgarion.home>
 <20171223155709.2ba16e95@xps13> <87fu81bc45.fsf@belgarion.home>
Message-ID: <20180102120326.7a2cf1d1@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Robert,

On Sat, 23 Dec 2017 18:14:18 +0100
Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> Miquel RAYNAL <miquel.raynal@free-electrons.com> writes:
> 
> >> Here it comes in [3]. I suspect the BBT parser here, here is the
> >> extract that _might_ be relevant:
> >> [    3.372907] nand: ->exec_op() parser: pattern not found!  
> >
> > Indeed this might be the problem, it means there is one scenario
> > that should be handled by the parser that is missing. I am really
> > interrogative about which one it is and to discover it, can you
> > rebuild with
> >
> >         #define DEBUG
> >
> > in drivers/mtd/nand/nand_base.c too.  
> It was already there, check the patch I attached to my previous mail.
> 
> > This way the core will display the patterns it try to find a match
> > for.  
> The core displays already debug message, as these are displayed :
> [    3.228598] nand: executing subop:
> [    3.232187] nand:     ->CMD      [0x90]
> [    3.236077] nand:     ->ADDR     [1 cyc: 40]
> [    3.240517] nand:     ->DATA_IN  [5 B, force 8-bit]
> 
> As to your statement "the core will display the patterns it try to
> find a match for", how confident are you with it ? Because my reading
> of the following code is quite different :
> 			if (!nand_op_parser_match_pat(pattern, &ctx))
> 				continue;
> 
> 			nand_op_parser_trace(&ctx);
> 
> > Also to ease the understanding, you might add a dump_stack() right
> > next to this error message.  
> Attached in [1].

I just pushed two fixups on top of the Github branch [1], can you rebase
on top of them and give me the result?

The first patch just adds the auto bus width bit in nand->options.
The second removes the faulty ->change_column(), and does the same
check with another method.

I think the ECC issue you faced was related to pages being written
*and* empty. If this guess is right, the board should boot fine with
these changes.

Otherwise, please add the DEBUG define as before in both the core and
the driver and do not hesitate to add another dump_stack() where it
crashes (if applicable).

Thanks for your help,
Miqu?l

[1] https://github.com/miquelraynal/linux/commits/marvell/nand-next/nfc
