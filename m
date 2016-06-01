From: simon.marchi@ericsson.com (Simon Marchi)
Date: Wed, 1 Jun 2016 08:54:05 -0400
Subject: Possible race between PTRACE_SETVFPREGS and PTRACE_CONT on ARM?
In-Reply-To: <20160530213529.GS19428@n2100.arm.linux.org.uk>
References: <574C7CDB.7050103@ericsson.com>
 <20160530213529.GS19428@n2100.arm.linux.org.uk>
Message-ID: <574EDAED.1050902@ericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16-05-30 05:35 PM, Russell King - ARM Linux wrote:
> So, the gdb verisons I have here seem to be particularly poor - but with
> some modifications, I can test out on iMX6 by forcing gdb to do the right
> thing - by inserting a couple of "mov r0, r0" instructions after the
> "break_here" label.

I see that problem too with older versions, bisecting shows it has been fixed
in commit

  6e22494e5076 Do not skip prologue for asm (.S) files

in gdb, which is included in gdb 7.10 and up.

> With that, on a single CPU, it seems to work correctly every time, but
> if I bring up a secondary CPU I start seeing the same problems you've
> reported - which seems to need the following patch to solve.  Please can
> you check whether this resolves your problem?

Yes that fixes the problem, the test case succeeds every time.  I have stared
at those lines in ptrace.c for some time, but couldn't find the problem.  Thanks
for looking into it!
