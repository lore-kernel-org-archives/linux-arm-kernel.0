From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 23 Apr 2016 01:15:03 +0200
Subject: [PATCH 1/2] ARM: PIE infrastructure
In-Reply-To: <20160404100052.GS19428@n2100.arm.linux.org.uk>
References: <1459668234-16033-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1459668234-16033-2-git-send-email-alexandre.belloni@free-electrons.com>
 <20160404100052.GS19428@n2100.arm.linux.org.uk>
Message-ID: <20160422231503.GE17051@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2016 at 11:00:52 +0100, Russell King - ARM Linux wrote :
> > +	/* Copy chunk specific code/data */
> > +	fncpy((char *)chunk->addr, code_start, code_sz);
> 
> Sorry, NAK.  This abuses fncpy().  There is extensive documentation on
> the proper use of this in asm/fncpy.h, and anything that does not
> conform, or which uses memcpy() to copy functions, gets an immediate
> NAK from me.  fncpy() exists to avoid people doing broken things, and
> it's written in such a way to help people get it right.

Well, do you want me to iterate and use fncpy on all the functions from
the generated binary?

I'm not sure this is necessary as the generated binary is self contained
and doing so will force me to also ensure the offsets are kept the same.
Doing only one copy is much more convenient. However, I still need to
ensure the destination address is properly 8-byte aligned and the
flush_icache_range().
I understand this is abusing fncpy() but it does want I need (still, I'm
planning to avoid the BUG() by always passing a properly aligned
destination address).

I've fixed the issue with big endian that was reported byt the kbuild
test robot and I'd like a bit more advice on how to go forward, thanks!

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
