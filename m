From: broonie@kernel.org (Mark Brown)
Date: Wed, 29 Nov 2017 10:53:09 +0000
Subject: [alsa-devel] [PATCH 1/5 v4] ASoC: ep93xx-ac97: Fix
 platform_get_irq's error checking
In-Reply-To: <5A12FC64.3020205@gmail.com>
References: <082d4479211d425219f4ab275ecc12e1011eca2f.1511062844.git.arvind.yadav.cs@gmail.com>
 <20171120133717.kscrjsb3y7gnvd2t@piout.net>
 <5A12FC64.3020205@gmail.com>
Message-ID: <20171129105309.2wqsbzuzjez5272k@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 20, 2017 at 09:31:40PM +0530, arvindY wrote:
> On Monday 20 November 2017 07:07 PM, Alexandre Belloni wrote:
> > On 19/11/2017 at 09:45:00 +0530, Arvind Yadav wrote:

> > To ensure this doesn't get applied: platform_get_irq can return
> > -EPROBE_DEFER and this must be handled properly.

> Yes, you are right. We should retry to get an irq for device. But ASoC
>  driver is not retrying. if platfore_get_irq() fail here, Driver is throwing
> an error.
> and this patch is only to fix error checking which is not correct in Driver.

> > >   	irq = platform_get_irq(pdev, 0);
> > > -	if (!irq)
> > > +	if (irq <= 0)
> > >   		return -ENODEV;

This is just squashing all error codes into -ENODEV, we'd be handling
probe deferral properly if we just returned the raw error code here.  We
need separate handling for irq == 0 which is an error but not an error
code and for cases where we've got an error code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171129/f1b57a77/attachment.sig>
