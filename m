From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 8 May 2015 14:52:00 +0530
Subject: [PATCH] dmaengine: at_xdmac: fix slave configuration issue
In-Reply-To: <20150506081342.GO30976@odux.rfo.atmel.com>
References: <1429196640-8703-1-git-send-email-ludovic.desroches@atmel.com>
 <20150427033328.GH2738@intel.com>
 <20150427083358.GG26450@odux.rfo.atmel.com>
 <20150504082536.GB3521@localhost>
 <20150504091241.GA29493@odux.rfo.atmel.com>
 <20150504103644.GE3521@localhost>
 <20150504145825.GF30976@odux.rfo.atmel.com>
 <20150506033343.GL3521@localhost>
 <20150506081342.GO30976@odux.rfo.atmel.com>
Message-ID: <20150508092200.GF3521@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 10:13:42AM +0200, Ludovic Desroches wrote:
> > ah yes but then you can use the channel for either direction without setting
> > slave_dma_config...
> > 
> 
> I still need dma_slave_config. In my device_config function, I don't
> copy the dma_slave_config but I take information from it to compute a
> dev2mem and mem2dev configuration. Then I will select the right one in
> the prep function. I think it's quite close from that you want.
since you do not know the direction here, you dont know how to compute
dev2mem or mem2dev configurations

> 
> In the device_config, I convert the maxburst value to a comprehensive
> one for my controller. If it is not a supported one then I'll return an
> error?
thats fine as long as direction is not used, implicitly as well

> Are you okay with this procedure? If not, I have totally misunderstood
> what you want...
> 
> My concern is that a device can fill only what it needs in the
> dma_slave_config structure. When doing the configuration, the controller
> doesn't care about the direction as you asked but if a maxburst
> configuration is not set, I will have a zero value which is not a valid
> one. I will return an error but is not...
Yes that is why many drivers will save configuration. Checking values
for sanity makes sense. No point in accepting config for 64 max burst if
device support upto 32!

Then you use direction is prepare_ api to compute parameters and if
you detect further errors in configuration for said txn then you are valid
to return error. Again if client has sent one direction parameters and in
prepare you will not return error as direction will be apt so current issue
will be fixed as well

-- 
~Vinod
