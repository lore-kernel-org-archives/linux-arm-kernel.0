From: will.deacon@arm.com (Will Deacon)
Date: Mon, 29 Sep 2014 11:16:27 +0100
Subject: [PATCH] arm64: ptrace: hw_break_set take into account hardware
 breakpoints number
In-Reply-To: <1411977842-16515-2-git-send-email-victor.kamensky@linaro.org>
References: <1411977842-16515-1-git-send-email-victor.kamensky@linaro.org>
 <1411977842-16515-2-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20140929101626.GE20303@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Victor,

On Mon, Sep 29, 2014 at 09:04:02AM +0100, Victor Kamensky wrote:
> hw_break_set function that performs ptrace_regset for hardware
> breakpoints and watchpoints needs to take into account actual
> number of hardware breakpoints and watchpoints available in CPU.
> 
> Current code iterates over all 16 entries of 'struct user_hwdebug_state'
> and tries to reserve hardware breakpoint for each index, which fails
> if CPU supports less than 16 hardware breakpoints. One manifestation of
> the issue is that gdb fails to debug multithreaded user land application
> and exits with 'Unexpected error setting hardware debug registers'
> error - ptrace system call for hardware breakpoints regset fails with
> ENOSPC.

When does this happen? hw_break_set is driven by userspace, so if GDB is
asking for more registers than we actually have, then this is a GDB bug and
the kernel is doing the right thing.

Have you reproduced this with the latest version of GDB?

Will
