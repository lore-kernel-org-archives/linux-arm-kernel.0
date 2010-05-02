From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 2 May 2010 10:55:34 +0100
Subject: Versatile QEMU broken in -next
In-Reply-To: <r2r63386a3d1005011801v5ad139b9y5852700f0575544d@mail.gmail.com>
References: <r2r63386a3d1005011801v5ad139b9y5852700f0575544d@mail.gmail.com>
Message-ID: <20100502095534.GB7061@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 02, 2010 at 03:01:48AM +0200, Linus Walleij wrote:
> After some hours trying to boot the -next tree on
> Versatile PB in QEMU, I git-bisected until I found
> that one of these commits breaks Versatile for QEMU
> (it just hangs, following quoting git bisect):
> 
>...
> f2b431ef83dc81bb633359b11d97639f04ebb212
> We cannot bisect more!

The above is the commit range from 2e655a0 to f2b431e.  Moving 2e655a0
after f2b431e results in the intermediate commits building - the
new commit range (when it eventually gets through linux-next) will be
da7ba95 .. e606a94.

The commit which breaks qemu is e388771 (or in the tree you have, 8863e0e)
and is very subtle.  We used to write the reload register with the control
register set to zero, only because the clock event code calls us with
CLOCK_EVT_MODE_SHUTDOWN immediately before CLOCK_EVT_MODE_PERIODIC.

After the commit, we always set the control register to have IE (interrupt
enable) and 32-bit modes set and everything else disabled, before writing
the reload register.  This is more correct; it is undefined whether
32/16-bit mode affects the size of the value loaded into the counter
register when the load register is written (or subsequent reloads.)

This works on real hardware.  It seems QEMU doesn't like having the load
register written the IE and 32-bit enabled and decides to never generate
an interrupt (this is impossible for real hardware to achieve with periodic
mode selected).

Therefore, QEMU's SP804 timer implementation is buggy.
