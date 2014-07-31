From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 31 Jul 2014 14:44:56 +0200
Subject: [PATCH] Documentation: dmaengine: Add a documentation for the
 dma controller API
In-Reply-To: <20140731074440.GY3952@lukather>
References: <1406736193-26685-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140730160607.GM8181@intel.com> <20140731074440.GY3952@lukather>
Message-ID: <53DA3A48.8070900@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2014 09:44 AM, Maxime Ripard wrote:
[...]
>    - Having to set device_slave_caps or not?

Yes. This should in my opinion be mandatory for new drivers. One of the 
issues with the DMAengine API is that it is really hard to write generic 
drivers that do not already know about the capabilities of the DMA 
controller. E.g. if you have a peripheral that is used on SoC A it assumes 
that the DMA controller it is connected to has the capabilities of the DMA 
controller in SoC A. If the same peripheral is now used on SoC B with a DMA 
controller with different capabilities this often ends up with ugly ifdefery 
in the peripheral driver. The peripheral driver shouldn't have to know which 
specific DMA controller it is connected to (It's a bit as if a GPIO consumer 
needed to know which GPIO controller is connected to). We got away with the 
current approach since there is not that much diversity in the mixing of 
peripherals and DMA controllers (each vendor pretty has their own DMA 
controller which it uses for their own peripherals). But with more recent 
code consolidation we are on a path to generic DMA support within subsystem 
frameworks (there is generic DMA support for audio, there is generic DMA 
support for SPI and I also have a (currently) out of tree patch for generic 
DMA support for IIO). Also these generic drivers need to be able to discover 
the capabilities of the DMA controller to be able to make the right decisions.

- Lars
