From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Oct 2012 07:52:25 +0000
Subject: [RFC PATCH] ARM: vt8500: Convert arch-vt8500 to multiplatform
In-Reply-To: <57461.210.54.1.170.1349994834.squirrel@server.prisktech.co.nz>
References: <1349939831-12939-1-git-send-email-linux@prisktech.co.nz>
 <201210112029.05572.arnd@arndb.de>
 <57461.210.54.1.170.1349994834.squirrel@server.prisktech.co.nz>
Message-ID: <201210120752.25450.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 October 2012, linux at prisktech.co.nz wrote:
> To clarify what you said (because I'm not sure I got it the first time)...
> 
> Keep ARCH_VT8500 as the single-platform Kconfig option.
> Add a new ARCH_VT8500_MULTI (for example) as the multiplatform Kconfig option.
> 
> Have ARCH_VT8500_MULTI select ARCH_VT8500??
> 
> The last bit confuses me (and seems a little backwards, although I suspect it
> would work since none of the options would cause conflicts). Without ARCH_VT8500
> selected, we have no driver options without changing all the Kconfig's.
> 
> If this is correct, we are basically using _MULTI to add more options on top of
> _VT8500.

No, this would not work, because Kconfig does not let you 'select' a symbol
that is inside of a 'choice' list.

The other way round works though: rename the existing ARCH_VT8500 to
ARCH_VT8500_SINGLE, and add a new symbol in arch/arm/mach-vt8500/Kconfig
like

config VT8500
       bool "Via/Wondermedia VT8500 / WM8505 / WM8650" if ARCH_MULTI_V5
       default ARCH_VT8500_SINGLE

This one becomes visible when ARCH_MULTI_V5 is set but invisible in a
other cases. The 'default ARCH_VT8500_SINGLE' statement means it is
automatically enabled (but still invisible) if ARCH_VT8500_SINGLE
is selected in the 'choice', and it's invisible and disabled in all
other cases.

	Arnd
