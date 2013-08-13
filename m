From: broonie@kernel.org (Mark Brown)
Date: Tue, 13 Aug 2013 19:55:47 +0100
Subject: [PATCH 10/18] spi: s3c64xx: Do not require legacy DMA API in
 case of S3C64XX
In-Reply-To: <2472314.6b8DcBdcjO@flatron>
References: <1376243970-6489-1-git-send-email-tomasz.figa@gmail.com>
 <1376243970-6489-11-git-send-email-tomasz.figa@gmail.com>
 <20130812233641.GL6427@sirena.org.uk> <2472314.6b8DcBdcjO@flatron>
Message-ID: <20130813185547.GD6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 13, 2013 at 01:49:53AM +0200, Tomasz Figa wrote:

> I've been testing this without any significant patches, like PWM, CCF or 
> DT support, just everything from the branch I pointed to and some board-
> specific patches to help in debugging.

Done some more digging.  It's not failing the first time it requests the
channel, it's failing sometime later on (after we've been running for a
while but when we've had a substantial idle period).  However it is the
first time we're actually intending to use the channel, previously to
this the transfers would always be too small to trigger DMA.  I'm not
sure that's relevant though as we're not getting far enough to actually
request the channel.

I'm still debugging what's going on here - the basic refcounting all
looks OK in the SPI driver, I can see it requesting and releasing with
the refcounts all going back to zero in the DMA driver as expected but
when we come back to the device later on dmaengine is deciding the
device is unavailable quite early on in the process.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130813/f958a0e0/attachment.sig>
