From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 20 Jan 2015 10:39:25 +0000
Subject: [RFC PATCH 0/3] drivers: port PCIe designware to new DT parsing
 API
In-Reply-To: <1539153.bO1tVUM2dB@wuerfel>
References: <1420644571-18928-1-git-send-email-lorenzo.pieralisi@arm.com>
 <CAL_JsqLYg9vhFVmf=O4YLPfboj-dyoCR0H5dzBbMC3PeAEOwhQ@mail.gmail.com>
 <1539153.bO1tVUM2dB@wuerfel>
Message-ID: <20150120103925.GE5398@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 04:59:00PM +0000, Arnd Bergmann wrote:
> On Monday 19 January 2015 10:40:39 Rob Herring wrote:
> > 
> > I don't really like exposing ranges to host drivers. We've worked to
> > not do that. So perhaps we need to rethink the API. I think we need to
> > provide each range as a pair of resources which are the CPU address
> > and PCI address. Perhaps an iterator is kind of pointless here. We do
> > different things for each one. Are there cases with more than a single
> > i/o space, non-prefetch memory and prefetch memory range? Perhaps we
> > should just get the i/o and memory resources as separate calls. Just
> > tossing out some ideas here.
> 
> Nice idea, that could be similar to platform_get_resource().

I like the idea too, it should simplify the API implementation.

> We probably also need the distinction between CPU address and (parent)
> bus address here. In most drivers they are the same, but we actually
> need to program the latter one into the PCI host bridge registers.

Yes, CPU untranslated addresses are a pain in the back. I wrote
the series at it is to avoid changing the API, but I agree that's
a bit convoluted, which means we should refactor it.

I think the API should always return a pair of CPU-PCI resources as Rob
said, and provide an "on-demand" request for untranslated addresses, since
their usage is not that common (at the moment). I need to think about
that, we might even return a triplet, I hate doing that since I fear
it might be a one-off need for PCIe designware.

Lorenzo
