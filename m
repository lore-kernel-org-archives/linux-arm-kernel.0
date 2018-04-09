From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 9 Apr 2018 13:36:03 +0200
Subject: [PATCH v3 3/6] spi: sun6i: restrict transfer length in PIO-mode
In-Reply-To: <67c2006b-17f2-2459-e3c9-e91e3c694d8c@orpaltech.com>
References: <20180405091913.ky4dnmszoobn2xry@flea>
 <ee4adb1e-caf6-32f6-33d6-d8dd94d232cf@orpaltech.com>
 <20180405131735.GB12349@sirena.org.uk>
 <8159c3a5-af74-9f13-aedb-7ecc708bdff6@orpaltech.com>
 <20180406073441.xesojvzc3deljhoy@flea>
 <204e97cb-2f39-00f0-fd4e-3aa9a51f7cac@orpaltech.com>
 <20180409092730.2moyhl5aaktjwbyn@flea>
 <94a394bd-89bf-9334-c500-4cbadf4c1044@orpaltech.com>
 <20180409105001.GC11532@sirena.org.uk>
 <67c2006b-17f2-2459-e3c9-e91e3c694d8c@orpaltech.com>
Message-ID: <20180409113603.2iexkqvyeqmysp5e@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 09, 2018 at 02:10:40PM +0300, Sergey Suloev wrote:
> On 04/09/2018 01:50 PM, Mark Brown wrote:
> > On Mon, Apr 09, 2018 at 01:26:23PM +0300, Sergey Suloev wrote:
> > > On 04/09/2018 12:27 PM, Maxime Ripard wrote:
> > > > On Fri, Apr 06, 2018 at 06:48:23PM +0300, Sergey Suloev wrote:
> > > > > On 04/06/2018 10:34 AM, Maxime Ripard wrote:
> > > > > According to what you said the driver must implement
> > > > > "transfer_one_message" instead of "transfer_one"
> > > > I'm not sure what makes you think that I said that.
> > > Because current implementation tries to send more than FIFO-depth of data in
> > > a single call to "transfer_one" which is wrong.
> > No, that's absolutely not the case.  All any of these functions has to
> > do is transfer whatever they were asked to, how they do it is not at all
> > important to the framework.
> 
> I think you don't fully understand the issue. Let's talk about sun4i and?
> sun6i SPI? drivers separately.
> 
> sun4i
> 
> 1)it is correctly declaring max_transfer_size=FIFO depth for PIO mode? but
> transfer_one() function doesn't follow the declaration allowing PIO
> transfers longer than FIFO depth? by just refilling FIFO using 3/4 FIFO
> empty interrupt. I can definitely state here that long transfers WON'T WORK
> on real hardware.

Surely the original author of the patch allowing to do just that
disagrees with you. And it's not about the hardware itself, it's about
how the driver operates as well.

> I tested it and that's why I can say that.

Then it must be fixed, and not silently reverted.

> But as soon as sun4i SPI driver? is correctly declaring
> max_transfer_size then "smart" clients will work well by limiting a
> single transfer size to FIFO depth. I tested it with real hardware,
> again.

This is really not my point. What would prevent you from doing
multiple transfers in that case, and filling the FIFO entirely,
waiting for it to be done, then resuming until you have sent the right
number of bytes?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180409/fb9af80c/attachment.sig>
