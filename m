From: mbizon@freebox.fr (Maxime Bizon)
Date: Mon, 17 Feb 2014 22:02:31 +0100
Subject: Recent 3.x kernels: Memory leak causing OOMs
In-Reply-To: <20140216225000.GO30257@n2100.arm.linux.org.uk>
References: <20140216200503.GN30257@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1402161406120.26926@chino.kir.corp.google.com>
 <20140216225000.GO30257@n2100.arm.linux.org.uk>
Message-ID: <1392670951.24429.10.camel@sakura.staff.proxad.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sun, 2014-02-16 at 22:50 +0000, Russell King - ARM Linux wrote:

> http://www.home.arm.linux.org.uk/~rmk/misc/log-20140208.txt

[<c0064ce0>] (__alloc_pages_nodemask+0x0/0x694) from [<c022273c>] (sk_page_frag_refill+0x78/0x108)
[<c02226c4>] (sk_page_frag_refill+0x0/0x108) from [<c026a3a4>] (tcp_sendmsg+0x654/0xd1c)  r6:00000520 r5:c277bae0 r4:c68f37c0
[<c0269d50>] (tcp_sendmsg+0x0/0xd1c) from [<c028ca9c>] (inet_sendmsg+0x64/0x70)

FWIW I had OOMs with the exact same backtrace on kirkwood platform
(512MB RAM), but sorry I don't have the full dump anymore.

I found a slow leaking process, and since I fixed that leak I now have
uptime better than 7 days, *but* there was definitely some memory left
when the OOM happened, so it appears to be related to fragmentation.

>From what I recall, clearing the page cache helped making the box live a
little bit longer. Does it make sense or should alloc_pages() discard
its content when trying to satisfy high order allocations ?

-- 
Maxime
