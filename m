From: xiechao.mail@gmail.com (Chao Xie)
Date: Mon, 17 Jun 2013 14:12:31 +0800
Subject: [PATCh V10 04/12] usb: ehci: ehci-mv: use PHY driver for ehci
In-Reply-To: <Pine.LNX.4.44L0.1306141553030.3152-100000@netrider.rowland.org>
References: <51BADD6D.5040600@ti.com>
 <Pine.LNX.4.44L0.1306141553030.3152-100000@netrider.rowland.org>
Message-ID: <CADApbehH9wrNZEmAN=3ZWGMXA7Jetgd+VpWfMRBSX0AqUeG0pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 15, 2013 at 4:01 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Fri, 14 Jun 2013, Roger Quadros wrote:
>
>> >> hi
>> >> The following is my understanding.
>> >> I think for PHY initialization and shutdown part, it is generic for
>> >> other parts.
>> >> PHY initialization need to be called before hc_driver->reset is called.
>> >> I think it can be added at usb_add_hcd.
>> >> For PHY shutdown, it can be added at usb_remove_hcd.
>> >
>> > Yes, that should work.
>>
>> I don't think this will work with OMAP USB host controller when used in
>> Transceiver-less mode (e.g. HSIC). In this mode we need to release the HSIC
>> reset (mapped to PHY init), after the EHCI controller is up and running.
>>
>> On the other hand, in the PHY mode, the PHY needs to be initialized (brought out
>> of reset) before the EHCI controller starts.
>
> In other words, transceiver-less mode effectively works without using a
> software-controlled PHY?
>
>> This behavior might be different on other controllers. Generalization is good
>> as long as there is an override available for the controllers to handle the
>> PHY init/shutdown themselves.
>
> To avoid PHY init/shutdown, the platform driver should simply leave the
> generic PHY pointer (which has not yet been added to struct hcd) set to
> NULL.
>
So does it mean that i need add adtional usb_phy to struct hcd?
I think we can still make use of struct hcd->phy without add addtional members.
For OMAP transceiver-less mode, you can still use your own phy init/shutdown and
leave the hcd->phy to be NULL, and for the PHY mode, hcd->phy can be
set. It will
do ->init at usb_add_hcd and ->shutdown at usb_remove_hcd.

>
> Alan Stern
>
