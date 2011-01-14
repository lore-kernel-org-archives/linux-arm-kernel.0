From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Jan 2011 17:43:39 +0000
Subject: [PATCH 1/1 v2] ARM: Thumb-2: Symbol manipulation macros for
	function body copying
In-Reply-To: <AANLkTikiR+XN4Jb9GSEdUUiOciLvxqXB+NA3DEWhNCga@mail.gmail.com>
References: <1294951905-23748-1-git-send-email-dave.martin@linaro.org>
	<1294951905-23748-2-git-send-email-dave.martin@linaro.org>
	<20110113235524.GB28040@n2100.arm.linux.org.uk>
	<AANLkTi=QRDt62wgnHW6ya+956BS9x7pQj2voTiF+H0vs@mail.gmail.com>
	<AANLkTikiR+XN4Jb9GSEdUUiOciLvxqXB+NA3DEWhNCga@mail.gmail.com>
Message-ID: <20110114174339.GC22505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 14, 2011 at 11:15:19AM -0600, Dave Martin wrote:
> There's another problem which I hadn't spotted before:
> 
> In the Thumb case, we risk violating the alignment constraints of the
> code which gets copied (actually, this is also true of the ARM case,
> but less likely to bite).  This matters because the code may contain
> literals and other data words -- quite likely given the requirement
> for self-containedness.

There's a solution to this - require that the thumb function is
preceded by a .align 3 (which according to the GAS documentation I
have means for ARM, it aligns the PC to 1 << 3 not 3 bytes.)

Also require 8-byte alignment from the allocation function, and make
fncpy() bug if the destination isn't 8-byte aligned.  Same for the
source function argument (but ignoring bit 0 of course.)

We don't then have to mess with rounding allocation sizes up, nor worry
about aligning the destination according to the source or any other
games like that.

The down-side is wastage of maybe 7 bytes a function, but that's
probably going to happen anyway.
