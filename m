From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Jan 2012 17:57:14 +0000
Subject: [PATCH] RFC: spi/sa1100: rewrite the SA1100 SPI driver
In-Reply-To: <CACRpkdYdwKmrL6K9P05COxMVRgHECj_4CUE9COYiuFsQj5N39g@mail.gmail.com>
References: <1326841236-25178-1-git-send-email-linus.walleij@linaro.org>
 <20120117231314.GA1068@n2100.arm.linux.org.uk>
 <CACRpkdbynmvcjOY=7_6wK3YTJHpS16Y0fU-Ka3-qw6Vt+eXy0A@mail.gmail.com>
 <20120118123037.GF1068@n2100.arm.linux.org.uk>
 <CACRpkdYdwKmrL6K9P05COxMVRgHECj_4CUE9COYiuFsQj5N39g@mail.gmail.com>
Message-ID: <20120119175714.GF10404@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2012 at 06:49:25PM +0100, Linus Walleij wrote:
> On Wed, Jan 18, 2012 at 1:30 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Wed, Jan 18, 2012 at 01:13:29PM +0100, Linus Walleij wrote:
> 
> >> We usually merge drivers for microwire, TI, Motorola ... etc into
> >> drivers/spi as well. It's a good enough fit, the differences are very
> >> small. This is how we configure mode from the PL022 driver platform data:
> >
> > How do you send audio data at 16-bit 2 channel 48kHz continuously with
> > the SPI subsystem?
> 
> Can't say because we haven't used it for audio transfers. However
> I am pretty convinced that it'd work because we're running a
> 20 Mbit data link on that SPI port.
> 
> To get the high data rates we have an internal message queue in
> the driver that saturates the SPI port. Sometimes we even start to
> run parts of the driver in parallel on two cores: CPU0 is handling
> IRQs from the driver while CPU1 is preparing messages to/from
> the SPI subsystem.

A SMP system, which SA1100 is not.

With audio on the SA1100, we have to keep both DMA transfer buffer
pointers filled to ensure that audio does not suffer.  I don't see
submitting multiple SPI transfers into the SPI subsystem would be
able to do that without waiting for the previous transfer to stop
completely before starting the next - and that implies the DMA
transfer completes before starting to program up the next one.

What I'm saying is that SPI will want DMA activity to complete _and_
end before it starts on the next transfer, which is going to create
a break in the data output.

Given that audio here just requires the SSP to be configured, and
then everything else is just DMA, I don't see why we need to waste
cycles fiddling with the SPI subsystem with its inherent batching
of transfers.
