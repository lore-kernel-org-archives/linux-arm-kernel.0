From: ryan@bluewatersys.com (Ryan Mallon)
Date: Mon, 02 Nov 2009 08:54:27 +1300
Subject: Possible suspend/resume regression in .32-rc?
In-Reply-To: <20091031013427.GL14091@buzzloop.caiaq.de>
References: <20091031013427.GL14091@buzzloop.caiaq.de>
Message-ID: <4AEDE773.4080800@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack wrote:
> Is anyone using suspend/resume with a recent git mainline kernel on PXA
> or other ARM embedded boards? My platform used to suspend and resume
> just fine on 2.6.31 but now as I rebased it, it fails the resume part.

Are you using the same .config? I have had drivers with dodgy
suspend/resume code before. You could try removing unneeded drivers and
see if the problem still exists.

> Unfortunately, I can't bisect it as the platform is not mainline yet and
> so I always have mandatory patches (without my platform won't do
> anything) on top of the git repository. Which breaks the bisect logic.

You can do the bisect by creating a patch (or series of patches) between
mainline and your code. Do the bisect on the clean mainline and then
apply the patch on top of the bisect point at each stage.

> What puzzles me is that I see the current raising at wakeup time, so at
> least the processor seems to resume, but I can't see any serial console
> output, just like if the kernel crashed very early after wakeup.
> 'no_console_suspend' didn't help either.

You could try enabling CONFIG_DEBUG_LL and adding the following to
kernel/printk.c just above the call to vscnprintf:

	{
		extern void printascii(const char *);
		printascii(printk_buf);
	}

The alternative is to connect to the unit with a JTAG debugger and get a
stack trace and print the contents of __log_buf (the printk buffer).

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
