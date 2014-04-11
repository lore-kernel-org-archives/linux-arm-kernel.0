From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 11 Apr 2014 15:39:12 +0400
Subject: [PATCH] ARM: shmobile: r8a7790: link PCI USb devices to USB PHY
In-Reply-To: <CANqRtoSub2TULO2rURiODz1VFXNUqe5gi488mkPtq_F+Oje2cQ@mail.gmail.com>
References: <201404092318.26231.sergei.shtylyov@cogentembedded.com>	<CANqRtoQeuT=Q9PRYNMqA079gjb1VkwgvcDmsWKxjzSVxcVfeWw@mail.gmail.com>	<534674B5.6080706@cogentembedded.com>	<5346E717.4040507@cogentembedded.com>
 <CANqRtoSub2TULO2rURiODz1VFXNUqe5gi488mkPtq_F+Oje2cQ@mail.gmail.com>
Message-ID: <5347D460.3070803@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.04.2014 9:48, Magnus Damm wrote:

>>>> Thanks for this patch, good to see that the relationship between the
>>>> USB Host and the PHY is described via DT.

>>>> This patch seems to cover USB0 and USB2 that both require special
>>>> control in the PHY. How about USB1? Can you explain about the reason
>>>> why you omit that?

>>>      Because the driver does nothing for USB1 anyway.

>>     Looks like I should have tested that last minute change: kernel oopses
>> due to NULL pointer dereference somewhere in phy_get() once it gets called
>> for EHCI on the channel #1. At least doesn't seem to be my mistake...

> No worries, thanks for looking into fixing that.

> Regarding the USB ports on R-Car Gen2 in general and especially USB1,
> it is my impression that even though there is no USB controller
> selection available for USB1 I still believe the UGCTL.CONNECT bit
> shall be used for power management purpose.

    I don't think so. As I said the EHCI driver happily works without touching 
this bit.

> I may of course be wrong, but since the PHY hardware is shared between
> USB0, USB1 and USB2

    I believe it's a wrong impression (which probably my and Valentine's PHY 
drivers have created). The PHY actually belongs to USBHS only; UGCTRL2 
register is some kind of ad-hockery in this PHY.

> it makes sense to have some kind of usage counter

    Generic PHY core already maintains such counters for phy_{init|exit}() and 
phy_power_{on|off}() calls.

> and manage the hardware enable bit based on registered users somehow.
> There is no need to manage this bit at this point IMO, but in the
> future we may want to add such handling to improve power management.

    I handle this bit but only for USBHS. What is actually necessary for all 
USB controllers is enabling the USBHS clocks in order for UGCTRL2 to work.

> And that can only happen if DT is used to connect all USB controllers
> with the PHY, so please make sure to describe the complete
> dependencies in DT.

    I cannnot represent USBHS in the device tree yet. I think I can represent 
xHCI there but I was told it needs the firmware in order to work -- which we 
don't have, so I'm not sure about xHCI testing.

> Thanks,

> / magnus

WBR, Sergei
