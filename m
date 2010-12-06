From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Dec 2010 17:16:57 +0000
Subject: [PATCH v3] ARM: vexpress: add support for multiple core tiles
In-Reply-To: <006f01cb9563$faf32210$f0d96630$@deacon@arm.com>
References: <1291052921-30695-1-git-send-email-will.deacon@arm.com>
	<20101206155310.GG31777@n2100.arm.linux.org.uk>
	<006f01cb9563$faf32210$f0d96630$@deacon@arm.com>
Message-ID: <20101206171657.GH31777@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 06, 2010 at 04:38:15PM -0000, Will Deacon wrote:
> Hi Russell,
> 
> > The other complication here is that the possible/present bitmaps use
> > logical CPU numbers, which depending on the platform may or may not
> > be the same as physical CPU numbers, even though it may be an A9 based
> > platform.
> 
> Eek. What sort of mapping do you get between logical and physical CPU
> numbers for these platforms? Are the logical numbers offset from the
> physical ones or is there just a random mapping between the two?

We currently have a 1:1 mapping between the two, but only because that's
a choice made entirely by the platform code.  The common code makes no
assumptions about the cpu number space it is using.

There are two places where logical and physical CPU numbers interact
come together:

1. boot_secondary / early startup code (via pen_release)
2. IPI sending in the GIC code

and this is where any platform can decide to place a mapping for whatever
reason.
