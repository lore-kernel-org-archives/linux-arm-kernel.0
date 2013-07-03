From: satish.patel@ti.com (Patel, Satish)
Date: Wed, 3 Jul 2013 09:32:58 +0000
Subject: [PATCH v9 0/8] Generic PHY Framework
In-Reply-To: <1372247257-30186-1-git-send-email-kishon@ti.com>
References: <1372247257-30186-1-git-send-email-kishon@ti.com>
Message-ID: <780E789C2E067A4BB8F69D0BB9EC4F253E975B5E@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

> -----Original Message-----
> From: ABRAHAM, KISHON VIJAY
> Sent: Wednesday, June 26, 2013 5:17 PM
> To: grant.likely at linaro.org; tony at atomide.com; Balbi, Felipe; ABRAHAM,
> KISHON VIJAY; arnd at arndb.de; swarren at nvidia.com;
> sylvester.nawrocki at gmail.com; linux-kernel at vger.kernel.org; linux-
> omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> usb at vger.kernel.org; gregkh at linuxfoundation.org; akpm at linux-
> foundation.org
> Cc: rob.herring at calxeda.com; rob at landley.net; linux at arm.linux.org.uk;
> benoit.cousson at linaro.org; mchehab at redhat.com; cesarb at cesarb.net;
> davem at davemloft.net; Nayak, Rajendra; shawn.guo at linaro.org; Shilimkar,
> Santosh; devicetree-discuss at lists.ozlabs.org; linux-
> doc at vger.kernel.org; Nori, Sekhar; Krishnamoorthy, Balaji T; Cherian,
> George
> Subject: [PATCH v9 0/8] Generic PHY Framework
> 
> Added a generic PHY framework that provides a set of APIs for the PHY
> drivers
> to create/destroy a PHY and APIs for the PHY users to obtain a
> reference to
> the PHY with or without using phandle.
> 
> This framework will be of use only to devices that uses external PHY
> (PHY
> functionality is not embedded within the controller).
> 
> The intention of creating this framework is to bring the phy drivers
> spread
> all over the Linux kernel to drivers/phy to increase code re-use and
> to
> increase code maintainability.

I would like to use this framework for a smart-card controller connected to a
smart-card phy. I have some questions and would like to get feedback on the same.

I am using ?TDA8026" Smartcard PHY from NXP. Here is the link for datasheet
and app note for the same. The smart card controller is inside the TI SoC
I am working with.

Datasheet : 
www.nxp.com/documents/data_sheet/TDA8026.pdf?

Appnote :
http://www.nxp.com/documents/application_note/AN10724.pdf

The TI SoC details are not public (yet). I can provide details to you offline.

Brief about operation:
-	The controller can work with and without a PHY
-	When not using PHY, it is limited to talking to a single
	smart card. There is also a need to put external de-activation logic
	on card removal for this case.
-	With a PHY you can use more than one smart card.
-	Phy has 5 slots :  1 for smart card (credit/debit/other card with chip) 
      and others for SAM ? SIM like modules
- 	Once the PHY is initialized, there are some operations that the controller
	can request of the PHY like:
	- Card configurations  - set voltage
	- Activation of card
	- ATR ? Answer to reset
	- Warm reset
	- ADPU exchange
	- Deactivation ( Normal/Emergency)
- 	In the mode when smartcard controller talks directly to the card	without the need
	for a PHY, all the above operations will be carried	out by the controller itself

My current thought process is to make the controller driver provide the user interface
and talk to the PHY using the generic PHY framework you proposed. In the case where there
is no PHY, my idea is to create a "dummy" PHY which uses the controller functionality itself.

What I seem to be missing from the PHY framework is support for event detection and generic
read/write API which will enable the controller to talk to the PHY for the operations listed
above and also react to events from the PHY.

Is there a reason why such functionality has not been included. If it was only a case
of lack of use case, then do you think it will be useful to extend the framework to add
such functionality? I can help with the development.

Thanks,
Satish
