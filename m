From: ming.lei@canonical.com (Ming Lei)
Date: Fri, 21 Jun 2013 13:13:07 +0800
Subject: [RFC PATCH v1 1/6] USB: HCD: support giveback of URB in tasklet
 context
In-Reply-To: <CACVXFVM1gUxZjwGLjFkog_8K=aKBx3vr9hcdKKX6qr9GoS0YNw@mail.gmail.com>
References: <CACVXFVPPF=DNp0dpypoZ=OifkfnCgWJKpQHMv4xE8PmBk8RiHQ@mail.gmail.com>
 <Pine.LNX.4.44L0.1306201242110.2063-100000@iolanthe.rowland.org>
 <CACVXFVMdxtd2fcwNE_YrfwG0Ksq67ww_Ar9A6fCGSr442gWaag@mail.gmail.com>
 <CACVXFVM1gUxZjwGLjFkog_8K=aKBx3vr9hcdKKX6qr9GoS0YNw@mail.gmail.com>
Message-ID: <CACVXFVOKo7T7KSni7Dchts4Nt_KyKWAs3H6zDcta+RZ3vGbfxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 12:46 PM, Ming Lei <ming.lei@canonical.com> wrote:
> On Fri, Jun 21, 2013 at 9:12 AM, Ming Lei <ming.lei@canonical.com> wrote:
>> On Fri, Jun 21, 2013 at 12:52 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
>>> On Thu, 20 Jun 2013, Ming Lei wrote:
>>>
>>>> On Thu, Jun 20, 2013 at 10:59 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>>>> >
>>>> > By the way, did you consider the race that Oliver pointed out?  When an
>>>> > HCD is removed, all the outstanding URBs for all devices on its bus get
>>>> > cancelled.  The core waits until the urb_list for each endpoint is
>>>> > empty.
>>>>
>>>> This should be enough since during remove path usbcore will wait for all
>>>> URBs' completion which is only triggered by tasklet, so once all URBs are
>>>> finished, the tasklet list has been empty already.
>>>
>>> No, usbcore only waits until the urb_list for each endpoint is empty.
>>> It doesn't keep track of the individual URB completions.  Look at
>>> usb_hcd_flush_endpoint() and you'll see.
>>
>> But, if URBs still aren't completed after usb_disconnect(), it should be
>> bug of usbcore or driver, shouldn't it?
>
> Thought about the problem further, there should be one problem:
>
> - we can't let URBs survive from deleting the interface, otherwise
> the module in which the completion handler lives might have been
> removed
>
> - so tasklet_kill() should be added into usb_hcd_synchronize_unlinks()
> to make sure the above point, although it is a bit tricky since tasklet_kill()
> flushes global list, but it does work.

Maybe usb_suspend_both() need to call usb_hcd_synchronize_unlinks(dev),
both the two cases(disconnect, suspend) suppose drivers don't kill their
URBs in remove() and suspend().

Even we can implement one function which only flushes URBs for one device
to optimize the cases.

Thanks,
--
Ming Lei
