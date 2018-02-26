From: davem@davemloft.net (David Miller)
Date: Mon, 26 Feb 2018 13:37:23 -0500 (EST)
Subject: [PATCH] net: Allow mac_pton() to work on non-NULL terminated
 strings
In-Reply-To: <20180223201748.14328-1-stefan@the2masters.de>
References: <20180223182006.GA2116@avx2>
 <20180223201748.14328-1-stefan@the2masters.de>
Message-ID: <20180226.133723.1747355754308807711.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stefan Hellermann <stefan@the2masters.de>
Date: Fri, 23 Feb 2018 21:17:48 +0100

> Commit 4904dbda41c8 ("ARM: orion5x: use mac_pton() helper") crashes my
> QNAP TS-209 NAS early on boot.
> 
> The boot code for the TS-209 is looping through an ext2 filesystem on a
> 384kB mtd partition (factory configuration put there by QNAP). There it
> looks on every 1kB boundary if there is a valid MAC address. The
> filesystem has a 1kB block size, so this seems to work.
> 
> On my device the MAC address is on the 37th 1kB block. But: On the 27th
> block is a large file (1,5kB) without 0 bytes inside. The code in
> qnap_tsx09_find_mac_addr() maps 1kB into memory (not a whole file or the
> whole 384kB) and then calls qnap_tsx09_check_mac_addr() -> mac_pton() ->
> strlen() on this memory block. as there is no 0 byte in the file on the
> 27th block, strlen() runs into bad memory and the machine panics. The old
> code had no strlen().
> 
> Actually mac_pton() doesn't need to call strlen(), the following loop
> catches short strings quite nicely. The strlen() seems to be an
> optimization for calls to mac_pton with empty string. But this is rarely
> the case and this is not a hot path. Remove it to reduce code size and
> speed up calls with an not empty string.
> 
> Besides fixing the crash there is are other users interested in
> this change, see https://patchwork.ozlabs.org/patch/851008/
> 
> Fixes: 4904dbda41c8 ("ARM: orion5x: use mac_pton() helper")
> Signed-off-by: Stefan Hellermann <stefan@the2masters.de>
> Cc: <stable@vger.kernel.org> [4.4+]

Nope, instead the Fixes: tag commit should be completely reverted.

It is wrong on several levels.

If we don't check for NULL termination, only the caller knows if it
is safe to blindly parse the buffer and whether it's length is
legitimate, and in what manner it is ok to do so.

But that's not my main beef.

The major problem is that the orion5x code passes an __iomem pointer
to mac_pton().

It is never correct to use real C pointer dereferencing on an __iomem
pointer.  __iomem pointer accesses must go through the appropriate
iomem accessor functions and interfaces, because __iomem pointers are
opaque and not real C pointers.

sparse should have emitted a ton of warnings for the orion5x code, and
furthermore it should have done so when the __iomem pointer is passed
straight into mac_pton().

It is therefore the orion5x's code business to do such non-portable
operations, and to be able to assume that the mac buffer is safe to be
non-NULL terminated.

Therefore I am reverted the above mentioned commit to fix this
problem.

Thank you.
