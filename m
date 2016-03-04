From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Mar 2016 11:02:10 +0000
Subject: DWord alignment on ARMv7
In-Reply-To: <CAKv+Gu8D37DgfbopvB1On_=fNqrBzmCmOCTotX2Lvv6NoSCtvw@mail.gmail.com>
References: <56D8BA3F.7050508@pengutronix.de> <20160303235426.GA11237@arm.com>
 <CAKv+Gu8D37DgfbopvB1On_=fNqrBzmCmOCTotX2Lvv6NoSCtvw@mail.gmail.com>
Message-ID: <20160304110210.GA19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 04, 2016 at 11:48:10AM +0100, Ard Biesheuvel wrote:
> I don't think it is the job of the filesystem driver to reason about
> whether get_unaligned_le64() does the right thing under any particular
> configuration. If ARM's implementation of get_unaligned_le64() issues
> load instructions that result in a trap, it is misbehaving and should
> be fixed.

It's not ARMs implementation, we don't have our own implementation, but
we seem to (today) use asm-generic stuff, which is sub-optimal.

Looking at the state of that, I guess we need to implement our own
asm/unaligned.h - and as the asm-generic stuff assumes that all
access sizes fall into the same categories, I'm guessing we'll need
to implement _all_ accessors ourselves.

That really sounds very sub-optimal, but I don't see any other solution
which wouldn't make the asm-generic stuff even more painful to follow
through multiple include files than it already is today.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
