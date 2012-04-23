From: B08287@freescale.com (Liu JunJie-B08287)
Date: Mon, 23 Apr 2012 02:02:02 +0000
Subject: =?utf-8?B?UkU6ICDnrZTlpI06IFtSRkMgUEFUQ0ggMC84XSBNWFM6IEFkZCBpLk1YMjgg?=
 =?utf-8?Q?USB_Host_driver?=
In-Reply-To: <201204201825.30833.marex@denx.de>
References: <1334657751-27678-1-git-send-email-marex@denx.de>
 <20120418074058.GM3852@pengutronix.de>
 <3A731164757B504AB3594CB17706857808D523@039-SN2MPN1-012.039d.mgd.msft.net>
 <201204201825.30833.marex@denx.de>
Message-ID: <3A731164757B504AB3594CB17706857808F803@039-SN2MPN1-012.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call me Tony, :), and search [Tony] for the embedded comments.

-----Original Message-----
From: Marek Vasut [mailto:marex at denx.de] 
Sent: Saturday, April 21, 2012 00:26
To: Liu JunJie-B08287
Cc: Sascha Hauer; Chen Peter-B29397; linux-arm-kernel at lists.infradead.org; Detlev Zundel; Fabio Estevam; Li Frank-B20596; Linux USB; Guo Shawn-R65073; Shawn Guo; Stefano Babic; Subodh Nijsure; Heikki Krogerus; Shi Make-B15407
Subject: Re: ??: [RFC PATCH 0/8] MXS: Add i.MX28 USB Host driver

Dear Liu JunJie-B08287,

> hi Sascha,
>    As the previous mail Peter post, we have two concerns about the new 
> arch of USB drvier as followed: 1. If the USB clock and the PHY are 
> centralized managed by the OTG driver, it will introduce an 
> unnecessary dependency between gadget/host function and OTG driver. 
> That means even gadget/host function is the individual function that 
> customer wanted, we need add OTG driver as well, otherwise, without 
> the PHY and clock support provided by OTG driver, the gadget/host 
> function can't work at all. But from the general viewpoint, the 
> gadget/host function is independent of OTG function, this unnecessary 
> dependency or limitation for customer is not reasonable. Furthermore, 
> this dependency will face much difficulty in some extreme case that 
> some customer only needs host function only but with the OTG ID floating, it was a real case we encounted before.

Can't this be fixed by passing of proper platform data to the imx-otg?

[Tony] Yes, such special patch or say special parameter in the interface between OTG and gadget/host can resolve such issue. But I don't think it is a good way to design the arch, with more and more special parameter added into the interface will make the interface un-readable and hard to understand. 

> 
>    2. If the USB clock and the PHY are centralized managed by the OTG 
> driver, it will introduce an unavoidable remote wakup issue that: 
> Since the USB suspend is separated into two parts: the USB host 
> controller suspend (set portsc.suspend bit to 1)  part which is 
> controlled by host driver and PHY suspend part (set portsc.phcd to 1) 
> which is controlled by OTG driver, during the system suspend, these 
> two parts will be executed in sequence, but the interval between these two parts is out of control.
> Refer to USB spec 2.0, the remote wakeup can happen anytime after 5ms 
> later from bus entered suspended state(set portsc.suspend bit to 1), 
> it means it can happen before, after, even during PHY suspend part executing.
> Taking the following case into accounted, PHY suspend process is 
> executing, the pseudo code as below: {
>             ...
>             some checking for the remote wakeup;
>                                       <------------------ remote 
> wakeup happen here set portsc.phcd to 1;
>             ...
>         }

Do we support this yet? Besides, you can make sure phy suspends before the controller ... and if the controller detects RW during suspend, it can fail to suspend and that brings the system back up.
[Tony] 1. It is a requirement that we must support. If a modem connected to host, if no communication on modem, the host and modem will enter in suspend mode, and system may try to enter suspend mode too; but the modem may issue remote wake up signal at any time which comply with the usb spec 2.0, we must support this to make the modem wakeup system, and keep modem working well. 

       2. How could this happen that phy suspends before the controller? 
          The phy enter into suspend when the data line state is in J mode, or in 3 ms not receive sof. If suspend phy first but keep controller in running/active mode, means the line state is not J, and the sof will not stop, how could the phy retain in suspend mode.

       3. even phy suspends before the controller comes to be true, the issue still exist, the interval between the time stamp that controller finishes detecting RW during suspend, and the time stamp that controller really enter into suspend still exists, RW happens within this interval will have the same issue with before.  
    

