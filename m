From: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 11 Sep 2013 15:05:15 +0100
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <52304BFF.4060007@freescale.com>
References: <593AEF6C47F46446852B067021A273D6D984000B@MUCSE039.lantiq.com>
 <20130905020435.GA3970@gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C7F4@DBDE04.ent.ti.com>
 <522817D7.1010206@freescale.com> <522D3B79.3060707@freescale.com>
 <20130909151450.GI29403@sirena.org.uk> <522EC33B.9000009@freescale.com>
 <20130910180704.GB29403@sirena.org.uk> <522FD78A.6080900@freescale.com>
 <20130911104126.GN29403@sirena.org.uk> <52304BFF.4060007@freescale.com>
Message-ID: <1378908315.2627.392.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-09-11 at 18:54 +0800, Huang Shijie wrote:
> ? 2013?09?11? 18:41, Mark Brown ??:
> > So why does the SPI driver have references to the opcodes in it?
> I admit that the Freescale's quadspi controller is very special
> (it is designed too coupled with the SPI Nor FLASH),
> it is driven by the LUT registers.
> 
> I just quote the comment from the patch 1:

That didn't really answer the question, for me. I'm still not entirely
clear what's going on.

What *actually* happens, on the wire(s), when the flash driver asks the
SPI controller to perform a transaction?

Why can't the flash driver *provide* the required information?

So far I seem to have got it into my head that we have a SPI controller
which is connected to more than one device, and we can't send commands
to one without sending to the other... and that means that we have to
send a *NOP* to the "unwanted" device. Is that right?

The LUT registers just seem to be a controller-specific implementation
detail which doesn't really explain the fundamental issue.

It does sound like the general case should ideally be solved by the
driver for the *device* telling the SPI controller what to send as a
'NOP' command, if it really has to send something on this channel when
we didn't ask it to.


But since we don't actually *probe* SPI devices (do we?) and we rely on
them being enumerated in the device-tree or manually 'added' by other
methods, perhaps putting the NOP command into the device tree is the
better approach. At least it solves the issue of what to use as the NOP
command when the m25p80 driver is probing the first of the two chips,
before it's *tried* to identify the second.

Or have I completely missed the point here, somewhere?

-- 
dwmw2

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130911/fb6d9ac9/attachment-0001.bin>
