From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 9 Aug 2013 23:08:45 +0200
Subject: [PATCH 06/12] dma: mmp_pdma: make the controller a DMA provider
In-Reply-To: <CAMj5Bkj5PmvdOV307PSpXvTomJsad_7G91X-UFxYJ2KukcqX6g@mail.gmail.com>
References: <1375870770-14263-1-git-send-email-zonque@gmail.com>
 <5204EA60.4060502@gmail.com>
 <CAMj5Bkj5PmvdOV307PSpXvTomJsad_7G91X-UFxYJ2KukcqX6g@mail.gmail.com>
Message-ID: <201308092308.45922.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 August 2013, zhangfei gao wrote:
> On Fri, Aug 9, 2013 at 9:10 PM, Daniel Mack <zonque@gmail.com> wrote:
> > On 07.08.2013 18:12, Arnd Bergmann wrote:

> >
> > I had another look at that and Zhangfei's case is not really applicable
> > to mine, unfortunately.
> >
> > In his case, one specific out of many channels has to be used, depending
> > on the first argument of the phandle. In my case though, the pdma
> > controller may just take any of its channels, and just assign the
> > correct DMA request to it.

This should still be fine since your driver can keep track of which
channels are currently in use. The locking can be done inside of the
dmaengine core, but you might have to retry if the channel is getting
acquired between your lookup and the lock.

> Though any physical channel is workable, the virtual channel does not.
> Each device has to set specific request line.
> 
> pdma.c
> chan->drcmr = cfg->slave_id;
> nand.c
>   conf.slave_id = info->drcmr_dat;
> 
> The specific virtual channel can be directly specificied by request line.
> While pdma.c choose the free physical channel inside, which is
> transparent to client.

It is a bug to override the slave_id value from the dma slave driver when
using dma_request_slave_channel, and the dmaengine driver should not allow
that. The slave_config function should only be used to set the configuration
parts that the slave driver knows about, which does not include the
slave_id in this case (since there is no platform data).

	Arnd
