From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 12 May 2016 12:58:30 -0500
Subject: [PATCH 1/2] i2c: qup: Cleared the error bits in ISR
In-Reply-To: <20160512061843.GA6187@chewinlnx07.qualcomm.com>
References: <1462797871-8595-1-git-send-email-absahu@codeaurora.org>
 <1462797871-8595-2-git-send-email-absahu@codeaurora.org>
 <000701d1ab9d$df9b3100$9ed19300$@codeaurora.org>
 <934365f2bd30f242d8548e2a27483679@codeaurora.org>
 <20160512051347.GE8453@hector.attlocal.net>
 <20160512061843.GA6187@chewinlnx07.qualcomm.com>
Message-ID: <20160512175830.GA32019@hector>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2016 at 11:48:43AM +0530, Abhishek Sahu wrote:
> On Thu, May 12, 2016 at 12:13:47AM -0500, Andy Gross wrote:
> > On Wed, May 11, 2016 at 11:04:17PM +0530, Abhishek Sahu wrote:
> > 
> > <snip>
> > 
> > > >       In qup_i2c_xfer and qup_i2c_xfer_v2 state is set to RESET at the
> > > >end, when
> > > >       there is no error. So would it be fine if we do it there
> > > >unconditionally ?
> > > >
> > > >Regards,
> > > > Sricharan
> > > 
> > > RESET the QUP state wouldn't create any issue in the case of multiple calls.
> > > The existing code also RESET the QUP state for bus_err but it is not
> > > clearing
> > > status bits.
> > 
> > It'd be better to not reset the QUP inside the ISR at all.  I think the better
> > solution is making the reset occur in the xfer function.  So just clear the bits
> > like you should in the isr, and defer reset till later.
> 
> This is a HW workaround for QUP where we need to RESET the core in
> ISR. When interrupt is level triggerd, more than one interrupt may
> fire in error cases and QUP will generate these interrupts after
> completion of current interrupt. Thus we reset the core immediately
> in the ISR to ward off the next interrupt.

I wonder if that was just an expedient solution.  And it seems like it could be
a little racy as a poll is not being done to make sure the QUP state machine
transitions to reset.  Is there any documentation/errata on this?  Or is this
just from commit comments?


Regards,
Andy
