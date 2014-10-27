From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Mon, 27 Oct 2014 00:35:48 +0000
Subject: [PATCH v3 2/3] i2c/at91: add support for system PM
In-Reply-To: <544A4DED.6090009@cogentembedded.com>
References: <1414133417-11530-1-git-send-email-wenyou.yang@atmel.com>
 <1414133417-11530-3-git-send-email-wenyou.yang@atmel.com>
 <544A4DED.6090009@cogentembedded.com>
Message-ID: <B256D81BAE5131468A838E5D7A243641BF59D3F4@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -----Original Message-----
> From: Sergei Shtylyov [mailto:sergei.shtylyov at cogentembedded.com]
> Sent: Friday, October 24, 2014 9:03 PM
> To: Yang, Wenyou; wsa at the-dreams.de; Desroches, Ludovic
> Cc: khilman at kernel.org; Ferre, Nicolas; linux-kernel at vger.kernel.org; linux-
> i2c at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v3 2/3] i2c/at91: add support for system PM
> 
> Hello.
> 
> On 10/24/2014 10:50 AM, Wenyou Yang wrote:
> 
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > ---
> >   drivers/i2c/busses/i2c-at91.c |   26 ++++++++++++++++++++++++++
> >   1 file changed, 26 insertions(+)
> 
> > diff --git a/drivers/i2c/busses/i2c-at91.c
> > b/drivers/i2c/busses/i2c-at91.c index a25fb5e..6a84a2a 100644
> > --- a/drivers/i2c/busses/i2c-at91.c
> > +++ b/drivers/i2c/busses/i2c-at91.c
> > @@ -861,7 +861,33 @@ static int at91_twi_runtime_resume(struct device
> > *dev)
> [...]
> > +static int at91_twi_resume_noirq(struct device *dev) {
> > +	int ret;
> > +
> > +	if (!pm_runtime_status_suspended(dev)) {
> > +		ret = at91_twi_runtime_resume(dev);
> 
>     Resume if *not* suspended?
Yes, if it is not runtime_suspended, it must be the system suspended, then resume it. I think so.

> 
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	pm_runtime_mark_last_busy(dev);
> > +	pm_request_autosuspend(dev);
> > +
> > +	return 0;
> > +}
> > +
> [...]
> 
> WBR, Sergei

Best Regards,
Wenyou Yang
