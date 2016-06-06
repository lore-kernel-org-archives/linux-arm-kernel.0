From: eric@anholt.net (Eric Anholt)
Date: Mon, 06 Jun 2016 16:50:31 -0700
Subject: [PATCH 27/32] gpio: Add support for the FXL6408 GPIO expander.
In-Reply-To: <1464817421-8519-28-git-send-email-kraxel@redhat.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
 <1464817421-8519-28-git-send-email-kraxel@redhat.com>
Message-ID: <87port98s8.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gerd Hoffmann <kraxel@redhat.com> writes:

> From: Eric Anholt <eric@anholt.net>
>
> This commit needs to be split up and cleaned up.  Also we should add
> interrupt support before pushing upstream.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>

OK, I've confirmed with the firmware maintainers: We really can't drive
this natively from Linux.  The firmware is polling one of the fxl6408's
pins 10 times a second for detecting under-voltage, so if we also try to
drive it we'll end up smashing each others' I2C transactions.  We'll
need to do a GPIO driver using the GET/SET_GPIO_STATE firmware calls,
instead.  Unfortunately, we don't have a direction-setting API for that
at the moment, but it'll at least let us read the HDMI HPD signal.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160606/2ef19dc7/attachment.sig>
