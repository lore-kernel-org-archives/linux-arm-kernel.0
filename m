From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 6 Jun 2013 13:27:38 -0400 (EDT)
Subject: [PATCH 2/5] arm: preserve ATAGS in /chosen/atags in the Device
 Tree
In-Reply-To: <20130606142851.6dd17cad@skate>
References: <1370414409-29991-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370414409-29991-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130606142851.6dd17cad@skate>
Message-ID: <alpine.LFD.2.03.1306061253430.18597@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 6 Jun 2013, Thomas Petazzoni wrote:

> Russell, Nicolas,
> 
> I'd be interested to hear your opinion about the below proposal, that
> allows platform-specific code to do its own parsing of ATAGS
> information, without cluttering the generic code.

Personally, I don't like it.

Not that the code itself is extremely ugly.  That is not the point.

This opens the door to laziness on the part of bootloader authors and 
system integrators which will simply (ab)use this mechanism as this 
allows them to sit on what they already have instead of making the extra 
mile to bring things into conformance.  And overtime this means 
maintenance nightmare for us.

I'm sorry but the only leverage we have to create some incentive for 
people to do the right thing is exactly to say no to such kind of 
accommodation.

If Marvell has done things improperly in the past, it is for them to pay 
the maintenance cost of their choices, not for mainline to carry them.

If I were you I'd try to bring the bootloader into conformance instead.  
That can be achieved in many ways:

First, you should try to add support for older platforms into mainline 
U-Boot.  That's always the preferable option.

The next best option is to get the Marvell U-Boot source code (U-Boot is 
GPL so the source must be available) and add minimal DT support to 
it.

Those two options imply a bootloader upgrade of course.  I know that 
people are scared at the prospect of updating their bootloader, however 
this can be made quite safe if the upgrade is implemented with care.

Alternately you could use a second stage bootloader (or third stage in 
some cases) that is executed from the existing U-Boot.  That second 
stage bootloader can be as simple as a little executable blob that only 
converts the legacy/proprietary ATAGs into a proper device tree and pass 
it on to the already loaded kernel in memory.  That second stage 
bootloader doesn't necessarily have to load files -- the original U-Boot 
is well capable of loading more than just a kernel + initrd into memory 
e.g. it can be scripted to load the kernel, the initrd, the desired DTB 
and this shim binary, and execute the later.  The shim and the DTB don't 
normally have to change, so a user could then enjoy upgrading the kernel 
at will and use standard booting interfaces without even being aware of 
the presence of that shim which only needs to be installed once.


Nicolas
