From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 12 May 2016 00:13:47 -0500
Subject: [PATCH 1/2] i2c: qup: Cleared the error bits in ISR
In-Reply-To: <934365f2bd30f242d8548e2a27483679@codeaurora.org>
References: <1462797871-8595-1-git-send-email-absahu@codeaurora.org>
 <1462797871-8595-2-git-send-email-absahu@codeaurora.org>
 <000701d1ab9d$df9b3100$9ed19300$@codeaurora.org>
 <934365f2bd30f242d8548e2a27483679@codeaurora.org>
Message-ID: <20160512051347.GE8453@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 11:04:17PM +0530, Abhishek Sahu wrote:

<snip>

> >       In qup_i2c_xfer and qup_i2c_xfer_v2 state is set to RESET at the
> >end, when
> >       there is no error. So would it be fine if we do it there
> >unconditionally ?
> >
> >Regards,
> > Sricharan
> 
> RESET the QUP state wouldn't create any issue in the case of multiple calls.
> The existing code also RESET the QUP state for bus_err but it is not
> clearing
> status bits.

It'd be better to not reset the QUP inside the ISR at all.  I think the better
solution is making the reset occur in the xfer function.  So just clear the bits
like you should in the isr, and defer reset till later.
