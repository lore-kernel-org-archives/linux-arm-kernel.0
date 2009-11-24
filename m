From: trd@45mercystreet.com (Toby Douglass)
Date: Tue, 24 Nov 2009 10:38:57 +0100
Subject: CAS implementation may be broken
In-Reply-To: <20091123231353.GJ18142@n2100.arm.linux.org.uk>
References: <4B08055C.3000408@45mercystreet.com>
	<20091123222830.GA5598@shareable.org>
	<20091123231353.GJ18142@n2100.arm.linux.org.uk>
Message-ID: <4B0BA9B1.9050803@45mercystreet.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:

[snip]

No comments on everything else and the other posts; still digesting them.

> I believe there is a solution to the ABA problem using atomic operations
> with one 32-bit word and a separate counter to identify updates, but it
> requires a little more time than I have available this evening to fully
> put together.

I've implemented the pointer-counter solution on x86/x64.  Indeed, it 
turns out you can use them on ARM, since there is a double-word ldrex. 
However, and this is part of what I'm currently thinking about, I was 
under the impression LL/SC meant *single word CAS* could work without a 
counter.

I think you'd never implement pointer-counter in the kernel, as your 
basic CAS, because plain CAS is all you need for certain things and the 
user can easily implement pointer-counter on top of plain CAS.

OTOH, perhaps it is nice to offer a plain CAS API and an ABA-safe CAS API.
