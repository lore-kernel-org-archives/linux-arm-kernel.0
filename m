From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Jun 2011 22:14:00 +0200
Subject: [PATCH] USB: ehci: use packed,
	aligned(4) instead of removing the packed attribute
In-Reply-To: <20110620193213.GL26089@n2100.arm.linux.org.uk>
References: <Pine.LNX.4.44L0.1106201329390.2113-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.1106201449320.2142@xanadu.home>
	<20110620193213.GL26089@n2100.arm.linux.org.uk>
Message-ID: <201106202214.00998.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 June 2011 21:32:13 Russell King - ARM Linux wrote:
> > Here the d member is not naturally aligned.  On most architectures, 
> > including ARM with the ABI currently in use, the compiler would insert a 
> > 32-bit padding between c and d.
> 
> And if 'struct foo' represents a structure in device memory, the end
> result is highly unpredicable whether or not you have padding or
> accessors to load 'd' there.  So, you would not have such a structure
> describing a data structure in memory returned by ioremap().

Right.

> Now, the real question is: is there any architecture which is (or may
> be) supported by the Linux kernel which would add padding to:
> 
> struct foo {
>         u8 a;
>         u8 b;
>         u16 c;
>         u32 d;
>         u64 e;
> };

This is the other issue, which we were facing in the scsi drivers.
If an architecture requires padding because some members require
larger than natural alignment here, the 'packed' should be applied
to that member, in order to change the alignment of that member.

	Arnd
