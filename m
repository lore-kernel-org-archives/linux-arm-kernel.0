From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Sep 2011 19:51:21 +0100
Subject: Link failures due to __bug_table in current -next
In-Reply-To: <CAPnjgZ2-Ttmoa8zwSVqL70vXDoJv=-Z2XyVBuTi-bm4-0c6E-Q@mail.gmail.com>
References: <20110919120954.GA20314@opensource.wolfsonmicro.com>
	<20110919200317.GC16381@n2100.arm.linux.org.uk>
	<CAPnjgZ3+b=nhApZxV1aBGejxEr7MGN1e8neP-ychtVO2Ego2yQ@mail.gmail.com>
	<20110920075916.GD16381@n2100.arm.linux.org.uk>
	<CAPnjgZ2-Ttmoa8zwSVqL70vXDoJv=-Z2XyVBuTi-bm4-0c6E-Q@mail.gmail.com>
Message-ID: <20110920185121.GA17169@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2011 at 10:00:06AM -0700, Simon Glass wrote:
> On Tue, Sep 20, 2011 at 12:59 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > It's not that simple though - if you read the quote from the linker manual,
> > the implication is that the linker would be entirely free to discard an
> > input section as a priority if it appears in a discard section anywhere
> > in the linker script. ?There's nothing to say future linkers won't do
> > this. ?It would still be conformant to the linker manual.
> 
> Oh dear. That is why it might be a good idea to hassle the linker
> people, since relying on experiments on how things currently work
> might be risky if someone leaps in and changes the algorithm.

Or we just ensure that we conform to the apparant looseness of the
manual, and make the addition of EXIT_TEXT etc in DISCARDS conditional
(which is effectively what I'm doing with my patch.)

That means we're no longer reliant on trusting the linker to do what
we want for this (we _do_ still trust it for the unwind information,
but I think that's less of an issue.)

> Hmm even more out there, I wonder if we can modify the BUG macro to
> put the bug table entry into one of two separate depending on whether
> BUG is in an __exit function or not? Then at link time, either concat
> the two tables, or just ignore the exit one...

That was the same thought for the SMP alternatives problem - I think
Nicolas proposed that there should be some way that the linker can
do sections based on the current section name.  That'd allow us to
have .alt.smp.exit.text and __bug_table.exit.text etc.

> In any case, it sounds from the next email in this thread that your
> patch has fixed the problem! So, where does that leave us?

I think we apply the patch, which resolves the problem, and point it
out to whoever looks after the asm-generic/vmlinux.lds.S file (Arnd?
I'll check when I re-dock the laptop later this evening.)  I suspect
Arnd is already reading some of these messages...
