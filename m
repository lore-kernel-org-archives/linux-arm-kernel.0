From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 7 Jun 2013 11:21:01 +0200
Subject: [PATCH 2/5] arm: preserve ATAGS in /chosen/atags in the Device
 Tree
In-Reply-To: <alpine.LFD.2.03.1306061253430.18597@syhkavp.arg>
References: <1370414409-29991-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370414409-29991-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130606142851.6dd17cad@skate>
 <alpine.LFD.2.03.1306061253430.18597@syhkavp.arg>
Message-ID: <20130607112101.2cedbc5f@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Nicolas Pitre,

On Thu, 6 Jun 2013 13:27:38 -0400 (EDT), Nicolas Pitre wrote:

> > I'd be interested to hear your opinion about the below proposal, that
> > allows platform-specific code to do its own parsing of ATAGS
> > information, without cluttering the generic code.
> 
> Personally, I don't like it.
> 
> Not that the code itself is extremely ugly.  That is not the point.
> 
> This opens the door to laziness on the part of bootloader authors and 
> system integrators which will simply (ab)use this mechanism as this 
> allows them to sit on what they already have instead of making the extra 
> mile to bring things into conformance.  And overtime this means 
> maintenance nightmare for us.
> 
> I'm sorry but the only leverage we have to create some incentive for 
> people to do the right thing is exactly to say no to such kind of 
> accommodation.
> 
> If Marvell has done things improperly in the past, it is for them to pay 
> the maintenance cost of their choices, not for mainline to carry them.

Well, I don't think what you say here is really fair. Before the DT was
in place, unless I missed it, there was no standard way of letting the
bootloader pass MAC addresses to the kernel. And Marvell's development
on those Armada 370/XP platforms predates the introduction of the
Device Tree in the Linux kernel (the code we have originally been give
was a 2.6.3x), so it's really not their fault to not have a DT-capable
bootloader at this point.

The ARM_APPENDED_DTB and ARM_ATAG_DTB_COMPAT thing were added precisely
for this situation: the hardware platform was designed at a time where
the DT was not yet used/widespread on ARM, so the bootloaders for those
hardware platforms is not DT-capable. What I'm proposing here is a
minimally intrusive extension of this idea, in the exact same scenario.

Moving from the ATAG-based boot method to the DT-based method was a
mainline decision, and pragmatically, we should give SoC vendors enough
time to switch their entire boot infrastructure to this new boot
protocol. This is why ARM_APPENDED_DTB was created in the first place.
So please don't put the entire fault on Marvell on this one :)

Marvell will release a DT-capable U-Boot in some time, that will
properly adjust the MAC addresses in the DTB before handing it over to
the kernel. We are currently working with Marvell to define which
actions the bootloader should do on the DTB before handing it over to
the kernel. I believe this is a sufficient proof that there is no
laziness from Marvell's side and that things are progressing towards a
full DT based boot protocol.

But in the mean time, just like we have this ARM_APPENDED_DTB and
ARM_ATAG_DTB_COMPAT workarounds, I thought we could do the same to
allow platform-specific code to parse some platform-specific ATAGs.
That would be so much better for the current users of Armada 370 and
Armada XP platforms.

> If I were you I'd try to bring the bootloader into conformance instead.  
> That can be achieved in many ways:
> 
> First, you should try to add support for older platforms into mainline 
> U-Boot.  That's always the preferable option.
> 
> The next best option is to get the Marvell U-Boot source code (U-Boot is 
> GPL so the source must be available) and add minimal DT support to 
> it.

As I mentioned earlier, Marvell is going to release one relatively soon.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
