From: trd@45mercystreet.com (Toby Douglass)
Date: Tue, 24 Nov 2009 16:33:21 +0100
Subject: CAS implementation may be broken
In-Reply-To: <1258989196.8088.28.camel@pc1117.cambridge.arm.com>
References: <4B08055C.3000408@45mercystreet.com>
	<1258989196.8088.28.camel@pc1117.cambridge.arm.com>
Message-ID: <4B0BFCC1.7070600@45mercystreet.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I wrote:
> We have a CAS where the exchange and compare are guaranteed to be only those which exist continuously and without modification between the loading, compare and potential set of the destination. 

Ah, this isn't true.  The compare and exchange values could be modified 
after their LDR but before the STREX.  Apologies - basic mistake :-/

So in fact what you have is a guarantee you will only use values for 
compare and exchange which exist *after* you've loaded your destination.

I don't think this is useful for anything; it's no different to having 
them loaded before the LDREX.  What's more, I think I can do this now 
anyway, in GCC; pass pointers in and in the assembly, use "*exchange" 
rather than "exchange".

I understand now what Catalin means about using LDREX to load them as 
well (which you can't do, I believe; you can't nest LDREX on one core).
