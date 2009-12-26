From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 26 Dec 2009 15:59:22 +0000
Subject: DMA/cache problems on SA1110/SA1111 (Was: Re: USB Host on a
	SA1111)
In-Reply-To: <de2dcbb80912260618w3d3978c9pc8362ce9f2458459@mail.gmail.com>
References: <de2dcbb80912220833mdc1788cq6f60dd5522e7ab0@mail.gmail.com>
	<20091222165904.GE17191@n2100.arm.linux.org.uk>
	<de2dcbb80912260618w3d3978c9pc8362ce9f2458459@mail.gmail.com>
Message-ID: <20091226155922.GA30221@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 26, 2009 at 03:18:31PM +0100, Filip Zyzniewski wrote:
> On Tue, Dec 22, 2009 at 5:59 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > Make sure that the DMA mask is correctly set - SA1111's have a bug in them
> > which means that certain address bits must have a certain value for all
> > DMA activities.
> 
> I know this bug from SA1111 errata. I know that sound DMA is ok on 2.4
> kernels on the Jornada 720s, so I am trying to find what they were
> doing to have it working.
>...
> Should I try to port the remaining part of the 2.4 function to the 2.6 one?

No.  Clearly you didn't read what I wrote.  Let me be more explicit.

We deal with the DMA problem a different way in 2.6 - we set the DMA
mask with the appropriate bit clear:

        /*
         * Now clear the bits in the DMA mask to work around the SA1111
         * DMA erratum (Intel StrongARM SA-1111 Microprocessor Companion
         * Chip Specification Update, June 2000, Erratum #7).
         */
        if (sachip->dev->dma_mask)
                *sachip->dev->dma_mask &= sa1111_dma_mask[drac >> 2];

        sachip->dev->coherent_dma_mask &= sa1111_dma_mask[drac >> 2];

And then the DMA bounce code does this:

                unsigned long mask = *dev->dma_mask;
                needs_bounce = (dma_addr | (dma_addr + size - 1)) & ~mask;

which checks whether the buffer being presented for DMA has the
problem bit set - if it does, it bounces the buffer.

Now, the problem with DMA masks is that Linux is screwy when it comes
to dealing with them - the assumption is that DMA masks are a set of
zeros followed by a set of ones, in other words, it's not a proper
bitmask.

Moreover, device drivers are expected to know what the correct DMA mask
is for their device, irrespective of what's going on upstream of the
device.  Very stupid when you have things like limited size windows
(as found on IOP platforms.)

So, check the DMA mask.  And check your DMA memory setup.  If either one
is wrong, you _will_ get non-DMA'd buffers passed through.  That's your
very first port of call.
