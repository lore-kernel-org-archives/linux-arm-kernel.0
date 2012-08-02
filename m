From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Aug 2012 20:44:53 +0100
Subject: [PATCH] ARM: makefile: work around toolchain bug in recent
 versions of binutils
In-Reply-To: <20120802185033.GA2725@mudshark.cambridge.arm.com>
References: <1343910206-3684-1-git-send-email-will.deacon@arm.com>
 <20120802130411.GU6802@n2100.arm.linux.org.uk>
 <20120802150123.GE9838@mudshark.cambridge.arm.com>
 <20120802153030.GV6802@n2100.arm.linux.org.uk>
 <20120802155140.GF9838@mudshark.cambridge.arm.com>
 <20120802181810.GW6802@n2100.arm.linux.org.uk>
 <20120802185033.GA2725@mudshark.cambridge.arm.com>
Message-ID: <20120802194453.GX6802@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 02, 2012 at 07:50:33PM +0100, Will Deacon wrote:
> With recent tools, it looks like that's really hard to do... simply passing
> the lowest common denominator of march=armv4 will cause the assembler to
> barf on all the non-v4 code, which includes Thumb ("Error: selected processor
> does not support THUMB opcodes"). It sounds like we want to pass the march
> option corresponding to the highest architecture version supported by the
> kernel being compiled (assuming we don't use anything that gets deprecated
> by a later version of the architecture(!)).

This is where having an option of "create opcodes exactly from the
assembly I specify in this file, I know what I'm doing, and I don't
care that some instructions aren't present on various CPUs" becomes a
requirement than a desire.

> > The alternative is we scatter various places with lots of yucky ifdefs,
> > and it won't be pretty because quite a number of CPUs share the same code
> > (which leads to long #if defined(CPU_A) || defined(CPU_B) etc).
> 
> That'll work, but let's keep it as a last resort. This is still a toolchain
> issue we're dealing with here.

Another possibility is to use .word for the instructions as refuses to
use for us, which is also yuck.

The more the binutils folk decide that they should be gods and rule what
code we can write, the more work-arounds we will have to find.  Maybe
that even gets to the point of having to write our own assembler...  It
wouldn't be the first time that something like that has been done because
a mainstream project imposed too many silly conditions on their users.
