From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Aug 2011 13:54:34 +0200
Subject: [PATCH V2 6/6] spi/spi-pl022: Request/free DMA channels as and
	when required.
In-Reply-To: <CABb+yY3=q5Nq1wtM6Av2DrgUfjZR_Ao40QhBhv_ik9naAd5wRg@mail.gmail.com>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<566c0525199f498f04422d4c3b2ddd7466648c20.1312965742.git.viresh.kumar@st.com>
	<20110810090042.GE1831@n2100.arm.linux.org.uk>
	<4E424F7B.2000800@st.com>
	<438BB0150E931F4B9CE701519A4463010871804A15@bgsmsx502.gar.corp.intel.com>
	<CABb+yY3SnqKN78U7vLbom1i00m=ThnRVQDVM_iX1TPu=+XzSNQ@mail.gmail.com>
	<20110810104025.GK1831@n2100.arm.linux.org.uk>
	<CABb+yY3=q5Nq1wtM6Av2DrgUfjZR_Ao40QhBhv_ik9naAd5wRg@mail.gmail.com>
Message-ID: <CACRpkdaCyUJ3A9VWfsVuwJj3DGVkvjc2_ZOD4yM4YX3NPxAAYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 1:24 PM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> On Wed, Aug 10, 2011 at 4:10 PM, Russell King - ARM Linux
>>
>> I discussed this with Linus on the bus back from Cambridge in the evening,
>> and it appears that the story you gave me was inaccurate - Linus had not
>> agreed to your proposal and saw more or less the same problems with it
>> which I've been on at you about via your other email alias/lkml. ?So that's
>> essentially invalidated everything we discussed there as part of my thinking
>> was "if Linus is happy with it, then...".
>
> IIRC, Linus W mainly opined to involve device pointer during channel selection.
> Other than that I thought there was only ambiguity about implementation details.

Bah now we have two "Linus oracles" in this world instead
of just one... haha :-)

> Linus W, was there anything you said wouldn't work with the scheme ?
> Please tell now on the record.

It would *work* but the current proposal is *not elegant* IMO.

Let me put it like this:

Yes, there is a problem with how all platforms have to pass in a
filter function and some opaque cookie for every driver to look up
its DMA channel.

You seem to want to address this problem, which is good.

I think your scheme passing in a device ID and instance tuple
e.g. REQ(MMC,2) would *work*, but I don't think it is a proper
solution and I would never ACK it, as I said.

The lookup of a device DMA channel should follow the
design pattern set by regulators and clocks. Which means
you use struct device * or alternatively a string (if the
instance is not available) to look it up, such that:

struct dma_slave_map {
   char name[16];
   struct device *dev;
   char dev_name[16];
   struct devive *dma_dev;
   char dma_dev_name[16];
};

struct dma_slave_map[] = {
  {
     .name = "MMC-RX",
     .dev_name = "mmc.0",
     .dma_dev_name = "pl08x.0",
  },
  {
     .name = "MMC-TX",
     .dev_name = "mmc.0",
     .dma_dev_name = "pl08x.0",
  },
  {
     .name = "SSP-RX",
     .dev_name = "pl022.0",
     .dma_dev_name = "pl08x.1",
  },
  ...
};

The dmaengine core should take this mapping, and
the device driver would only have to:

struct dma_chan *rxc;
struct dma_chan *txc;
struct device *dev;

rxc = dma_request_slave_channel(dev, "MMC-RX");
txc = dma_request_slave_channel(dev, "MMC-TX");

I also recognized that you needed a priority scheme and
a few other bits for the above, so struct dma_slave_map
may need a few more members, but the above would
sure solve all usecases we have today. mem2mem could
use the old request function and doesn't need anything
like this.

Pros: well established design pattern, channels tied to
devices, intuitive for anyone who used clock or
regulator frameworks.

If the majority is happy with this scheme I can even
try implementing it.

Yours,
Linus Walleij
