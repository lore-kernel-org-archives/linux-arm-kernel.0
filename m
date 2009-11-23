From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 23 Nov 2009 15:34:39 +0000
Subject: CAS implementation may be broken
In-Reply-To: <4B08055C.3000408@45mercystreet.com>
References: <4B08055C.3000408@45mercystreet.com>
Message-ID: <1258990479.8088.39.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2009-11-21 at 15:21 +0000, Toby Douglass wrote:
> Load-linked/conditional-store architectures solve ABA by having the
> store fail if the destination has been touched since the load was performed.

So, for your problem, CAS wouldn't solve it on any architecture, not
just ARM if it is implemented with LL/SC.

Something like below may work (untested and haven't put much thought
into it). Basically you need atomicity between the moment you first get
the head pointer and the moment you update it. CAS doesn't ensure this
since the first load of the [head] pointer would be standard LDR (even
if it is LDREX, you get another LDREX which resets the link with the
STREX):

1:	LDREX	orig_head, [head]
	LDR	orig_next, [orig_head, #next]
	STREX	res, orig_next, [head]
	cmp	res, #0
	bne	1b

-- 
Catalin
