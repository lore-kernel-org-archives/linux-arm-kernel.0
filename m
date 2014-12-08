From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Dec 2014 18:11:08 +0100
Subject: [PATCH v2 1/5] gpio: Cygnus: define Broadcom Cygnus GPIO binding
In-Reply-To: <5485D7F8.6090305@broadcom.com>
References: <1418006316-324-2-git-send-email-rjui@broadcom.com>
 <2594176.SCRFa6Sb3O@wuerfel> <5485D7F8.6090305@broadcom.com>
Message-ID: <9945772.cPNxB9AH25@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 December 2014 08:55:20 Ray Jui wrote:
> 
> On 12/8/2014 3:22 AM, Arnd Bergmann wrote:
> > On Sunday 07 December 2014 18:38:32 Ray Jui wrote:
> >> +Required properties:
> >> +
> >> +- compatible:
> >> +    Currently supported Cygnus GPIO controllers include:
> >> +    "brcm,cygnus-ccm-gpio": ChipcommonG GPIO controller
> >> +    "brcm,cygnus-asiu-gpio": ASIU GPIO controller
> >> +    "brcm,cygnus-crmu-gpio": CRMU GPIO controller
> >
> > How different are these? If they are almost the same, would it
> > be better to use the same compatible string for all of them and
> > describe the differences in extra properties?
> >
> > If they are rather different, maybe you should have a separate
> > binding and driver for each?
> >
> > 	Arnd
> >
> They are quite similar with the following minor differences:
> 1) ChipcommonG GPIO controller uses a separate register block 
> (0x0301d164) to control drive stregnth
> 2) Cannot control drive strength for the CMRU GPIO

This can be deducted from having one or two register blocks I
assume.

> 3) CRMU GPIO controller's interrupt is not connected to GIC of A9. 
> Currently that's taken care of by using a "no-interrupt" device tree 
> property

No need for this property even, just see if there is an "interrupts"
property or not.
 
> I can change to use the common compatible string "brcm,cygnus-gpio". 
> With an introduction of property "no-drv-stregnth" which should be set 
> for CRMU GPIO controller. 

Ok.

> For ChipcommonG GPIO, it will have a second 
> register block defined, so we'll know to use that second register block 
> for drive strength configuration. For the rest, we assume normal drive 
> strength configuration (i.e., ASIU in our case).

Maybe see if something older than cygnus was already using a compatible
gpio controller and then use the name of that.

> Looking at this again, it looks like the "no-interrupt" property is 
> really redundant. For GPIO controller without interrupt connected to A9, 
> we can simply leave its interrupt properties not defined. I'll get rid 
> of it along with the above changes.

Right.

	Arnd
