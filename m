From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 4 May 2015 13:55:36 +0530
Subject: [PATCH] dmaengine: at_xdmac: fix slave configuration issue
In-Reply-To: <20150427083358.GG26450@odux.rfo.atmel.com>
References: <1429196640-8703-1-git-send-email-ludovic.desroches@atmel.com>
 <20150427033328.GH2738@intel.com>
 <20150427083358.GG26450@odux.rfo.atmel.com>
Message-ID: <20150504082536.GB3521@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 27, 2015 at 10:33:58AM +0200, Ludovic Desroches wrote:
> Hi Vinod,
> 
> On Mon, Apr 27, 2015 at 09:03:28AM +0530, Vinod Koul wrote:
> > On Thu, Apr 16, 2015 at 05:04:00PM +0200, Ludovic Desroches wrote:
> > > When doing the slave configuration, an error is returned if the maxburst
> > > value is not supported. The bug comes from the fact that we always check
> > > the maxburst for both directions but in the case of an unidirectional
> > > channel, only one is set.
> > While setting the slave configuration we are not tied to a channel
> > direction, the direction is passed usin prep_ method. So from that
> > prespective a channle can be used for tx and rx with same slave config set.
> > 
> > Now if we were invoking at_xdmac_set_slave_config from prep_ calls then it
> > would have been fine but here we are checking when the slave config is set
> > so this is not right. You should check maxburst at runtime then...
> > 
> 
> I don't understand why we should wait before checking the
> configuration... Some channels are unidirectionnal so implicitly we know
> the direction at configuration time because the device will fill only a
> part of the dma_slave_config structure. For example, the atmel usart
> requests a tx and a rx channels. When configuring the tx channel, only
> the dst_ fields of the dma_slave_config structure are filled. Is it a
> bad behavior?
> 
> The change introduced by this patch doesn't really care about the
> direction, it only tells that if the device only fills src_ fields then
> I don't have to check fields not configured.
Well that is because we started with the assumption that channels are
uni-direction and we know that. From client side we shouldn't care
how channel looks like and which dma controller we are talking. The point is
to make clients unaware and use the dmaengine API

-- 
~Vinod
