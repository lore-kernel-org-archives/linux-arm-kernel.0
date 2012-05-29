From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 May 2012 10:21:29 +0100
Subject: [alsa-devel] [PATCH 2/4] ASoC: mmp: add audio dma support
In-Reply-To: <20120529090215.GA3954@opensource.wolfsonmicro.com>
References: <1337929863-31885-1-git-send-email-zhangfei.gao@marvell.com>
 <1337929863-31885-3-git-send-email-zhangfei.gao@marvell.com>
 <1337932416.1580.2.camel@vkoul-udesk3>
 <20120525080500.GB24149@n2100.arm.linux.org.uk>
 <CAMj5Bkhc46zqY5AbJkc=-h02taP_esxrqpNu--aYtZZcVcPK6A@mail.gmail.com>
 <20120525094231.GC24149@n2100.arm.linux.org.uk>
 <CAMj5BkjhCakuZdUcA+P_nbETi8tnYK5Ok6HMWTG61whZXwCD6g@mail.gmail.com>
 <1338268734.1580.26.camel@vkoul-udesk3>
 <20120529073334.GA12217@n2100.arm.linux.org.uk>
 <20120529090215.GA3954@opensource.wolfsonmicro.com>
Message-ID: <20120529092129.GE12217@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 10:02:15AM +0100, Mark Brown wrote:
> On Tue, May 29, 2012 at 08:33:34AM +0100, Russell King - ARM Linux wrote:
> 
> > But, as I pointed out earlier, there's the issue of using the wrong
> > struct device to allocate memory for the DMA engine.  That's something
> > that my soc-dmaengine.c got _right_, and soc-dmaengine-pcm.c gets _wrong_.
> 
> What is the issue with the current code - it *looks* like you want to
> use the component device for the DMA as the struct device with dmaengine
> but I don't understand the issue that's created if we don't (and why
> things appear to be working for people as they are).

Look.  It's very very very very simple.

What does the DMA API take?  A struct device.  What struct device?  Some
random struct device for something in the system, or what?  No, it takes
the struct device for the _device_ in the system which is _performing_
the DMA.

If your DMA is offloaded onto anther device, as is the case with DMA engine,
the _correct_ struct device to use with the DMA API is the DMA engine
device structure.  Because, if there's any restrictions on how that memory
is accessed - as I said in my other email - for instance, whether it be
that the DMA engine has an IOMMU in the way, or maybe has a restricted
view of memory - then your local struct device is the wrong one to be
using, because it will _not_ have that information to convey into the
DMA API.

Therefore, allocating or mapping DMA memory against one struct device,
and then passing it to an entirely different device in the system to
perform DMA on is _WRONG_.

It _may_ work as long as there are no restrictions or IOMMUs in the way,
because you'll happen to setup your local struct device the same as the
DMA engine struct device.  That's not always going to be the case.

If you persist in not wanting to care about this, then I'm afraid I'll
ignore soc-dmaengine-pcm.c entirely as to me its totally bolloxed code.
What I have as my own version (now with cyclic DMA support) is IMHO a
far superior and more correct implementation.
