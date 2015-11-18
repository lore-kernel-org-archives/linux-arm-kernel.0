From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Nov 2015 09:30:04 +0100
Subject: [PATCH v3] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <alpine.LFD.2.20.1511172129060.22569@knanqh.ubzr>
References: <1447362108-4333-1-git-send-email-chris.brandt@renesas.com>
 <HK2PR06MB0561B7675F17A81B54A65CA28A1C0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511172129060.22569@knanqh.ubzr>
Message-ID: <5236157.AUJjCLOEeJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 November 2015 22:17:41 Nicolas Pitre wrote:
> On Wed, 18 Nov 2015, Chris Brandt wrote:
> 
> > It sounds like there would still be a request to split up the linker 
> > scripts in order to remove the 6 XIP_KERNEL references scattered 
> > throughout vmlinux.lds.S. However, it would still be nice to keep the 
> > two versions looking as close as they can to each other with only the 
> > obvious changes (like removing XIP_KERNEL from the non-XIP version, 
> > and removing SMP_ON_UP from the XIP version)
> 
> I don't think so. XIP and non-XIP are fundamentally looking different 
> these days.  Trying to keep them as similar as possible is rather an 
> impediment to both cases and brings no real benefits.
> 
> Not only should .init.smpalt be gone from the XIP version, but it might 
> be safer to put that into a special "should_be_empty" section and bail 
> out with ASSERT() if that section size isn't zero. Same thing for 
> pv_table. This way we'll be sure that nothing in the kernel config 
> expects self-modified code to be present.
> 
> With XIP there is still an init section, but it is pointless to store 
> .init.text stuff in there. That should instead stay in ROM and never be 
> discarded (obviously). No need to page align it either at that point 
> which should save some ROM space.
> 
> Things like .kprobes.text should be in ROM, but the entire executable in 
> ROM should be surrounded by __kprobes_text_start and __kprobes_text_end 
> to prevent any attempt to put kprobes there. This way, kprobes could 
> still work for modules.
> 
> Etc. Etc.
> 
> There are simply too many things these days that require special 
> considerations with XIP. And freeing the main script from XIP 
> considerations will ease maintenance as well, more than the added 
> maintenance from the duplicated parts.

[Adding Uwe and Maxime to Cc]

I believe Uwe has been running XIP_KERNEL on efm32 for a while now,
but he also mentioned that he needed some extra hacks in the linker
script and elsewhere to get it to work.

It would be good to coordinate this, he may have found additional
problems, or he can maybe help test the new approach on his hardware.

	Arnd
