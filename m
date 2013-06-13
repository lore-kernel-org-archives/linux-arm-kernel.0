From: xiechao.mail@gmail.com (Chao Xie)
Date: Thu, 13 Jun 2013 10:45:24 +0800
Subject: [PATCh V10 04/12] usb: ehci: ehci-mv: use PHY driver for ehci
In-Reply-To: <Pine.LNX.4.44L0.1305301020230.1321-100000@iolanthe.rowland.org>
References: <51A73BD8.8000007@ti.com>
 <Pine.LNX.4.44L0.1305301020230.1321-100000@iolanthe.rowland.org>
Message-ID: <CADApbegr5RBODJD=4UZ5Skn_N91oxwDFDxnS7Qqh5dot0EnU-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 30, 2013 at 10:23 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 30 May 2013, Roger Quadros wrote:
>
>> >> So what are your idea about making the PHY layer more generic? How
>> >> ehci-hcd will make use of PHY layer?
>> >
>> >
>> > on probe grab the phy and initialize it. On suspend/resume,
>> > suspend/resume the PHY and so on. Whatever you were going to do on your
>> > ehci glue, do it on generic ehci-hcd.
>> >
>>
>> These operations sound generic enough to be done at HCD layer, no? So no need to
>> replicate the same stuff in ohci, ehci, xhci, etc.
>
> The HCD layer handles suspend and resume only for PCI host controllers.
> Not for other types.
>
> I don't know if the acquire/start and stop/release parts can be moved
> into the USB core.  Maybe they can.
>
> Alan Stern
>
hi
The following is my understanding.
I think for PHY initialization and shutdown part, it is generic for
other parts.
PHY initialization need to be called before hc_driver->reset is called.
I think it can be added at usb_add_hcd.
For PHY shutdown, it can be added at usb_remove_hcd.

For suspend/resume, i do not know how to add it. For our EHCI driver,
when system goes to deep idle states, we just directly shutdown the
hcd and initialize it again when the system goes back.
