From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Nov 2009 12:20:45 +0000
Subject: ARM926 Software reset problems
In-Reply-To: <B3925569A02247AFA3847BB80F9342EF@teltronic.es>
References: <B3925569A02247AFA3847BB80F9342EF@teltronic.es>
Message-ID: <20091113122045.GA29008@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 13, 2009 at 12:32:16PM +0100, Ricardo Mart?nez wrote:
> I'm using 
>     cpu_arm926_reset(ulong address) function which:
>            - flushes I/D caches
>             - jumps to "address", whose value in my case is NOR flash base
> address where U-Boot stays (after remapping).

You should not be using this directly.  Software rebooting has a specific
sequence, and the above is the very last step.

>     But it sometimes work, but most times hangs. Can this be caused by MMU
> not being switched off? 

cpu_arm926_reset() turns the MMU and caches off.

> Is there any other prefered method to soft reboot ARM926 from Linux? I've
> taken a look at some PXA, OMAP & AT91 code about soft rebooting. It seems
> they use Watchdog timer to reset, but my CPU does not have a watchdog.

Don't call cpu_arm926_reset() directly.  Use kernel_restart() instead,
or even better the reboot syscall from userspace.
