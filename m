From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Feb 2017 14:28:47 +0000
Subject: [PATCHv3] arm: ftrace: Adds support for
 CONFIG_DYNAMIC_FTRACE_WITH_REGS
In-Reply-To: <20170210120306.GA6825@nuc>
References: <1486508275-18449-1-git-send-email-abelvesa@linux.com>
 <20170209162956.GH27312@n2100.armlinux.org.uk>
 <CACh+v5NJ5zi4nEQkG+y_SesFuW8NOophD1KDFRG+t7=CtjnNrg@mail.gmail.com>
 <20170210120306.GA6825@nuc>
Message-ID: <20170210142847.GK27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2017 at 12:03:06PM +0000, Abel Vesa wrote:
> The only problem I don't have a solution for at this point is OLD_LR (or
> previous LR as it is called in this patch).

If you want the context at function entry, then you need to save the
registers as they were at that point.

The stacking of LR in the gnu_mcount thing is there to avoid this problem:

a:
	push	{lr}
	bl	__gnu_mcount_mc

That "bl" instruction can be thought of as being effectively this:

	adr	lr, 1f
	b	__gnu_mcount_mc
1:

and from that, you can plainly see that "lr" gets corrupted by the call.
So, to save the register state as it was at point "a", you need to
save (in order):

	r0 through to sp
	the saved lr on the stack (which was the value of lr at point a)
	the current lr (which is the value of the PC _after_ __gnu_mcount_mc
		returns)
	cpsr
	write zero to old_r0

Stacking actual value of the PC at the point that you're stacking these
registers is really senseless - it doesn't convey any useful information
about the context being saved.

Does it make sense to leave the compiler's saving of lr on the stack?
Probably not - which I think my last iteration overwrote with the old_r0
value.  The only thing my last iteration did not do was save a real value
for CPSR.

I didn't test it either...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
