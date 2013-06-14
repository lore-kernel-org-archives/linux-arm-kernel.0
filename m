From: xiechao.mail@gmail.com (Chao Xie)
Date: Fri, 14 Jun 2013 09:55:25 +0800
Subject: [PATCh V10 04/12] usb: ehci: ehci-mv: use PHY driver for ehci
In-Reply-To: <CADApbeh_RT9nmHK29a2b_Hw3S0ptvNvr9_neWdw7ig5wzc-_SA@mail.gmail.com>
References: <CADApbegr5RBODJD=4UZ5Skn_N91oxwDFDxnS7Qqh5dot0EnU-Q@mail.gmail.com>
 <Pine.LNX.4.44L0.1306131106160.1561-100000@iolanthe.rowland.org>
 <CADApbeh_RT9nmHK29a2b_Hw3S0ptvNvr9_neWdw7ig5wzc-_SA@mail.gmail.com>
Message-ID: <CADApbehtqANXPBix-h8hngitEKKjEq3SYT1EOihwwg=FtJX3Pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 9:31 AM, Chao Xie <xiechao.mail@gmail.com> wrote:
> On Thu, Jun 13, 2013 at 11:08 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> On Thu, 13 Jun 2013, Chao Xie wrote:
>>
>>> >> These operations sound generic enough to be done at HCD layer, no? So no need to
>>> >> replicate the same stuff in ohci, ehci, xhci, etc.
>>> >
>>> > The HCD layer handles suspend and resume only for PCI host controllers.
>>> > Not for other types.
>>> >
>>> > I don't know if the acquire/start and stop/release parts can be moved
>>> > into the USB core.  Maybe they can.
>>> >
>>> > Alan Stern
>>> >
>>> hi
>>> The following is my understanding.
>>> I think for PHY initialization and shutdown part, it is generic for
>>> other parts.
>>> PHY initialization need to be called before hc_driver->reset is called.
>>> I think it can be added at usb_add_hcd.
>>> For PHY shutdown, it can be added at usb_remove_hcd.
>>
>> Yes, that should work.
>>
> Fine, i can add a patch for that. My usb phy patches are pending on it.
>
>>> For suspend/resume, i do not know how to add it. For our EHCI driver,
>>> when system goes to deep idle states, we just directly shutdown the
>>> hcd and initialize it again when the system goes back.
>>
>> You shut down the host controller?  Then how does it detect wakeup
>> events?  And how does it know if a device was disconnected while the
>> power was off?
>>
> Hi
> I think maybe my suspend/resume is not same as what you think.
> The suspend/resume i mean is the peripharal sub system suspend/resume
> states. When SOC enter this low power mode,
> the clock to usb, power to usb are all shut down.
> When the controller is shut down, i think that usb_remove_hcd will
> help to remove all the attached devices.
> We do not rely on usb host controller to wake up the whole sub system.
> If a device is disconnected while the power was off, when the host
> controller is powered again, it will do initialization again, and all
> the attached devices are susposed be removed already.
>
>
hi
I am sorry that i unerstand it wrong.
I checked with the code in our 3.4 git. we really did a lot of things
when suspend/resume, and at that point the patch for ehci_resume and
ehci_suspend are not added.
i think the driver can make use of ehci_resume/ehci_suspend.
For PHY, we have to initialize it and shutdown it when do
suspend/resume. Our PHY do not have any suspend states.
I suppose these phy operation have to be handled by each ehci driver
owner only, or you think it can be handled at ehci-hce level?.

>> Alan Stern
>>
