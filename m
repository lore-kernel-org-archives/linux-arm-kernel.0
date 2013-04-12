From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Fri, 12 Apr 2013 16:16:35 +0200
Subject: [PATCH] SPI: spidev: Add DT compatible string for spidev driver.
In-Reply-To: <51680C91.6030005@free-electrons.com>
References: <20130412125621.9645.78102.stgit@localhost>
 <51680C91.6030005@free-electrons.com>
Message-ID: <51681743.4020001@parkeon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 12/04/13 15:30, Maxime Ripard wrote:
> I submitted a similar patch quite some time ago [1], and at the time, 
> this patch was found inadequate, and we decided to add the compatible 
> of the particular device that we drive through spidev. 

Thanks for pointing this out.

> The rationale behind that is that the device tree is a hardware 
> description, so it's only interested about which device there is on 
> the SPI bus, and not the driver that will eventually handle it. That 
> allows both to have a meaningful devicetree, but also to easily handle 
> the case where a driver for that particular device is finally 
> implemented, since we won't have to change the device tree in itself 
> to reflect this. 

I'm not sure this is really an advantage of using a "real" compatible 
string.

When a kernel driver is finally implemented it will not have the same 
userspace interface as spidev.

This means that the switch from spidev to the kernel driver will not be 
transparent to userspace.

So, if a "real" compatible string is used, upon upgrading to a new 
version of the kernel that adds support for that device userspace will 
break.

Using a generic compatible string allows the board maintainer to decide 
when to switch by updating the DT.

Of course, when a custom kernel is being configured and compiled, the 
problem can also be solved by not enabling the new driver but I thought 
one of the goals of DT was to enable using a single distribution style 
binary kernel images on multiple boards.

Note that my patch only changes the driver, not any DTS.
Indeed I agree that _using_ a generic compatible string in an _in 
kernel_ DTS would be a mistake for the reasons you point out.

The use case I'm talking about is where a mainline kernel is used but 
with a custom out of tree DTS - why force people to patch the driver for 
this use case?

Best regards,

Martin
