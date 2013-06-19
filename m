From: ming.lei@canonical.com (Ming Lei)
Date: Wed, 19 Jun 2013 11:13:49 +0800
Subject: [RFC PATCH v1 4/6] USB: EHCI: don't release ehci->lock if URB
 giveback in tasklet context
In-Reply-To: <Pine.LNX.4.44L0.1306181242500.1157-100000@iolanthe.rowland.org>
References: <1371567833-9077-5-git-send-email-ming.lei@canonical.com>
 <Pine.LNX.4.44L0.1306181242500.1157-100000@iolanthe.rowland.org>
Message-ID: <CACVXFVOc9GhZSX5vtgxN3u9+wMVv2SkXW6jyCtb1eYTzRXahWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 12:43 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Tue, 18 Jun 2013, Ming Lei wrote:
>
>> If HCD_BH is set for HC driver's flags, URB giveback will be
>> done in tasklet context instead of interrupt context, so the
>> ehci->lock needn't to be released any more before calling
>> usb_hcd_giveback_urb().
>
> It is premature to do this now.  This should be part of the 6/6 patch,

It is fine since HCD_BH isn't enabled.

> when it won't be necessary to test hcd_giveback_urb_in_bh().

Keeping it is easy to compare test results between running complete()
in tasklet and in hard irq handler.

Also it might be helpful for out of tree drivers.

But it isn't a big deal, I can merge it to 6/6 if you care.

Thanks,
--
Ming Lei
