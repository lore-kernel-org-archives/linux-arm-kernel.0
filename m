From: ming.lei@canonical.com (Ming Lei)
Date: Tue, 11 Jun 2013 14:19:33 +0800
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <Pine.LNX.4.44L0.1306101647290.1133-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1306101316020.1133-100000@iolanthe.rowland.org>
 <Pine.LNX.4.44L0.1306101647290.1133-100000@iolanthe.rowland.org>
Message-ID: <CACVXFVMh7a0UPDVhLiXKXbMkDtF7Ri+FJxWiE6OL3YCU9ok=1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 4:51 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 10 Jun 2013, Alan Stern wrote:
>
>> > Tasklet doesn't disable local interrupts.
>>
>> It is documented that interrupts will be disabled while the completion
>> handler runs.  Therefore the tasklet _must_ disable local interrupts.
>
> You know, it may be that you can get most of the advantages you want by
> enabling local interrupts around the call to unmap_urb_for_dma() in
> usb_hcd_giveback_urb().

No, please don't enable IRQs inside interrupt handler, and you will
get warning dump.

Except for unmap_urb_for_dma() in usb_hcd_giveback_urb(),  I hope
map_urb_for_dma() inside complete() can benefit from the change too,
since map_urb_for_dma() is same time-consuming with unmap_urb_for_dma().

Also I hope complete() can be run with interrupt enabled since
driver's complete() may take long time on some ARCH, as I mentioned
in my last mail. And it isn't good to disable interrupt only for one interface
driver, looks I still don't get real good explanation about disabling
IRQs here, :-)

>
> This may be a little dangerous, though, because it is possible for an
> URB to be given back at the time it is submitted.  Drivers may not
> expect interrupts to get enabled temporarily when they call
> usb_submit_urb().

Thanks,
--
Ming Lei
