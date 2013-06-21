From: ming.lei@canonical.com (Ming Lei)
Date: Fri, 21 Jun 2013 17:13:48 +0800
Subject: [RFC PATCH v1 1/6] USB: HCD: support giveback of URB in tasklet
 context
In-Reply-To: <4558223.ViRy5S2mR9@linux-5eaq.site>
References: <CACVXFVPPF=DNp0dpypoZ=OifkfnCgWJKpQHMv4xE8PmBk8RiHQ@mail.gmail.com>
 <Pine.LNX.4.44L0.1306201242110.2063-100000@iolanthe.rowland.org>
 <CACVXFVMdxtd2fcwNE_YrfwG0Ksq67ww_Ar9A6fCGSr442gWaag@mail.gmail.com>
 <4558223.ViRy5S2mR9@linux-5eaq.site>
Message-ID: <CACVXFVNNR-ZYsJpQXu0tUpCtEk-hhw0M8nmYMB4GcSkKyLopqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 4:33 PM, Oliver Neukum <oneukum@suse.de> wrote:
> On Friday 21 June 2013 09:12:38 Ming Lei wrote:
>> >> This should be enough since during remove path usbcore will wait for all
>> >> URBs' completion which is only triggered by tasklet, so once all URBs are
>> >> finished, the tasklet list has been empty already.
>> >
>> > No, usbcore only waits until the urb_list for each endpoint is empty.
>> > It doesn't keep track of the individual URB completions.  Look at
>> > usb_hcd_flush_endpoint() and you'll see.
>>
>> But, if URBs still aren't completed after usb_disconnect(), it should be
>> bug of usbcore or driver, shouldn't it?
>
> A driver cannot know what caused the call to disconnect(). That includes
> driver unbind. Doing IO to a device that another driver may be bound to
> is certainly a bug.
> Nevertheless it usually works and it is desirable to keep that behavior.

I mean once driver is unbound, URB's complete() in that driver shouldn't be
called.  The situation might happen when driver->remove() doesn't
kill the URBs with the patch applied.

Thanks,
--
Ming Lei
