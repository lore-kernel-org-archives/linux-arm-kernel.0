From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Apr 2016 20:39:41 +0100
Subject: [PATCH 1/2] ARM: PIE infrastructure
In-Reply-To: <20160422231503.GE17051@piout.net>
References: <1459668234-16033-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1459668234-16033-2-git-send-email-alexandre.belloni@free-electrons.com>
 <20160404100052.GS19428@n2100.arm.linux.org.uk>
 <20160422231503.GE17051@piout.net>
Message-ID: <20160427193941.GR19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 23, 2016 at 01:15:03AM +0200, Alexandre Belloni wrote:
> Well, do you want me to iterate and use fncpy on all the functions from
> the generated binary?

No, because that will break the image too.

> I'm not sure this is necessary as the generated binary is self contained
> and doing so will force me to also ensure the offsets are kept the same.
> Doing only one copy is much more convenient. However, I still need to
> ensure the destination address is properly 8-byte aligned and the
> flush_icache_range().

What you need to do is to immitate being an ELF loader - in other words,
copy the blob according to the alignment rules of the blob (which may be
greater than 8-byte alignment) and use the symbol table to find the
functions and the type of the function (ARM vs ELF).

> I understand this is abusing fncpy() but it does want I need (still, I'm
> planning to avoid the BUG() by always passing a properly aligned
> destination address).

Yea yea yea, such arguments don't wash with me, sorry.  The "but it does
what I need" is total bollocks, sorry.  fncpy() is designed for a
purpose, and what you're doing is an abuse of it, one which I will not
stand for for the sake of long term maintainability.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