>         At such situation, one issue will be generated that the USB 
> controller is pulling up the resume signal (K), but at the same time, 
> the SW may set PHY to low power mode(set PHCD to 1), it may cause 
> unpredictable result. As in our i.MX platform the response to this 
> remote wakeup(pulling up K signal) is out of SW control, and it can 
> happen at anytime (5ms later after bus in suspended state), this issue 
> is unavoidable.
> 
>         The safest solution for this issue is setting portsc.phcd 
> within 5ms after bus in suspended state(set portsc.suspend bit to 1), 
> it requires USB host controller suspend and PHY suspend must be 
> executed uninterruptably, natively they can't be separated.
> 
>      The above is the shortcoming we thought about the new arch, and 
> we want to know what are you thinking about the shortcoming of current 
> arch, what makes you think the current arch had to be changed.
> 
> ________________________________________
> ???: Sascha Hauer [s.hauer at pengutronix.de]
> ????: 2012?4?18? 15:40
> ?: Chen Peter-B29397
> Cc: Marek Vasut; linux-arm-kernel at lists.infradead.org; Detlev Zundel; 
> Fabio Estevam; Li Frank-B20596; Linux USB; Guo Shawn-R65073; Shawn 
> Guo; Stefano Babic; Subodh Nijsure; Heikki Krogerus; Liu 
> JunJie-B08287; Shi Make-B15407
> ??: Re: [RFC PATCH 0/8] MXS: Add i.MX28 USB Host driver
> 
> On Wed, Apr 18, 2012 at 04:31:50AM +0000, Chen Peter-B29397 wrote:
> > > Your patches won't work when more than one USB port is enabled 
> > > because of the singular usb transceiver present in the kernel. 
> > > That of course is not your fault. I think Heikki (Added to Cc) is 
> > > working on this issue, but I don't know the status here.
> > > 
> > > Another problem is that what you are doing does not integrate at 
> > > all with otg. I don't ask you to implement otg support because you 
> > > are likely not interested in this, but since you are adding a new 
> > > ehci glue driver anyway I suggest another approach:
> > > 
> > > Put a driver under drivers/usb/otg which:
> > > 
> > > - matches a 'imx-usb' device
> > > - gets/enables all clocks needed for USB
> > > - finds the transceiver
> > > - registers a ehci device
> > > 
> > > Future additions would be:
> > > 
> > > - Put a USB_MODE_HOST/DEVICE flag into platform_data, and register 
> > > a
> > > 
> > >   host or gadget driver depending on this flag
> > > 
> > > - Add a USB_MODE_OTG flag to platform_data and implement otg in 
> > > this
> > > 
> > >   driver (or use whatever infrastructure present in the kernel 
> > > then)
> > > 
> > > This is similar to what msm does. This way we have the clocks and 
> > > phys handled where they are needed. We may use this code on i.MX later.
> > > 
> > > We did this wrong on i.MX (and several other architectures) and 
> > > getting this right will be hard work. No need to introduce the 
> > > same flaws again with a new architecture.
> > 
> > Hi Sascha,
> > 
> > We have been discussing i.mx usb re-structure at freescale internal 
> > during this periods, one side does not agree with otg driver manages 
> > PHY/clock solution due to below reasons:
> > 
> > - May confuse the users who only use device or host function, the 
> > users may double "why I need to include otg file to support 
> > device/host only function"?
> 
> I can't find anything confusing in this.
> 
> > - For some special cases, like device sends resume signal(remote 
> > wakeup) after host suspend, but before otg suspend (system needs to 
> > refuse to
> > suspend) . It needs to add hcd flag to judge if there is a remote 
> > wakeup after host suspend, and if the port is sending resume signal 
> > now (when the port is sending resume signal, we can't put power to 
> > low power mode). Is it suitable to put some hcd stuffs at otg driver?
> 
> I can't follow you here what the actual problem is, but since the otg 
> driver is the driver for host and gadget (which happens to pass 
> control to either the host or the gadget driver most of the time) it 
> is ok to do whatever it takes in the otg driver to make it work.
> 
> > - Any disadvantages three individual drivers manage PHY/clock 
> > separately after the generic PHY layer/FSL PHY driver have finished? 
> > It can define where to get/put PHY/clock operation at individual 
> > drivers clearly. When OTG switch, for host mode, the hcd struct 
> > (includes interrupt) will be free/created using 
> > usb_remove_hcd/usb_add_hcd, for device mode, we can deinit/init udc like current ci13xxx_udc.c at ci13xxx_vbus_session does.
> 
> I once made a quick hack using the msm otg driver on i.MX. I had to 
> comment out some msm specifics but after that it worked quite well.
> 
> Sascga
> 
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

Best regards,
Marek Vasut
