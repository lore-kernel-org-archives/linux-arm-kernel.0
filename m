From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Mar 2015 19:21:52 +0000
Subject: [PATCH v2 0/2] ARM: /proc/cpuinfo: DT: Add support for Revision
In-Reply-To: <alpine.LFD.2.11.1503161238560.27567@knanqh.ubzr>
References: <201502271645.58765@pali>
 <1425052528-18995-1-git-send-email-pali.rohar@gmail.com>
 <20150302112836.GA27317@amd> <20150316154409.GQ5264@atomide.com>
 <20150316161449.GJ8656@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1503161238560.27567@knanqh.ubzr>
Message-ID: <20150316192152.GL8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 16, 2015 at 12:43:47PM -0400, Nicolas Pitre wrote:
> Your publicly visible tree contains only a few mundane patches.
> Is that the tree you're testing with?  If no then could you publish it 
> for others to have a look and test?

Okay, having investigated three cases of this, ended up mostly at
dead-ends, and having talked to Will, I think the conclusion is that
no one really understands what's going on here. :p

A number of people (including people within ARM) have seen the problem
that I've seen with a variety of kernel versions, including versions
which I haven't seen a problem with.

My own investigations turn up patches which don't have that much to do
with the SMP booting itself: yes, one was a L2C patch, but I've had
that for a very long time.  The FIQ changes for the GIC which shouldn't
have affected it.  Olof's MMC patches to support resets and regulators
which we don't even get to, so couldn't affect it /code-wise/.

What all these have in common is an influence on the layout of the
kernel image.  Exactly what that is, I don't know yet - I've not had
the time to be able to investigate that deeply as I've been trying to
characterise the failure and track it down to an easy "this works,
this doesn't" test case.  I now have that with a kernel without MMC
changes vs a kernel with MMC changes - where I know that the actual
changes have nothing to do with the problem itself.

There's only one person (not me) who has been able to get a reasonable
amount of debug so far - Sudeep (@arm) has found that both CPU0 and CPU1
are stuck in the radix code, but merely using the debugger "frees" them
from there.

Now that I'm aware that _others_ are or have seen the same issue I am,
I can worry slightly less about the issue... and what it confirms to
me is that it's less about what the kernel code is, more about the
placement of kernel code.

The unfortunate side effect is that it cuts down on the amount of useful
testing I can do prior to sending stuff to Linus... but C'est la vie.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
