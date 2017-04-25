From: peter.chen@nxp.com (Peter Chen)
Date: Tue, 25 Apr 2017 09:20:20 +0000
Subject: [PATCH] usb: chipidea: udc: fix NULL pointer dereference if
 udc_start failed
In-Reply-To: <20170425171134.6a983841@xhacker>
References: <20170424123551.2465-1-jszhang@marvell.com>
 <20170425082948.GB873@b29397-desktop> <20170425171134.6a983841@xhacker>
Message-ID: <HE1PR04MB1450634CE9C1D7FACC37DB4A8B1E0@HE1PR04MB1450.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
>> > diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
>> > index f88e9157fad0..60a786c87c06 100644
>> > --- a/drivers/usb/chipidea/udc.c
>> > +++ b/drivers/usb/chipidea/udc.c
>> > @@ -1984,6 +1984,7 @@ static void udc_id_switch_for_host(struct
>> > ci_hdrc *ci)  int ci_hdrc_gadget_init(struct ci_hdrc *ci)  {
>> >  	struct ci_role_driver *rdrv;
>> > +	int ret;
>> >
>> >  	if (!hw_read(ci, CAP_DCCPARAMS, DCCPARAMS_DC))
>> >  		return -ENXIO;
>> > @@ -1996,7 +1997,10 @@ int ci_hdrc_gadget_init(struct ci_hdrc *ci)
>> >  	rdrv->stop	= udc_id_switch_for_host;
>> >  	rdrv->irq	= udc_irq;
>> >  	rdrv->name	= "gadget";
>> > -	ci->roles[CI_ROLE_GADGET] = rdrv;
>> >
>> > -	return udc_start(ci);
>> > +	ret = udc_start(ci);
>> > +	if (!ret)
>> > +		ci->roles[CI_ROLE_GADGET] = rdrv;
>> > +
>> > +	return ret;
>> >  }
>> > --
>>
>> Thanks for fixing it. In fact, we'd better return failure if ret &&
>> ret != -ENXIO at probe, it stands for initialization for host or
>> gadget has failed.
>>
>
>I got your meaning. I'll cook v2. I don't have preference, since either one can fix the
>issue.
>

Both are needed, you don't need to send this one again. Only a new one, thanks.

Peter
