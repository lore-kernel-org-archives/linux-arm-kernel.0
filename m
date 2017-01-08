From: sean@mess.org (Sean Young)
Date: Sun, 8 Jan 2017 21:16:24 +0000
Subject: [PATCH 2/2] media: rc: add driver for IR remote receiver on
 MT7623 SoC
In-Reply-To: <1483687885.16976.19.camel@mtkswgap22>
References: <1483632384-8107-1-git-send-email-sean.wang@mediatek.com>
 <1483632384-8107-3-git-send-email-sean.wang@mediatek.com>
 <20170105171240.GA9136@gofer.mess.org>
 <1483687885.16976.19.camel@mtkswgap22>
Message-ID: <20170108211624.GB7866@gofer.mess.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

On Fri, Jan 06, 2017 at 03:31:25PM +0800, Sean Wang wrote:
> On Thu, 2017-01-05 at 17:12 +0000, Sean Young wrote:
> > On Fri, Jan 06, 2017 at 12:06:24AM +0800, sean.wang at mediatek.com wrote:
> > > +	/* Handle pulse and space until end of message */
> > > +	for (i = 0 ; i < MTK_CHKDATA_SZ ; i++) {
> > > +		val = mtk_r32(ir, MTK_CHKDATA_REG(i));
> > > +		dev_dbg(ir->dev, "@reg%d=0x%08x\n", i, val);
> > > +
> > > +		for (j = 0 ; j < 4 ; j++) {
> > > +			wid = (val & (0xff << j * 8)) >> j * 8;
> > > +			rawir.pulse = !rawir.pulse;
> > > +			rawir.duration = wid * (MTK_IR_SAMPLE + 1);
> > > +			ir_raw_event_store_with_filter(ir->rc, &rawir);
> > > +
> > > +			if (MTK_IR_END(wid))
> > > +				goto end_msg;
> > > +		}
> > > +	}
> > 
> > If I read this correctly, there is a maximum of 17 * 4 = 68 edges per
> > IR message. The rc6 mce key 0 (scancode 0x800f0400) is 69 edges, so that
> > won't work.
> > 
> Uh, this is related to hardware limitation. Maximum number hardware
> holds indeed is only 68 edges as you said :( 
> 
> For the case, I will try change the logic into that the whole message 
> is dropped if no end of message is seen within 68 counts to avoid
> wasting CPU for decoding. 

I'm not sure it is worthwhile dropping the IR in that case. The processing
is minimal and it might be possible that we have just enough IR to decode
a scancode even if the trailing end of message is missing. Note that
the call to ir_raw_event_set_idle() will generate an timeout IR event, so
there will always be an end of message marker.

All I wanted to do was point out a limitation in case there is a
workaround; if there is not then we might as well make do with the IR
we do have.

Thanks
Sean
