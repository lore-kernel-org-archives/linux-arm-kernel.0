From: sricharan@codeaurora.org (Sricharan)
Date: Fri, 6 May 2016 09:39:18 +0530
Subject: [PATCH 2/2] drivers: i2c: qup: Fix error handling
In-Reply-To: <20160505172219.GB6533@hector.attlocal.net>
References: <1462166637-16778-1-git-send-email-sricharan@codeaurora.org>
 <1462166637-16778-3-git-send-email-sricharan@codeaurora.org>
 <20160505172219.GB6533@hector.attlocal.net>
Message-ID: <001e01d1a74d$13c716b0$3b554410$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

> -----Original Message-----
> From: Andy Gross [mailto:andy.gross at linaro.org]
> Sent: Thursday, May 05, 2016 10:52 PM
> To: Sricharan R <sricharan@codeaurora.org>
> Cc: devicetree at vger.kernel.org; architt at codeaurora.org; linux-arm-
> msm at vger.kernel.org; ntelkar at codeaurora.org; galak at codeaurora.org;
> linux-kernel at vger.kernel.org; linux-i2c at vger.kernel.org; iivanov at mm-
> sol.com; agross at codeaurora.org; dmaengine at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH 2/2] drivers: i2c: qup: Fix error handling
> 
> On Mon, May 02, 2016 at 10:53:57AM +0530, Sricharan R wrote:
> > Among the bus errors reported from the QUP_MASTER_STATUS register
> only
> > NACK is considered and transfer gets suspended, while other errors are
> > ignored. Correct this and suspend the transfer for other errors as
> > well. This avoids unnessecary 'timeouts' which happens when waiting
> > for events that would never happen when there is already an error
> > condition on the bus.
> >
> > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> > ---
> >  drivers/i2c/busses/i2c-qup.c | 34 +++++++++++++++++++++++++---------
> >  1 file changed, 25 insertions(+), 9 deletions(-)
> 
> Reviewed-by: Andy Gross <andy.gross@linaro.org>
> 
 Thanks.
> <snip>
> 
> > @@ -1227,6 +1240,9 @@ static int qup_i2c_xfer_v2(struct i2c_adapter
> *adap,
> >  	struct qup_i2c_dev *qup = i2c_get_adapdata(adap);
> >  	int ret, len, idx = 0, use_dma = 0;
> >
> > +	qup->bus_err = 0;
> > +	qup->qup_err = 0;
> > +
> 
> What about the initial setting of these?  Does this need to be removed
from
> the main xfer function?
  Thanks for the catch. Will remove in bam_xfer , redundant.
  Now that there are i2x_xfer_v2 and i2c_xfer, 
   its not set in the old i2c_xfer call, where as it should be set there
   as well. I will change this and resend.

Regards,
 Sricharan
