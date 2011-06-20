From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Jun 2011 20:32:13 +0100
Subject: [PATCH] USB: ehci: use packed, aligned(4) instead of removing
	the packed attribute
In-Reply-To: <alpine.LFD.2.00.1106201449320.2142@xanadu.home>
References: <Pine.LNX.4.44L0.1106201329390.2113-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.1106201449320.2142@xanadu.home>
Message-ID: <20110620193213.GL26089@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 03:14:26PM -0400, Nicolas Pitre wrote:
> If you need that structure to be packed then so be it and nothing else 
> can be done about it.
> 
> However if you have:
> 
> struct foo {
> 	u32 c;
> 	u64 d;
> 	u32 e;
> };
> 
> Here the d member is not naturally aligned.  On most architectures, 
> including ARM with the ABI currently in use, the compiler would insert a 
> 32-bit padding between c and d.

And if 'struct foo' represents a structure in device memory, the end
result is highly unpredicable whether or not you have padding or
accessors to load 'd' there.  So, you would not have such a structure
describing a data structure in memory returned by ioremap().

Now, the real question is: is there any architecture which is (or may
be) supported by the Linux kernel which would add padding to:

struct foo {
	u8 a;
	u8 b;
	u16 c;
	u32 d;
	u64 e;
};

?

The last gotcha here is struct size.

struct bar {
	u8 a;
	u8 b;
};

May be 2 on some Linux supporting architectures, or may be larger due to
tail padding.  Eg, ARM OABI will add two bytes of tail padding to this.

If we assume that 'struct foo' will be laid out as we desire (iow, no
additional padding with naturally aligned elements) then the only
remaining issue is sizeof(struct), and that's a whole different ballgame.
That shouldn't be solved by packed.
