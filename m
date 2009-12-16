From: chripell@gmail.com (christian pellegrin)
Date: Wed, 16 Dec 2009 17:35:29 +0100
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <20091215171440.GA15855@n2100.arm.linux.org.uk>
References: <20091207175608.GE26821@n2100.arm.linux.org.uk>
	<20091213120033.GA10698@n2100.arm.linux.org.uk>
	<20091213120615.GB10698@n2100.arm.linux.org.uk>
	<cabda6420912140513k40a998b7k8cf56c35cc535cfb@mail.gmail.com>
	<309002C0DA137042828828FC53D7A9347E2630F364@IL-MB01.marvell.com>
	<cabda6420912140948t23c07676tb5f44eb4febbc584@mail.gmail.com>
	<alpine.LFD.2.00.0912141503360.23173@xanadu.home>
	<c70ff3ad0912142350v2231938dqc9c0aedc214120bd@mail.gmail.com>
	<cabda6420912150301n2c1a54d6ta7407d89f4d0f9cf@mail.gmail.com>
	<20091215171440.GA15855@n2100.arm.linux.org.uk>
Message-ID: <cabda6420912160835k714b9de4m7c647da97055f91b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2009 at 6:14 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Try this:
>
> - create a 4K file
> - create three programs:
> ?1. repeatedly uses read() and write() to increment the first word of
> ? ? this file
> ?2. uses one shared mmap of this file to increment the 256th word (offset
> ? ? 1024)
> ?3. uses two shared mmaps of this file, reading the 128th word from one
> ? ? shared mmap, reads the 128th word from the other, increments the
> ? ? first value and writes it to the 128th word in the second map,
> ? ? printing the two values read. ?It also reads the first and 256th
> ? ? word and prints the result
>
> This should be an adequate test of most of the important scenarios: the
> third program should show an increasing number for both locations.
>

I played a bit with the program implementing this idea. With an
unpatched 2.6.32-rc7 from orion git tree all the numbers are actually
incrementing. Of course it's impossible to catch an intermittent
problem with this test because maybe I'm just seeing one update out of
n. I had a similar feeling with my test program about read/write
consistency: sometimes the uncached mapping got the right result and
sometimes not (I did the test on an unload system via console,  so I
really doubt I was implicitly flushing the cache). My guess is that
sometimes the data written through L2 hit the SDRAM. I double checked,
I have L2 working in WB and *not* WT. It's much easier to show the
consistency problem if we print the locations in process 2, now the
128th location is *never* incrementing until I don't trash the cache
running a big program. Somehow read/write is still incrementing. With
the patch I proposed I don't see any problems.

I'm trying some more elaborate tests where just one case of
inconsistency will stop the counting.

-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
