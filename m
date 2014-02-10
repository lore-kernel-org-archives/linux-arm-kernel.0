From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 10 Feb 2014 16:28:22 +0000
Subject: [RFC PATCH] ARM: Add imprecise abort enable/disable macro
In-Reply-To: <20140210151934.GZ26684@n2100.arm.linux.org.uk>
References: <1391789955-26927-1-git-send-email-fabrice.gasnier@st.com>
 <1391789955-26927-2-git-send-email-fabrice.gasnier@st.com>
 <20140207170903.GT5976@mudshark.cambridge.arm.com>
 <52F892C8.80508@st.com>
 <20140210111710.GC17766@mudshark.cambridge.arm.com>
 <20140210135659.GU26684@n2100.arm.linux.org.uk>
 <20140210144228.GC2794@e103592.cambridge.arm.com>
 <20140210151934.GZ26684@n2100.arm.linux.org.uk>
Message-ID: <20140210162822.GF2794@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 03:19:34PM +0000, Russell King - ARM Linux wrote:
> On Mon, Feb 10, 2014 at 02:42:28PM +0000, Dave Martin wrote:
> > Should we require CPSR.A to me masked in Booting, for all CPUs that have
> > it?
> 
> If it's not masked at boot, then there can't be an imprecise exception
> pending.

Couldn't there still be a dangling abort condition triggered by the
bootloader, which which doesn't raise the abort pin until after we
entered the kernel?

> That's unlike interrupts, where a device could trigger an interrupt at
> any moment (eg, a timer expiring.)


List as with interrupts, there's no way to drain or cancel pending aborts
that aren't asserted yet, but whose cause conditions are already
established.

It's possible that Strongly-Ordered memory is sufficient to
guarantee that any D-side abort becomes synchronous in some
implementations but I don't think the arhitecture guarantees it.

It certainly won't be guaranteed for any other memory type.


For these reasons, imprecise aborts seem a lot like interrupts:
you can mask them or handle them; but controlling when and whether
they occur involves platform-specific assumptions, at least in
theory.

Cheers
---Dave
