From: lee.essen@nowonline.co.uk (Lee Essen)
Date: Wed, 16 Apr 2014 19:55:08 +0400
Subject: dma_alloc_coherent and cache?
In-Reply-To: <534DAA8E.1090904@boundarydevices.com>
References: <45E047AA-4C3B-4645-A590-5B75A1729ADA@nowonline.co.uk>
 <534DAA8E.1090904@boundarydevices.com>
Message-ID: <D5AF0C4C-8B70-4443-994B-361D39AA3C28@nowonline.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 16 Apr 2014, at 01:54, Troy Kisky <troy.kisky@boundarydevices.com> wrote:

> On 4/14/2014 10:43 PM, Lee Essen wrote:
>> Hi,
>> 
>> I'm working on a driver for a Marvell switch device (98dx4122) where the basic interface closely resembles the mv643xx_eth device.
>> 
>> (I should say this is a bit of a personal project to experiment with a trendnet switch, not affiliated with any commercial activities.)
>> 
>> GPL code from Marvell is available for an old kernel, so I have been working to use the mv643xx_eth concepts and at least get basic functionality up an running on the current kernel version.
>> 
>> At a high level I have it working, however I get regular (reproducible) hangs and I suspect it's to do with the writes to the descriptiors (from dma_alloc_coherent) being buffered or cached and not making it to the device when dma is triggered.
>> 
> 
> Have you verified that a wmb() precedes transferring ownership of the descriptor to the controller
> and the cpu does not touch the descriptor afterwards?

Hi Troy,

Yes, there?s a smb() before the write of the register that starts the DMA, and nothing else that touches it.  The hang happens almost instantly (probably it is instantly) after the dma start.

It still feels like a cache/buffering issue, but nobody can see any obvious problems ? the other possibility is that it?s interrupt related, since an interrupt will occur pretty quickly after the dma is enabled.

I am going to try to rework the driver slightly to be entirely polling, just to eliminate the interrupt side of things ? although it will increase the delay between the descriptor write and the dma start which may also mask the problem.

Lee.
