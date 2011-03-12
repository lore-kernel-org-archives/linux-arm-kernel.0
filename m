From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 12 Mar 2011 14:16:19 +0100
Subject: [PATCH 5/8] ARM: PXA: Z2: Add poweroff function
In-Reply-To: <201103121330.22949.anarsoul@gmail.com>
References: <1299839023-16601-1-git-send-email-anarsoul@gmail.com>
	<201103121206.13251.marek.vasut@gmail.com>
	<201103121330.22949.anarsoul@gmail.com>
Message-ID: <201103121416.19327.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 March 2011 12:30:22 Vasily Khoruzhick wrote:
> On Saturday 12 March 2011 13:06:13 Marek Vasut wrote:
> > You have a problem with suspend then ? That'd need a different solution.
> 
> I'm still not sure if resume from deepsleep is possible on Zipit Z2, so
> using deepsleep as poweroff is the only solution we know for now.

Don't use anything for poweroff, you cannot poweroff the device.

> 
> > > Ok, I can clear PSPR before going to deepsleep, would it be enough?
> > 
> > As Eric pointed out, the wake-up scenario is bootloader-specific ...
> > taking into acount only your own version of bootloader is a no-no
> 
> That will work with mainline u-boot, here's pseudocode:
> 
> 1. PSPR = 0x0;
> 2. Put_PXA270_Into_DeepSleep();
> .......
> Wake-up
> .......
> 3. Load RCSR to temporary var
> 4. Clear RCSR bits
> 5. If we resumed from suspend jump to location pointed by PSPR

I know, I wrote the wakeup code for uboot ;-)
> 
> Steps 3-5 are already implemented in u-boot, so it'll jump to 0x0 (NOR), to
> the u-boot entry point. RCSR bits are already cleared, so it just continues
> regular boot process.

What about blob and other bootloaders. U-Boot isn't the only one running on that 
device, right ?

Besides, this is nonsense, you're doing a hack and you're trying to justify it. 
You cannot powerdown the device, period. You should rather patch the bootloader 
to implement this para-powerdown behaviour than bloat kernel with this 
workaround.
> 
> Regards
> Vasily
