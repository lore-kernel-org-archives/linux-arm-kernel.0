From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sat, 28 Nov 2009 21:47:29 +0100
Subject: [PATCH] ARM: Introduce HAVE_IOREAD_AND_IOWRITE macro.
In-Reply-To: <20091128202523.GD497@n2100.arm.linux.org.uk> (Russell King's
	message of "Sat, 28 Nov 2009 20:25:23 +0000")
References: <m3zl6owvvi.fsf@intrepid.localdomain>
	<20091128182439.GB497@n2100.arm.linux.org.uk>
	<m3skbywgr4.fsf@intrepid.localdomain>
	<20091128202523.GD497@n2100.arm.linux.org.uk>
Message-ID: <m37htawf4u.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> The point of the #ifndef is so that you _can_ redefine them.  As illustrated
> above, you want:

This is not what I'm talking about. I know IXP4xx can live without
changing arch/arm/include/asm/io.h. Let's forget about IXP4xx for
a moment.


arch/arm/include/asm/io.h:

/*
 * io{read,write}{8,16,32} macros
 */
#ifndef ioread8
#define ioread8(p)      ({ unsigned int __v = __raw_readb(p); __v; })
#define ioread16(p)     ({ unsigned int __v = le16_to_cpu((__force __le16)__raw_readw(p)); __v; })
#define ioread32(p)     ({ unsigned int __v = le32_to_cpu((__force __le32)__raw_readl(p)); __v; })

#define iowrite8(v,p)   __raw_writeb(v, p)
#define iowrite16(v,p)  __raw_writew((__force __u16)cpu_to_le16(v), p)

(and so on).

This header file defines a bunch of things depending on existence of
this very ioread8 macro. I'm asking about this single "#ifndef ioread8"
line, i.e. if you find defining ioread16, ioread32, iowrite8 etc. based
only on existence of ioread8 to be correct.

If it's indeed correct then I'll just adjust IXP4xx headers accordingly,
there is absolutely no problem from this side.
-- 
Krzysztof Halasa
