From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 23 Aug 2012 13:59:04 +0100
Subject: [PATCH 07/22] ASoC: Ux500: Initialise PCM from MSP probe rather
 than as a device
In-Reply-To: <20120823121936.GA1047@gmail.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-8-git-send-email-lee.jones@linaro.org>
 <CACRpkdbc6bGC4Yp7Bcdfev=Uc=1h4L1v+Lj9RbmJV3F+knQOZQ@mail.gmail.com>
 <002801cd7c31$14d3d0c0$3e7b7240$@se>
 <20120820085111.GJ8450@gmail.com>
 <006d01cd7f5a$65937840$30ba68c0$@se>
 <20120823092216.GA27264@gmail.com>
 <20120823113922.GZ7995@opensource.wolfsonmicro.com>
 <20120823121936.GA1047@gmail.com>
Message-ID: <20120823125903.GA7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2012 at 01:20:03PM +0100, Lee Jones wrote:
> > I say I don't understand the motivation for this change.  All the modern
> > DT bindings are perfectly happy handling this without an explicit shim
> > in the device tree to bodge things for Linux, adding them in seems like
> > it'd be a retrograde step.  What benefit do you believe this brings?

> How do the all the other DT:ed audio drivers handle the PCM then? More
> importantly, how would you like to see it handled? Ola has NACKed this
> patch and explained why:

They instantiate the PCM driver dynamically from the DAI when it's
probed which is pretty much what you're patch is doing.

> "I'm sorry but this patch is breaking the design of ASoC. The ASoC-
> platform is the DMA-block (in combination with the MSP-block), and
> there should be a platform-driver for the DMA/PCM. The platform-driver 
> then has a DAI which is the MSP. The ASoC DAI-link-struct should have
> one driver for each of these, so the dummy-driver for PCM should be
> there."

> So I don't really know where to go with it. Any ideas?

I think Ola is suggesting probing the DMA driver from the machine which
will also work though I'm not 100% sure if I'm parsing the above
correctly.  The issue in DT terms is that if the DMA controller is
shared with a bunch of other IPs then it should have one node shared
between them all and not a bunch of shim nodes inserted in the middle
which only exists due to the way Linux instantiates stuff.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120823/9e5a5c84/attachment.sig>
