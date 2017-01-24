From: balbi@kernel.org (Felipe Balbi)
Date: Tue, 24 Jan 2017 10:52:33 +0200
Subject: usb: gadget: Kernel panic (NULL pointer dereference) when using
 fsl_udc2_core on i.MX31 PDK
In-Reply-To: <CAM=E1R4EMEEq1wnHxjLLJMLaXCM=EDFo1JDacHKGq6DUtqA9Nw@mail.gmail.com>
References: <f984e50b-0e64-88ef-2f53-b8da2a62daf0@gmail.com>
 <87k29m6lkx.fsf@linux.intel.com>
 <CAM=E1R4EMEEq1wnHxjLLJMLaXCM=EDFo1JDacHKGq6DUtqA9Nw@mail.gmail.com>
Message-ID: <87efzsdelq.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Magnus Lilja <lilja.magnus@gmail.com> writes:
>>> I tried the fsl_udc_core gadget driver on the i.MX31 PDK board and got a
>>> kernel panic (NULL pointer dereference) when connecting the USB cable. I
>>> had the g_serial module loaded as well.
>>>
>>> The NULL pointer panic comes from gadget/udc/core.c
>>> usb_gadget_giveback_request() which calls req->complete() and in some
>>> cases req->complete is NULL.
>>>
>>> Commit 304f7e5e1d08 ("usb: gadget: Refactor request completion") changed
>>> fsl_udc2_core.c (and several other files) and in fsl_udc2_core.c a check
>>> that req->complete is non-NULL was removed:
>>>
>>> --- a/drivers/usb/gadget/udc/fsl_udc_core.c
>>> +++ b/drivers/usb/gadget/udc/fsl_udc_core.c
>>> @@ -197,10 +197,8 @@ __acquires(ep->udc->lock)
>>>          ep->stopped = 1;
>>>
>>>          spin_unlock(&ep->udc->lock);
>>> -       /* complete() is from gadget layer,
>>> -        * eg fsg->bulk_in_complete() */
>>> -       if (req->req.complete)
>>> -               req->req.complete(&ep->ep, &req->req);
>>> +
>>> +       usb_gadget_giveback_request(&ep->ep, &req->req);
>>>
>>>          spin_lock(&ep->udc->lock);
>>>          ep->stopped = stopped;
>>>
>>> If I re-introduce the check (either in fsl_udc_core.c or core.c) at
>>> least USB gadget operation using g_serial seems to work just fine.
>>>
>>> I don't know the logic in detail to understand whether this is a proper
>>> fix or if there is some other more problem with the fls_udc_core driver.
>>> Does anyone have input in this matter?
>>>
>>> I can produce a proper patch that fixes this problem by re-introducing
>>> the check (in either fsl_udc_core.c or core.c) if that is a proper
>>> solution and I can also assist in testing other fixes to the problem.
>>
>> ->complete() is supposed to be mandatory. Which gadget do you have that
>> ->doesn't set ->complete() to a valid function pointer?
>
> I'm modprobing g_serial so the following modules are loaded (using my patch):
>
> ~ # lsmod
> usb_f_acm
> u_serial
> g_serial
> libcomposite
> configfs
> fsl_usb2_udc

okay, can you figure out which request is coming without ->complete()
set? To which endpoint is this request being queued? It would be nice to
know these details. Maybe this is an old bug which ought to be fixed.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170124/0826a8cd/attachment.sig>
