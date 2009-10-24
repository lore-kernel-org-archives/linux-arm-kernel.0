From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 24 Oct 2009 22:10:26 +0100
Subject: [PATCH 00/20] iPAQ h3100/h3600 work for 2.6.33
In-Reply-To: <1256414658-22611-1-git-send-email-mad_soft@inbox.ru>
References: <1256414658-22611-1-git-send-email-mad_soft@inbox.ru>
Message-ID: <20091024211026.GE16451@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 25, 2009 at 12:03:58AM +0400, Dmitry Artamonow wrote:
> Compile and run tested on iPAQs h3150 and h3635 with CF jacket.
> Patches are mostly checkpatch clean - there's some comments
> exceeding 80-line limit, but otherwise all code should be ok.

I don't really care about the 80 character line limit in two circumstances:
1. if a printk format string needs to go over the limit, so be it.
2. comments against #defines when it's reasonable for them to be there
   provided its not excessive.

Looking at these patches, it seems sane.

> Also, please note, that patches are generated with "-C" flag
> of git-format-patch for easier review. If there's problems with
> applying, use patches from URL above - they're generated without "-C".

That's fine, and the patches to me at least look fine as well.  The only
thing which gives me slight concern is the:

	if (!gpio_request()) {
		gpio_direction_output();
		gpio_free();
	}

stuff, but I guess you can't get around that easily, especially if those
GPIOs only become available at some time later.  It is something that
eventually needs to be addressed though - consider that this can lead
to unexpected (and silent) failures if the GPIOs aren't available when
another driver initializes, and can't (eg) turn on the IrDA tranceiver.
