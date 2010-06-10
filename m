From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 10 Jun 2010 14:40:10 -0400 (EDT)
Subject: [PATCH 4/5] [ARM] Auto calculate ZRELADDR and provide option for
	exceptions
In-Reply-To: <20100610090015.GD3422@pengutronix.de>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<1275550613-9553-5-git-send-email-eric.miao@canonical.com>
	<20100610090015.GD3422@pengutronix.de>
Message-ID: <alpine.LFD.2.00.1006101429050.30664@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Jun 2010, Uwe Kleine-K?nig wrote:

> >  - or the assumption of the zImage being loaded by the boot
> >    loader within 256MB from the start address is simply
> >    incorrect
> Hmmm, this makes the image depending on the bootloader.  Not that nice.
> 
> What do you think about requiring r4 to be set to physoffset as I did in
> my series?  This way zImage would already know PHYSOFFSET and so didn't
> need to guess ZRELADDR.

No.  That would make the dependency on the bootloader even _worse_.

And the fact is that most ARM targets have 256MB of RAM or less anyway, 
making this condition pretty hard to miss.  For those very few targets 
out there with more than 256MB of RAM it is rather safe to presume that 
they do load zImage/uImage in the first 256MB of RAM already, and making 
this condition effective for the future is not that bad.  And if you 
*really* can't satisfy that condition which would be really odd, then 
there is still the Kconfig option.

Compared to this, the conditions for the placement of zImage on x86 are 
far more restrictive.  So I much prefer to use generally safe 
assumptions which are compatible with existing bootloaders rather than 
having a new boot requirement for this.


Nicolas
