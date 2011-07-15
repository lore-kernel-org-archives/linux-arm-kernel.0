From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Jul 2011 22:07:20 +0100
Subject: [PATCH] ARM: move memory layout sanity checking before meminfo
	initialization
In-Reply-To: <CAMbhsRQRjwskzWB06g7rmSVgSdq5oVxA3yY+14qdtTxuQ=NeMQ@mail.gmail.com>
References: <CAMbhsRRQ9D+VXTZP3vB7egkROEtN9-FxssFa2EcxuqB3F-Uv6Q@mail.gmail.com>
	<20110714073453.GK23270@n2100.arm.linux.org.uk>
	<CAMbhsRT=NNYUYyYZXpz2=PpBXoBGANQHPgOkCE1oZ8XzHKN4og@mail.gmail.com>
	<CAMbhsRSgUcFPpdTFvEDTFfo_Wk0k7BQzwk6cRtXC6K7mpQ+YDg@mail.gmail.com>
	<20110715080950.GL23270@n2100.arm.linux.org.uk>
	<CAMbhsRRCV0ukwbzFc6w_ba6xdVxs=TFmJMGd06UKTiNQPEJqpw@mail.gmail.com>
	<20110715161628.GA24628@n2100.arm.linux.org.uk>
	<CAMbhsRSbXTLzhSzBbQ8ebJqAC227ESHGyY2bHS+J4cN+NgzXFg@mail.gmail.com>
	<20110715181309.GD24628@n2100.arm.linux.org.uk>
	<CAMbhsRQRjwskzWB06g7rmSVgSdq5oVxA3yY+14qdtTxuQ=NeMQ@mail.gmail.com>
Message-ID: <20110715210720.GF24628@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2011 at 01:58:37PM -0700, Colin Cross wrote:
> On Fri, Jul 15, 2011 at 11:13 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Jul 15, 2011 at 10:35:14AM -0700, Colin Cross wrote:
> >> CMDLINE_EXTEND solves a real problem, and when it's not solved in the
> >> kernel, it ends up getting solved in every bootloader. ?Every
> >> kernel/board requires some command line options (like "console="), and
> >> every bootloader ends up passing some special options.
> >
> > And yet again, if you have a kernel with a built-in console= setting,
> > there is _no_ _way_ to disable that console via the kernel command
> > line.
> >
> > So what if some of your platforms need one console, others need a different
> > console, but must not use the first one...
> >
> > Do we need nomem= and noconsole= options too? ?Or do we just do the
> > sane thing and get rid of CMDLINE_EXTEND - or insist that stuff like
> > console= and mem= options are never built-in ?
> >
> 
> The source of the problem is that there are two kinds of options mixed
> together into one command line:
> 1.  Options that are specific to the kernel and board (console, mem, etc.)
> 2.  Options that tell the kernel information that only the bootloader
> knows (Tegra needs to know where the bootloader put signed resume code
> to be executed by a slave processor, some devices need to get a MAC
> address from the bootloader)
> 
> For kernels that are designed to run on a single board, the kernel
> options can go into the built-in command line, the bootloader options
> can be concatenated with CONFIG_CMDLINE_EXTEND, and everything works
> great (unless I forget to remove the mem= option from the bootloader
> options).

I'm sorry at this point I'm having a hard time taking this seriously.
Really.

Your boot loader doesn't know how much memory is there?  Or if it does
you've chosen not to use ATAG_MEM to pass that information to the kernel,
but instead provide it via the command line.  And then you complain that
two overlapping mem= arguments cause the kernel to explode.

Sorry, I can't take you seriously if that's what you're doing.

ATAG_MEM is there for the boot loader to pass the memory information to
the kernel.  mem= is there to allow overriding that information.

We don't need yet another way to override memory information.  We need
people sanely using what's there already.

NO FIX.
