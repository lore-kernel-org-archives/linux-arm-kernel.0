From: chunfeng.yun@mediatek.com (chunfeng yun)
Date: Sat, 1 Aug 2015 11:42:02 +0800
Subject: [PATCH v3 2/5] dt-bindings: Add a binding for Mediatek xHCI
 host controller
In-Reply-To: <20150731133707.GB25118@leverpostej>
References: <1437573945-31586-1-git-send-email-chunfeng.yun@mediatek.com>
 <1437573945-31586-3-git-send-email-chunfeng.yun@mediatek.com>
 <20150722142208.GC15809@leverpostej> <1437882325.3040.22.camel@mhfsdcap03>
 <20150731133707.GB25118@leverpostej>
Message-ID: <1438400522.31933.25.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,
On Fri, 2015-07-31 at 14:37 +0100, Mark Rutland wrote:
> Hi,
> 
> > > > + - mediatek,usb-wakeup: to access usb wakeup control register
> > > 
> > > What exactly does this property imply?
> > > 
> > There are some control registers for usb wakeup which are put in another
> > module, here to get the node of that module, and then use regmap and
> > syscon to operate it.
> 
> Ok. You need to specify the type of this property (i.e. that it is a
> phandle to a syscon node). The description makes it sound like a boolean.
> 
Is it ok to add a prefix of syscon, and name it syscon-usb-wakeup?

> > 
> > > > + - mediatek,wakeup-src: 1: ip sleep wakeup mode; 2: line state wakeup
> > > > +	mode; others means don't enable wakeup source of usb
> > > 
> > > This sounds like configuration rather than a hardware property. Why do
> > > you think this needs to be in the DT?
> > > 
> > Yes, it's better to put it in the DT. 
> 
> That doesn't answer my question.
> 
> _why_ do you think this needs to be in the DT? What do you think is
> better for it being there?
> 
It is unthoughtful to put it here;
There is different configuration on platforms, such as on tablet which
only needs line-state wakeup (because system can't enter suspend when
plug in usb cable, so don't need ip-sleep-wakeup to remote wakeup
system), and on box just needs ip-sleep wakeup mode. so it is better to
put in each board's dts.
 
> > 
> > > > + - mediatek,u2port-num: the number should not greater than the number
> > > > +	of phys
> > > 
> > > What exactly does this property imply?
> > > 
> > On some platform, it only makes use of partial usb ports, so disable
> > others to save power.
> 
> What exactly do you mean by "partial USB ports"?
> 
> If a phy isn't wired up, it won't be listed in the phys property, if it
> is then disabling it sounds like a run-time decision.
> 
Yes, you are right.
This confuse me a little before. It was a property of old phy driver at
first, and then ported it here, so did not remove it temp.
After I re-write the phy driver, I will remove it.

Thanks a lot.

> Thanks,
> Mark.
