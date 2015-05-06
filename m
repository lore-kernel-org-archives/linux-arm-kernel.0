From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 6 May 2015 10:13:42 +0200
Subject: [PATCH] dmaengine: at_xdmac: fix slave configuration issue
In-Reply-To: <20150506033343.GL3521@localhost>
References: <1429196640-8703-1-git-send-email-ludovic.desroches@atmel.com>
 <20150427033328.GH2738@intel.com>
 <20150427083358.GG26450@odux.rfo.atmel.com>
 <20150504082536.GB3521@localhost>
 <20150504091241.GA29493@odux.rfo.atmel.com>
 <20150504103644.GE3521@localhost>
 <20150504145825.GF30976@odux.rfo.atmel.com>
 <20150506033343.GL3521@localhost>
Message-ID: <20150506081342.GO30976@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 09:03:43AM +0530, Vinod Koul wrote:
> On Mon, May 04, 2015 at 04:58:25PM +0200, Ludovic Desroches wrote:
> > On Mon, May 04, 2015 at 04:06:44PM +0530, Vinod Koul wrote:
> > > On Mon, May 04, 2015 at 11:12:41AM +0200, Ludovic Desroches wrote:
> > > > On Mon, May 04, 2015 at 01:55:36PM +0530, Vinod Koul wrote:
> > > > > On Mon, Apr 27, 2015 at 10:33:58AM +0200, Ludovic Desroches wrote:
> > > > > > Hi Vinod,
> > > > > > 
> > > > > > On Mon, Apr 27, 2015 at 09:03:28AM +0530, Vinod Koul wrote:
> > > > > > > On Thu, Apr 16, 2015 at 05:04:00PM +0200, Ludovic Desroches wrote:
> > > > > > > > When doing the slave configuration, an error is returned if the maxburst
> > > > > > > > value is not supported. The bug comes from the fact that we always check
> > > > > > > > the maxburst for both directions but in the case of an unidirectional
> > > > > > > > channel, only one is set.
> > > > > > > While setting the slave configuration we are not tied to a channel
> > > > > > > direction, the direction is passed usin prep_ method. So from that
> > > > > > > prespective a channle can be used for tx and rx with same slave config set.
> > > > > > > 
> > > > > > > Now if we were invoking at_xdmac_set_slave_config from prep_ calls then it
> > > > > > > would have been fine but here we are checking when the slave config is set
> > > > > > > so this is not right. You should check maxburst at runtime then...
> > > > > > > 
> > > > > > 
> > > > > > I don't understand why we should wait before checking the
> > > > > > configuration... Some channels are unidirectionnal so implicitly we know
> > > > > > the direction at configuration time because the device will fill only a
> > > > > > part of the dma_slave_config structure. For example, the atmel usart
> > > > > > requests a tx and a rx channels. When configuring the tx channel, only
> > > > > > the dst_ fields of the dma_slave_config structure are filled. Is it a
> > > > > > bad behavior?
> > > > > > 
> > > > > > The change introduced by this patch doesn't really care about the
> > > > > > direction, it only tells that if the device only fills src_ fields then
> > > > > > I don't have to check fields not configured.
> > > > > Well that is because we started with the assumption that channels are
> > > > > uni-direction and we know that. From client side we shouldn't care
> > > > > how channel looks like and which dma controller we are talking. The point is
> > > > > to make clients unaware and use the dmaengine API
> > > > 
> > > > I am sorry but I don't understand what is wrong with your vision and
> > > > this patch.
> > > > 
> > > > I think it is the case you describe, the client doesn't care how the
> > > > channel looks like, it wants a channel for doing transmission so it
> > > > fills only the configuration part for this purpose. In this case there
> > > > is no reason the dma controller returns an error by checking unset
> > > > values.
> > > As i said earlier, if the checks were in prepare call then they would be
> > > fine, but they are in slave_dma_config API. You dont know the direction at
> > > this point so checking here is not good. You should copy the parameters here
> > > as most do and move the checks to prepare_ calls where you know the
> > > direction for argument of prepare and return accordingly.
> > > 
> > > > 
> > > > It's true I can check the configuration requested by the client at
> > > > runtime. But why waiting so long? If there is an issue, it's better to
> > > > return the error as soon as possible. On client side, even at this
> > > > moment it is difficult to manage an error. For example, my dma
> > > > controller doesn't support the max burst requested, how the client will
> > > > know what is the maxburst size it can ask?
> > > Because you dont have the complete information. And failing prepare at that
> > > time makese sense because parameters have not be set properly!
> > > 
> > 
> > Sorry but I still don't understand why I don't have the complete
> > information. The only thing missing is the direction and I don't care
> > about it.
> > 
> > I was updating my patch but I realize I have no benefit to do it in
> > prep. Worse if I simply copy the slave configuration and check it in prep, I'll
> > check the maxburst value several times instead of one and it will always be
> > the same...
> ah yes but then you can use the channel for either direction without setting
> slave_dma_config...
> 

I still need dma_slave_config. In my device_config function, I don't
copy the dma_slave_config but I take information from it to compute a
dev2mem and mem2dev configuration. Then I will select the right one in
the prep function. I think it's quite close from that you want.

In the device_config, I convert the maxburst value to a comprehensive
one for my controller. If it is not a supported one then I'll return an
error?

Are you okay with this procedure? If not, I have totally misunderstood
what you want...

My concern is that a device can fill only what it needs in the
dma_slave_config structure. When doing the configuration, the controller
doesn't care about the direction as you asked but if a maxburst
configuration is not set, I will have a zero value which is not a valid
one. I will return an error but is not...


Ludovic
