From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Sep 2012 13:32:42 +0000
Subject: [PATCH V4 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <505330B4.4070605@ti.com>
References: <1347573629-21299-1-git-send-email-jon-hunter@ti.com>
 <201209140943.49904.arnd@arndb.de> <505330B4.4070605@ti.com>
Message-ID: <201209141332.42420.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 September 2012, Jon Hunter wrote:
> On 09/14/2012 04:43 AM, Arnd Bergmann wrote:
> >> +
> >> +Client drivers should specify the DMA property using a phandle to the controller
> >> +followed by DMA controller specific data.
> >> +
> >> +Required property:
> >> +- dmas:			List of one or more DMA specifiers, each consisting of
> >> +			- A phandle pointing to DMA controller node
> >> +			- A single integer cell containing DMA controller
> >> +			  specific information. This typically contains a dma
> >> +			  request line number or a channel number, but can
> >> +			  contain any data that is used required for configuring
> >> +			  a channel.
> >> +- dma-names: 		Contains one identifier string for each dma specifier in
> >> +			the dmas property. The specific strings that can be used
> >> +			are defined in the binding of the DMA client device.
> > 
> > I think here we need to clarify that listing the same name multiple times implies
> > having multiple alternatives for the same channel.
> 
> Ok, however, the way it works right now is that we will use the first
> specifier that matches the name. So if there are multiple with the same
> name that would imply that someone will need call the
> xxx_request_slave_channel() multiple times to extract these. Is that ok?

I would expect a driver to only call the function once, and get something
back from the dmaengine layer that works. If there are two controllers
to choose from and one is busy, then it should definitely give a channel
from the non-busy one.

It's not much of an issue if the code doesn't handle all corner cases at
first, but I would expect that the binding correctly describes how to write
a device tree that will work once the code implements it correctly.

	Arnd
