From: will.deacon@arm.com (Will Deacon)
Date: Fri, 16 May 2014 14:44:20 +0100
Subject: [PATCH] arm64: ptrace: fix setting hw breakpoint/watchpoint
In-Reply-To: <1399290685-6336-1-git-send-email-catalin.udma@freescale.com>
References: <1399290685-6336-1-git-send-email-catalin.udma@freescale.com>
Message-ID: <20140516134420.GG12341@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 05, 2014 at 12:51:25PM +0100, Catalin Udma wrote:
> When setting hw breakpoints/watchpoints, GDB reports the error
> "Unexpected error setting hardware debug registers". The problem is
> reproducible on A53/A57 models where the supported number of
> breakpoints/watchpoints (6 or 4 read from ID_AA64DFR0_EL1) it is
> less than the maximum number of debug registers from user_hwdebug_state
> 
> This patch fixes the problem by restricting the registers access to the
> maximum number of supported breakpoints/watchpoints

Actually, I consider this to be a bug in GDB. It shouldn't be trying to
access registers that don't exist (we tell it the number of registers
available as part of the 32-bit info register).

I also think this has been fixed in GDB upstream:


  commit f45c82da381e0ce5ce51b7fb24d0d28611d266b8
  Author: Yufeng Zhang <yufeng.zhang@arm.com>
  Date:   Wed Dec 18 16:47:33 2013 +0000

      gdb/

          * aarch64-linux-nat.c (aarch64_linux_set_debug_regs): Set
          iov.iov_len with the real length in use.

      gdb/gdbserver/

          * linux-aarch64-low.c (aarch64_linux_set_debug_regs): Set
          iov.iov_len with the real length in use.


so there's no need to change the kernel for this.

Will
