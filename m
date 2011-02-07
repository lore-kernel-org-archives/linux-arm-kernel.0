From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Feb 2011 13:34:57 +0000
Subject: [PATCH v3 2/5] ARM: pm: add generic CPU suspend/resume support
In-Reply-To: <AANLkTintBD2Gfb3pkPZPe2mreU5EatUnNwUqR-id7q+M@mail.gmail.com>
References: <20110206191117.GA17808@n2100.arm.linux.org.uk>
	<E1PmA28-0000AC-2t@rmk-PC.arm.linux.org.uk>
	<20110207120103.GC31929@n2100.arm.linux.org.uk>
	<20110207121052.GD31929@n2100.arm.linux.org.uk>
	<AANLkTintBD2Gfb3pkPZPe2mreU5EatUnNwUqR-id7q+M@mail.gmail.com>
Message-ID: <20110207133457.GE31929@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

http://en.wikipedia.org/wiki/Posting_style#Trimming_and_reformatting

It's really not nice to page down and down and down to find out the one
or two lines that actually contain something useful - or in my case
scroll through the first three pages, then go to the bottom and start
scrolling up.  It wastes time.

Please *always* trim the quoted text down to the context that's relevant
for your reply, like this:

On Mon, Feb 07, 2011 at 03:21:51PM +0200, saeed bishara wrote:
> On Mon, Feb 7, 2011 at 2:10 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > +ENTRY(cpu_resume_mmu)
> > + ? ? ? adr ? ? r4, cpu_resume_turn_mmu_on
> > + ? ? ? mov ? ? r4, r4, lsr #20
> > + ? ? ? orr ? ? r3, r3, r4, lsl #20
> > + ? ? ? ldr ? ? r5, [r2, r4, lsl #2] ? ?@ save old mapping
> > + ? ? ? str ? ? r3, [r2, r4, lsl #2] ? ?@ setup 1:1 mapping for mmu code
> this code doesn't look smp save, it modifies page table that could be
> used by another cpu. I suggest to create (at  boot time) identity page
> table and use it in order to do mmu on.

When you suspend/resume, the other CPUs will be hot-unplugged before
suspend, and hot-plugged after resume.  SMP issues really don't come
in here, and there's not really many other ways to solve the inherent
races involved with turning on the MMU.
