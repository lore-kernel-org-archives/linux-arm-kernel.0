From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Wed, 18 Nov 2015 02:09:04 +0000
Subject: [PATCH v3] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <alpine.LFD.2.20.1511171155240.5826@knanqh.ubzr>
References: <1447362108-4333-1-git-send-email-chris.brandt@renesas.com>
 <1447697140-4099-1-git-send-email-chris.brandt@renesas.com>
 <alpine.LFD.2.20.1511161515100.5826@knanqh.ubzr>
 <HK2PR06MB05619FACB3725B6F5B2299718A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511161605070.5826@knanqh.ubzr>
 <HK2PR06MB056196B2E169A504A16ED9738A1D0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511171155240.5826@knanqh.ubzr>
Message-ID: <HK2PR06MB0561B7675F17A81B54A65CA28A1C0@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So after looking back in history, I think I now understand how/when the XIP stuff broke.

It looks like originally, the init section came first, followed by text and data.

This is why all the XIP code used _etext as its marker for the end of what needed to be mapped.
Like you said, the initialized data values get copied from ROM to RAM early in boot so it's not an issue if the data section (that comes after text) gets blown away when the full MMU setup is done.


However, after the init section was moved from the first section to almost the last, all the _etext references scatter through the kernel were never updated.


So basically, even though I've now got a separate linker script for XIP builds, it really hasn't changed much because the real issue all along was that the XIP_KERNEL references to _etext should have been changed to _data_loc.

With that said, I still think the correct way to fix this issue is to export _data_loc and use that as the end marker. (notice I changed my mind and now say _data_loc instead of _edata_loc because there's no reason to map the full data section anymore).

The other option, if we really wanted to keep the references to _etext as they are, is to simply move the one line " _etext = .;" to the bottom of the file....right before _data_loc is declared.
But...that would be a bit misleading if you ask me.


It sounds like there would still be a request to split up the linker scripts in order to remove the 6 XIP_KERNEL references scattered  throughout vmlinux.lds.S. However, it would still be nice to keep the two versions looking as close as they can to each other with only the obvious changes (like removing XIP_KERNEL from the non-XIP version, and removing SMP_ON_UP from the XIP version)


Thoughts?


Chris
