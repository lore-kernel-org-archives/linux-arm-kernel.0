From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 26 Apr 2017 16:25:26 +0800
Subject: [PATCH] usb: chipidea: udc: fix NULL pointer dereference if
 udc_start failed
In-Reply-To: <0ac4bc53-dd26-0b90-c84e-a94d01a6d5e4@i2se.com>
References: <20170424123551.2465-1-jszhang@marvell.com>
 <20170425082948.GB873@b29397-desktop>	<20170425171134.6a983841@xhacker>
 <HE1PR04MB1450634CE9C1D7FACC37DB4A8B1E0@HE1PR04MB1450.eurprd04.prod.outlook.com>
 <0ac4bc53-dd26-0b90-c84e-a94d01a6d5e4@i2se.com>
Message-ID: <20170426162526.7c8ef827@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Apr 2017 17:21:59 +0200
Stefan Wahren <stefan.wahren@i2se.com> wrote:

> Am 25.04.2017 um 11:20 schrieb Peter Chen:
> >    
> >>>> diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> >>>> index f88e9157fad0..60a786c87c06 100644
> >>>> --- a/drivers/usb/chipidea/udc.c
> >>>> +++ b/drivers/usb/chipidea/udc.c
> >>>> @@ -1984,6 +1984,7 @@ static void udc_id_switch_for_host(struct
> >>>> ci_hdrc *ci)  int ci_hdrc_gadget_init(struct ci_hdrc *ci)  {
> >>>>  	struct ci_role_driver *rdrv;
> >>>> +	int ret;
> >>>>
> >>>>  	if (!hw_read(ci, CAP_DCCPARAMS, DCCPARAMS_DC))
> >>>>  		return -ENXIO;
> >>>> @@ -1996,7 +1997,10 @@ int ci_hdrc_gadget_init(struct ci_hdrc *ci)
> >>>>  	rdrv->stop	= udc_id_switch_for_host;
> >>>>  	rdrv->irq	= udc_irq;
> >>>>  	rdrv->name	= "gadget";
> >>>> -	ci->roles[CI_ROLE_GADGET] = rdrv;
> >>>>
> >>>> -	return udc_start(ci);
> >>>> +	ret = udc_start(ci);
> >>>> +	if (!ret)
> >>>> +		ci->roles[CI_ROLE_GADGET] = rdrv;
> >>>> +
> >>>> +	return ret;
> >>>>  }
> >>>> --  
> >>> Thanks for fixing it. In fact, we'd better return failure if ret &&
> >>> ret != -ENXIO at probe, it stands for initialization for host or
> >>> gadget has failed.
> >>>  
> >> I got your meaning. I'll cook v2. I don't have preference, since either one can fix the
> >> issue.
> >>  
> > Both are needed, you don't need to send this one again. Only a new one, thanks.  
> 
> I'm not sure how easy it is to reproduce the issue.

It's easy to reproduce it (100%) on arm64 platforms after commit
1dccb598df549 ("arm64: simplify dma_get_ops"). This commit could
make all dma related operations failed, then udc_start() would fail
with -ENOMEM.

On other platforms, it's not easy.

> 
> Shouldn't make a Fixes tag sense at least?

maybe 3f124d233e97 ("usb: chipidea: add role init and destroy APIs"
