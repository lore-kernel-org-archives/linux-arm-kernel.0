From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Jul 2011 22:58:19 +0100
Subject: [PATCH] ARM: move memory layout sanity checking before meminfo
	initialization
In-Reply-To: <CAMbhsRR=EVhKPkNUnzQ_2Ai9edWpmvHM_9TXwhh-xaa9Dk1Mcw@mail.gmail.com>
References: <CAMbhsRT=NNYUYyYZXpz2=PpBXoBGANQHPgOkCE1oZ8XzHKN4og@mail.gmail.com>
	<CAMbhsRSgUcFPpdTFvEDTFfo_Wk0k7BQzwk6cRtXC6K7mpQ+YDg@mail.gmail.com>
	<20110715080950.GL23270@n2100.arm.linux.org.uk>
	<CAMbhsRRCV0ukwbzFc6w_ba6xdVxs=TFmJMGd06UKTiNQPEJqpw@mail.gmail.com>
	<20110715161628.GA24628@n2100.arm.linux.org.uk>
	<CAMbhsRSbXTLzhSzBbQ8ebJqAC227ESHGyY2bHS+J4cN+NgzXFg@mail.gmail.com>
	<20110715181309.GD24628@n2100.arm.linux.org.uk>
	<CAMbhsRQRjwskzWB06g7rmSVgSdq5oVxA3yY+14qdtTxuQ=NeMQ@mail.gmail.com>
	<20110715210720.GF24628@n2100.arm.linux.org.uk>
	<CAMbhsRR=EVhKPkNUnzQ_2Ai9edWpmvHM_9TXwhh-xaa9Dk1Mcw@mail.gmail.com>
Message-ID: <20110715215819.GG24628@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2011 at 02:18:59PM -0700, Colin Cross wrote:
> The thread has devolved into a generic command line problem - how to
> pass completely unrelated options from the bootloader to the kernel
> without also having to pass in every other option that the kernel
> requires to boot.  I have a solution that works for my case
> (CMDLINE_EXTEND), I was trying to offer a solution that would work for
> me while also working for multi-board kernels, but I'm happy to drop
> it.

You miss the point.

The kernel command line was originally intended as a way to pass
arguments to the kernel from the boot loader which the _user_ can
freely edit.  As such, it contains various options which can be
enabled by adding an option - such as changing the kernel console,
specifying the memory layout.  These options once given can't be
disabled or revoked by later options.

The reason for that is because the options are cumulative.  For
example:

	console=tty1 console=ttyS0 console=ttyAMA0

results in kernel messages being output on the VT console, first ttyS
port, and first ttyAMA port.  If the first two are part of a built-in
command line, there is no way to disable that.

The same applies for the mem option, with the requirement that passed
memory information is non-overlapping.

Hence using these options in a built-in command line with
CMDLINE_EXTEND is just _wrong_ if you later want to try and override
them.  It doesn't work like that.

And the last point is: passing something like "mem=64M mem=96M" has
_never_ been supported on _any_ ARM kernel by any means, irrespective
of the setting of the CMDLINE_xxx options.

The real clintcher on this is: what are the correct semantics for
this?  Consider these scenarios:

1. mem=64M on the built-in command line.  You pass mem=96M to the
   kernel from the boot loader.  Do you expand to 96M or stick with
   the original 64M ?

2. mem=96M on the built-in command line.  You pass mem=64M to the
   kernel from the boot loader.  Do you stick with 96M or shrink
   to the new 64M given?

3. mem=64M mem=64M at 128M on the built-in command line.  You pass in
   mem=32M.  What does that mean for the 64M at 128M ?

What's right there for one person is not right for another.  So, rather
than getting into a debate where there is no right solution, I'm just
going to say that the idea of passing overlapping mem= arguments is
a broken concept.
