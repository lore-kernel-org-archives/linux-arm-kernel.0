From: trd@45mercystreet.com (Toby Douglass)
Date: Wed, 25 Nov 2009 19:57:18 +0100
Subject: CAS implementation may be broken
In-Reply-To: <1259147516.30270.51.camel@pc1117.cambridge.arm.com>
References: <4B0C5D1D.6040603@45mercystreet.com>
	<1259147516.30270.51.camel@pc1117.cambridge.arm.com>
Message-ID: <4B0D7E0E.4030203@45mercystreet.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So, I'm thinking now; where does this leave us?

We see that LDREX/SDREX cannot be used on their own in a single word CAS 
to prevent ABA since we cannot rely on using LDR inside an LDREX/SDREX 
pair.  (You guys knew this; I'm just stating it here to lead in).

This means you must use a pointer-counter pair (with its potential for 
failure) or memory handling; the same situation as we find on x86 and 
x64, for example.  That's okay - not perfect, but we're not deficient 
compared to other common platforms.

I think however it leaves open one question; do we wish for the 
LDREX/SDREX CAS to fail if destination has been modified, or to retry, 
as it does now.

 From a lock-free data structure point of view, failure on modification 
is more efficient, since we will always need to recompute our exchange 
value; going to the extra trouble of forcing the CAS (which will then 
fail anyway, because the counter part of the pointer-counter pair will 
not match) is a waste of time.

The behaviour we have now can be easily implemented (a loop) on top of 
the non-retry CAS; but the non-retry CAS behaviour cannot be implemented 
on top of what we have now.

However, the world and his dog expects x86/x64 style behaviour - we can 
do better, but it may not be what users expect.

Ah - there is one other issue - it seems reasonable that the CAS that 
exists now should be extended to support 8 byte swaps, since it already 
supports 1, 2 and 4 byte swaps.
