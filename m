From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 11 Nov 2015 12:26:21 -0800
Subject: [PATCH v6 0/3] Mediatek SPI-NOR flash driver
In-Reply-To: <1447250654.19991.15.camel@mhfsdcap03>
References: <1446824889-16144-1-git-send-email-bayi.cheng@mediatek.com>
 <20151110024611.GL12143@google.com>
 <1447250654.19991.15.camel@mhfsdcap03>
Message-ID: <20151111202621.GI12143@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 11, 2015 at 10:04:14PM +0800, Bayi Cheng wrote:
> On Mon, 2015-11-09 at 18:46 -0800, Brian Norris wrote:
> > I believe you didn't completely answer all my questions from v5 though.
> > I'll repeat a bit here. Particularly, refer to [1].
> > I'll summarize; I understand that your common transmit/receive operation
> > works something like this:
> > 
> > Quoting from [1]:
> > > (1) total number of bits to send/receive goes in the COUNT register (so
> > >     far, as many as 7*8=56?)
> > > (2) opcode is written to PRGDATA5
> > > (3) other "transmit" data (like addresses), if any, are placed on PRGDATA4..0
> > > (4) command is sent (execute_cmd())
> > > (5) data is read back in SHREG{X..0}, if needed
> > 
> > My questions were:
> > 
> > (a) Why does mt8173_nor_set_read_mode() use PRGDATA3? That's not
> >     mentioned in the SoC manual, and it doesn't really match any of the
> >     steps above. Perhaps it's just a quirk of the controller's
> >     programming model?
> > 
> yes, for this question, I have done some testes, If I change the
> PRGDATA3 to PRGDATA5 for mt8173_nor_set_read_mode() like others
> functions, then the controller will be hanged, and I have asked our
> designer for double confirm.

I wasn't suggesting to change this to PRGDATA5. I just was wondering why
the difference. It's not documented. (I suppose an acceptable answer is
just "because that's how the HW works.")

> > (b) How do you determine X from step (5)?
> > 
> > Right now, your code seems to answer that X is "rxlen - 1". Correct?
> > 
> yes, I have used "rxlen -1", because the first of nor flash output is
> located at SHREG[0], in the other words, the output data starts at
> SHREG[0] and go up to SHREG[relen -1]

But, we aren't reading from SHREG[0] first; we're reading backwards from
SHREG[rxlen - 1] down to SHREG[0]. It seems that's correct, right?

> > If that's correct and if I put all of my understanding together
> > correctly, this means that you can actually shift out (in PRGDATA) up to
> > 6 bytes (that is, 1 opcode and 5 tx bytes) and shift in (in SHREG) up to
> > 7 bytes, except that the first byte is received during the opcode cycle,
> > and so it is discarded, and we effectively receive only 6 bytes.
> > 
> > Is that all correct? If so, then I think you still need to adjust the
> > boundary conditions in your do_tx_rx() function. (I'll comment on the
> > driver to point out the specifics.)
> 
> Yes, you are right! and I will adjust the boundary conditions in
> do_tx_rx() function.

OK, good. BTW, can you make sure to rewrite the appropriate MAX macro(s)
to reflect the right values? It seems like maybe you'll want separate
macros for the maximum TX and RX -- and total (?), or is this just the
same as RX? -- since they seem to have different limits.

> By the way, could you tell me whether I need to publish a new patch? or
> you can fix them up directly?

I think there are a few more adjustments to make, so please just post a
new version of the driver only. The DT binding and DTS changes look good
to go now.

Regards,
Brian

> > [1] http://lists.infradead.org/pipermail/linux-mtd/2015-October/062951.html
