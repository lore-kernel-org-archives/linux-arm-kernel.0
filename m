From: ucdevel@gmail.com (David McCullough)
Date: Wed, 21 Nov 2012 08:15:47 +1000
Subject: [PATCH] arm/crypto: Make asm SHA-1 and AES code Thumb-2 compatible
In-Reply-To: <alpine.LFD.2.02.1211201348320.1182@xanadu.home>
References: <20121030100742.17910.70241.stgit@localhost6.localdomain6>
 <1352119337-22619-1-git-send-email-dave.martin@linaro.org>
 <alpine.LFD.2.02.1211151723590.1238@xanadu.home>
 <20121120184616.GB1969@linaro.org>
 <alpine.LFD.2.02.1211201348320.1182@xanadu.home>
Message-ID: <20121120221547.GA700@spottygum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Nicolas Pitre wrote the following:
> On Tue, 20 Nov 2012, Dave Martin wrote:
> 
> > On Thu, Nov 15, 2012 at 05:26:44PM -0500, Nicolas Pitre wrote:
> > > On Mon, 5 Nov 2012, Dave Martin wrote:
> > > 
> > > > This patch fixes aes-armv4.S and sha1-armv4-large.S to work
> > > > natively in Thumb.  This allows ARM/Thumb interworking workarounds
> > > > to be removed.
> > > > 
> > > > I also take the opportunity to convert some explicit assembler
> > > > directives for exported functions to the standard
> > > > ENTRY()/ENDPROC().
> > > > 
> > > > For the code itself:
> > > > 
> > > >   * In sha1_block_data_order, use of TEQ with sp is deprecated in
> > > >     ARMv7 and not supported in Thumb.  For the branches back to
> > > >     .L_00_15 and .L_40_59, the TEQ is converted to a CMP, under the
> > > >     assumption that clobbering the C flag here will not cause
> > > >     incorrect behaviour.
> > > > 
> > > >     For the first branch back to .L_20_39_or_60_79 the C flag is
> > > >     important, so sp is moved temporarily into another register so
> > > >     that TEQ can be used for the comparison.
> > > > 
> > > >   * In the AES code, most forms of register-indexed addressing with
> > > >     shifts and rotates are not permitted for loads and stores in
> > > >     Thumb, so the address calculation is done using a separate
> > > >     instruction for the Thumb case.
> > > > 
> > > >     The resulting code is unlikely to be optimally scheduled, but
> > > >     it should not have a large impact given the overall size of the
> > > >     code.  I haven't run any benchmarks.
> > > > 
> > > > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> > > 
> > > Acked-by: Nicolas Pitre <nico@linaro.org>
> > > 
> > > I didn't test it either, only reviewed the patch.  Looks obvious enough.  
> > > And if something is wrong, then it is very unlikely to be unnoticed in 
> > > practice.
> > 
> > I'd prefer someone tests this before I upload to the patch system.
> > 
> > I can do that, but I'm busy so it won't happen quickly...
> > 
> > Or do you think I should just go ahead?
> 
> If no one has provided test confirmation so far, that's either because 
> no one cares, or any breakage in functionality would be so obvious that 
> the incentive for testing before this hits mainline is not there.  In 
> either cases that should be fine for you to go ahead and let any fixes, 
> if any, be sent during the -rc period.

I have been trying to get some time to test this,  sorry for the silence.
I can't test thumb mode but I can test little/big-endian on none thumb
systems.  I would hope to get time before the end of the week  if that
is ok.

Cheers,
Davidm

-- 
David McCullough,  ucdevel at gmail.com
