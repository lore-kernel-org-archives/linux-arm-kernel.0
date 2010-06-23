From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 23 Jun 2010 10:19:48 -0400 (EDT)
Subject: [PATCH 1/2] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and
	check for it on V6
In-Reply-To: <20100623133636.GC7058@shareable.org>
References: <20100621133749.24299.36154.stgit@baageli.muru.com>
	<20100621135120.24299.98499.stgit@baageli.muru.com>
	<20100622170020.GF4371@shareable.org>
	<20100623073912.GA12255@atomide.com>
	<20100623133636.GC7058@shareable.org>
Message-ID: <alpine.LFD.2.00.1006231002530.24097@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Jun 2010, Jamie Lokier wrote:

> For other things like __switch_to and maybe cache maintenance calls,
> dmb() etc, I'd suggest first doing a generic asm mechanism like x86's
> "alternatives", keeping in mind that one of the alternatives has to be
> XIP friendly.

You cannot be XIP friendly unless you rewrite the concerned function(s) 
into a RAM page in order to modify it.  And then of course you have to 
play tricks with the linker so that the rewritten functions are 
referenced with their final rewritten location.  And that means of 
course that the RAM location has to be a constant unless we introduce 
some indirect function calls.  And at that point we're not much better 
than the proposed runtime test.

Also, if you are interested by a XIP kernel, this usually means you have 
a fairly highly customized kernel config.  In this context it is 
senseless to have runtime patching of the kernel.  What you want in that 
case is as much stuff as possible selected and optimized at compile 
time, and anything you don't need configured out.

So it would be best if dynamic function patching could be statically 
generated from the same source when XIP is active.


Nicolas
