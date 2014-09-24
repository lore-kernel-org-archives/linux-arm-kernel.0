From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 24 Sep 2014 11:25:42 +0100
Subject: [PATCH v2 1/8] ARM: add mach-asm9260
In-Reply-To: <54229533.8050607@rempel-privat.de>
References: <1411324904-14881-1-git-send-email-linux@rempel-privat.de>
 <71905861.S3QD6rl7jU@wuerfel> <542136B0.3020305@rempel-privat.de>
 <6072405.iL4RqHeZrt@wuerfel> <54227A30.7010805@rempel-privat.de>
 <20140924094302.GU5182@n2100.arm.linux.org.uk>
 <54229533.8050607@rempel-privat.de>
Message-ID: <20140924102542.GV5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 11:56:03AM +0200, Oleksij Rempel wrote:
> Am 24.09.2014 um 11:43 schrieb Russell King - ARM Linux:
> > The "why" is in the text from your oops dump.  That's precisely /why/ we
> > print that text - so that we know /why/ the fault happened.
> 
> Here is oops message:
> http://pastebin.com/qYWeAyfV
> 
> i can avoid this oops by setting size at least 0x2000 per register
> range. Do it mean my TLB supports only 8 KiB pages?

No, it has nothing to do with the TLB.

Unable to handle kernel paging request at virtual address c2802174
pgd = c0004000
[c2802174] *pgd=21805811, *pte=00000000, *ppte=00000000
Internal error: Oops: 7 [#1] PREEMPT ARM

The number after the Oops: is the FSR value, which means "page translation
fault", and sure enough, the pgd/pte values show that there is no page
table entry at the faulting address.

That's odd, because ioremap() aligns the size of the requested mapping up
to a multiple of the page size, and inserts page table entries according
to the rounded size.

Where are you calling ioremap(), iounmap() etc?  IOW, please show your
code for this.

I also notice that the unwinder failed to unwind the complete backtrace:

[<c02bcb38>] (clk_gate_is_enabled) from [<c02b9a0c>] (clk_disable_unused_subtree+)
[<c02b9a0c>] (clk_disable_unused_subtree) from [<c02b99c8>] (clk_disable_unused_s)

which is really annoying.  Maybe turning frame pointers on will get is a
proper backtrace, though I don't think it's that important to this bug.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
