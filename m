From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Jan 2011 11:31:11 +0000
Subject: Why call calibrate_delay() in smp.c: secondary_start_kernel()
In-Reply-To: <ebe9b3d6a0cc160cd46a97ae05b72119@mail.gmail.com>
References: <4D3552C2.3020101@stericsson.com>
	<ebe9b3d6a0cc160cd46a97ae05b72119@mail.gmail.com>
Message-ID: <20110118113111.GA9719@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 18, 2011 at 03:46:54PM +0530, Santosh Shilimkar wrote:
> I did send a patch on the same some time back but the conclusion
> was we still need to have calibration.
> 
> Have one more patch do deal with it so that platform can choose
> if they like to skip. My mailer might screw the patch hence attaching
> the same

Actually, the secondary cores probably get a far more accurate lpj
than the primary core as they don't have the interference from the
timer interrupt.  So - if we care - we probably want to update the
primary lpj with the secondary's calibration value at boot.

On the measurements I've made a couple of weeks ago, the lpj value
can be .7% too slow, resulting in udelay() giving shorter than
requested delays.  I asked Linus about that, and he's happy with
that figure.

So the myth which floats around on various lists about udelay() giving
at least the requested delay is just that - a myth.  It has always
given _approximately_ the requested delay on all architectures with
software loop based implementations (as well as, according to Linus,
some x86 tsc implementations of udelay.)
