From: hs@denx.de (Heiko Schocher)
Date: Mon, 07 Dec 2009 13:24:13 +0100
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <20091207114218.GA19348@n2100.arm.linux.org.uk>
References: <4B1911B4.7080907@denx.de>
	<20091204154231.GB20386@n2100.arm.linux.org.uk>
	<4B1931B3.90301@denx.de>
	<20091204163850.GC20386@n2100.arm.linux.org.uk>
	<4B194C8B.7070505@denx.de>
	<20091204191349.GG20386@n2100.arm.linux.org.uk>
	<4B196473.2040407@denx.de>
	<309002C0DA137042828828FC53D7A9347E212D1152@IL-MB01.marvell.com>
	<20091206141601.GB28932@n2100.arm.linux.org.uk>
	<c70ff3ad0912070331y751900dbj62847dddb8521f4d@mail.gmail.com>
	<20091207114218.GA19348@n2100.arm.linux.org.uk>
Message-ID: <4B1CF3ED.9080307@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

Russell King - ARM Linux wrote:
> On Mon, Dec 07, 2009 at 01:31:41PM +0200, saeed bishara wrote:
[...]
>>> If there's no problem with C=0 B=1 mappings on Kirkwood, I've no idea
>>> what's going on, and I don't have any suggestion on what to try next.
>>>
>>> The log shows that the kernel is doing the right thing: when we detect
>>> two mappings for the same page in the same MM space, we clean and
>>> invalidate any existing cacheable mappings visible in the MM space
>>> (both L1 and L2), and switch all visible mappings to C=0 B=1 mappings.
>>> This makes the area non-cacheable.
>> what about the PTE of the MM space of the write process? if it remains
>> C=1 B=1, then it's data will be at the L2, and as the L2 is not
>> flushed on context switch, then that explains this behavior.
> 
> That's probably the issue, and it means that _all_ shared writable
> mappings on your processor will be broken.

Hmm.. I tried also the testprg with CACHE_FEROCEON_L2 deaktivated,
same result ...

> Oh dear, that really is bad news.

Indeed.

> There are two solutions to this which I can currently think of:
> 1. flush the L2 cache on every context switch

To clarify, the testprg runs fine, if I start 4 processes each with
only one read thread. In this case all works as expected. The mess
begins only, if one read process starts more than one read thread ...

> 2. make all shared writable mappings non-cacheable
> 
> Neither of those two options appeals.  Since it's only one set of CPUs
> which are affected, we really don't want to apply any fix for this to the
> generic ARM kernel code - especially when all other L2 caches are sensibly
> implemented as PIPT rather than VIVT.
> 
> Can we please forget that Feroceon CPUs exist? ;)

;-)

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
