From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Tue, 24 May 2011 13:33:47 +0100 (BST)
Subject: [RFC PATCH] ARM hibernation / suspend-to-disk support code
In-Reply-To: <20110523163758.GA2442@arm.com>
References: <3DCE2F529B282E4B8F53D4D8AA406A07014FFE@008-AM1MPN1-022.mgdnok.nokia.com>
	<alpine.DEB.2.00.1105181257370.2374@localhost6.localdomain6>
	<20110520113758.GA3141@arm.com>
	<20110520180510.GE7445@n2100.arm.linux.org.uk>
	<20110523100132.GC2370@arm.com>
	<20110523101220.GH17672@n2100.arm.linux.org.uk>
	<20110523111631.GD3769@arm.com>
	<20110523161149.GB15138@n2100.arm.linux.org.uk>
	<20110523163758.GA2442@arm.com>
Message-ID: <alpine.DEB.2.00.1105241324190.10891@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 May 2011, Dave Martin wrote:

> On Mon, May 23, 2011 at 05:11:49PM +0100, Russell King - ARM Linux wrote:
[ ... ]
>> I tend to suggest that the header file is the right place, because that's
>> where the interface is defined.  Other people argue that its more likely
>> to be seen in the implementation (fiq.c).  So I'm tempted to say both,
>> but lets go with fiq.h for the time being.
>
> OK -- the {get,set}_fiq_regs patch is currently in your patch system.
>
> If you have no objection, I'll submit a patch adding the above text to apply
> on top of the other patch (or, if possible, orthogonally).
>
> ---Dave

Thanks a lot !

>
>>
>>> That argument may apply to a ton of state in the Secure World, not just
>>> the FIQ registers
>>
>> It very much does, and I know OMAP has some kind of SMC call to handle
>> this.
>

Yes, _omap_sram_idle() does that bit, it gives a physical address to the 
OMAP ROM code to save/restore the "secure state" in, triggered via smc.

Anyway, architecturally it seems to be much cleaner to _allow_ device 
drivers (or machine-specific hooks) to save/restore _more_ state than 
whatever the "core suspend code" would do, instead of _forcing_ the core 
suspend code to do everything-and-the-kitchen-sink.
That's where things like FIQ or secure state would be.

FrankH.
