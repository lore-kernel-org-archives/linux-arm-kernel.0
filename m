From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Mon, 16 Nov 2015 21:02:59 +0000
Subject: [PATCH v3] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <alpine.LFD.2.20.1511161515100.5826@knanqh.ubzr>
References: <1447362108-4333-1-git-send-email-chris.brandt@renesas.com>
 <1447697140-4099-1-git-send-email-chris.brandt@renesas.com>
 <alpine.LFD.2.20.1511161515100.5826@knanqh.ubzr>
Message-ID: <HK2PR06MB05619FACB3725B6F5B2299718A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> For an XIP build, _edata_loc, not _etext, represents the end of the 
>> binary image that will be programmed into ROM and mapped into the 
>> MODULES_VADDR area.
>
> This statement is wrong.  The kernel data is copied to RAM before the
> MMU is turned on and that's the copy that the kernel must use.  There
> is no reason having anything past _etext accessible from ROM.

If I remember correctly, when I first ran into an issue was my
initramfs got cut off because it spanned the 1MB boundary after
_etext.

Also, your init code resides after _etext, so that get cut off
too.


>> With an XIP kernel, nothing is loaded into RAM before boot, meaning 
>> you have to take into account the size of the entire binary image that 
>> was programmed, including the init data values that will be copied to 
>> RAM during kernel boot.
>
> But this is done way before the code you're modifying is executed.

If the MMU is set up to cut everything off after _etext early on, then
anything in the init section gets blown away, and there are lots
of init functions in the kernel that get run at various times during
boot.


>> This fixes the bug where you might lose the end of your kernel area 
>> after page table setup is complete.
>
>Could you elaborate about a possible bug please?

During boot, the kernel attempts to execute code that is not mapped
anywhere, and hence crashes.



-Chris
