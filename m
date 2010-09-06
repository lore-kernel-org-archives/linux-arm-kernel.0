From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 6 Sep 2010 13:29:36 +0300
Subject: [PATCH] s3c2410_udc: Add handling for S3C244X dual-packet mode
In-Reply-To: <1283178862-12987-1-git-send-email-anarsoul@gmail.com>
References: <1283178862-12987-1-git-send-email-anarsoul@gmail.com>
Message-ID: <201009061329.45290.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 30 ??????? 2010 17:34:22 ????? Vasily Khoruzhick ???????:
> From: Fabian Godehardt <fg@emlix.com>
> 
> This is a patch that seems to make the USB hangs on the S3C244X go away.
> At least a good amount of ping torture didn't make them come back so far.
> 
> The issue is that, if there are several back-to-back packets, sometimes no
> interrupt is generated for one of them. This seems to be caused by the
> mysterious dual packet mode, which the USB hardware enters automatically
> if the endpoint size is half that of the FIFO. (On the 244X, this is the
> normal situation for bulk data endpoints.)
> 
> There is also a timing factor in this. It seems that what happens is that
> the USB hardware automatically sends an acknowledgement if there is only
> one packet in the FIFO (the FIFO has space for two). If another packet
> arrives before the host has retrieved and acknowledged the previous one,
> no interrupt is generated for that second one.
> 
> However, there may be an indication. There is one undocumented bit (none
> of the 244x manuals document it), OUT_CRS1_REG[1], that seems to be set
> suspiciously often when this condition occurs. There is also
> CLR_DATA_TOGGLE, OUT_CRS1_REG[7], which may have a function related to
> this. (The Samsung manual is rather terse on that, as usual.)
> 
> This needs to be examined further. For now, the patch seems to do the
> trick.

Ping
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100906/45ff392a/attachment.sig>
