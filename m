From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Jul 2017 10:31:44 +0100
Subject: [PATCH 0/4] Improve syscall entry code
Message-ID: <20170720093144.GV31807@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The system call entry code has become less optimal as various kernel
features such as context tracking and irq tracing have been added.

For example, we stack the registers on SWI entry, but inside the
enable_irq macro, we re-stack r0-r3, call the trace function, and
unstack them.  This stacking and unstacking is unnecessary as we
can merely reload them from the original entry stacking.  Similar
happens within the ct_user_exit macro.  So, with both features
enabled, we end up stacking and unstacking r0-r3 twice, which is
completely unnecessary.

We also need the 'lr' value for when we need to read the SWI
instruction, but this will be clobbered by the function calls for
these features.  Rather than stacking or re-reading that register,
move it to another register if necessary.

We achieve this by:

1. use register aliases for the saved psr and pc values.
2. move the get_thread_info later to free up a spare register (r9).
3. use this spare register 'r9' to store the saved pc value if we
   have any of these features enabled, otherwise just use 'lr'.
4. switch to using the non-stacking variants of the trace and
   context tracking macros, and reload r0-r3 where necessary.

 arch/arm/kernel/entry-common.S | 44 +++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
