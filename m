From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 4 May 2015 16:06:44 +0530
Subject: [PATCH] dmaengine: at_xdmac: fix slave configuration issue
In-Reply-To: <20150504091241.GA29493@odux.rfo.atmel.com>
References: <1429196640-8703-1-git-send-email-ludovic.desroches@atmel.com>
 <20150427033328.GH2738@intel.com>
 <20150427083358.GG26450@odux.rfo.atmel.com>
 <20150504082536.GB3521@localhost>
 <20150504091241.GA29493@odux.rfo.atmel.com>
Message-ID: <20150504103644.GE3521@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 04, 2015 at 11:12:41AM +0200, Ludovic Desroches wrote:
> On Mon, May 04, 2015 at 01:55:36PM +0530, Vinod Koul wrote:
> > On Mon, Apr 27, 2015 at 10:33:58AM +0200, Ludovic Desroches wrote:
> > > Hi Vinod,
> > > 
> > > On Mon, Apr 27, 2015 at 09:03:28AM +0530, Vinod Koul wrote:
> > > > On Thu, Apr 16, 2015 at 05:04:00PM +0200, Ludovic Desroches wrote:
> > > > > When doing the slave configuration, an error is returned if the maxburst
> > > > > value is not supported. The bug comes from the fact that we always check
> > > > > the maxburst for both directions but in the case of an unidirectional
> > > > > channel, only one is set.
> > > > While setting the slave configuration we are not tied to a channel
> > > > direction, the direction is passed usin prep_ method. So from that
> > > > prespective a channle can be used for tx and rx with same slave config set.
> > > > 
> > > > Now if we were invoking at_xdmac_set_slave_config from prep_ calls then it
> > > > would have been fine but here we are checking when the slave config is set
> > > > so this is not right. You should check maxburst at runtime then...
> > > > 
> > > 
> > > I don't understand why we should wait before checking the
> > > configuration... Some channels are unidirectionnal so implicitly we know
> > > the direction at configuration time because the device will fill only a
> > > part of the dma_slave_config structure. For example, the atmel usart
> > > requests a tx and a rx channels. When configuring the tx channel, only
> > > the dst_ fields of the dma_slave_config structure are filled. Is it a
> > > bad behavior?
> > > 
> > > The change introduced by this patch doesn't really care about the
> > > direction, it only tells that if the device only fills src_ fields then
> > > I don't have to check fields not configured.
> > Well that is because we started with the assumption that channels are
> > uni-direction and we know that. From client side we shouldn't care
> > how channel looks like and which dma controller we are talking. The point is
> > to make clients unaware and use the dmaengine API
> 
> I am sorry but I don't understand what is wrong with your vision and
> this patch.
> 
> I think it is the case you describe, the client doesn't care how the
> channel looks like, it wants a channel for doing transmission so it
> fills only the configuration part for this purpose. In this case there
> is no reason the dma controller returns an error by checking unset
> values.
As i said earlier, if the checks were in prepare call then they would be
fine, but they are in slave_dma_config API. You dont know the direction at
this point so checking here is not good. You should copy the parameters here
as most do and move the checks to prepare_ calls where you know the
direction for argument of prepare and return accordingly.

> 
> It's true I can check the configuration requested by the client at
> runtime. But why waiting so long? If there is an issue, it's better to
> return the error as soon as possible. On client side, even at this
> moment it is difficult to manage an error. For example, my dma
> controller doesn't support the max burst requested, how the client will
> know what is the maxburst size it can ask?
Because you dont have the complete information. And failing prepare at that
time makese sense because parameters have not be set properly!

-- 
~Vinod
> 
> Regards
> 
> Ludovic

-- 
