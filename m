From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Nov 2017 17:23:16 +0000
Subject: [PATCH v16 10/13] arch/arm: enable task isolation functionality
In-Reply-To: <1509728692-10460-11-git-send-email-cmetcalf@mellanox.com>
References: <1509728692-10460-1-git-send-email-cmetcalf@mellanox.com>
 <1509728692-10460-11-git-send-email-cmetcalf@mellanox.com>
Message-ID: <20171103172316.GP9463@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 01:04:49PM -0400, Chris Metcalf wrote:
> From: Francis Giraldeau <francis.giraldeau@gmail.com>
> 
> This patch is a port of the task isolation functionality to the arm 32-bit
> architecture. The task isolation needs an additional thread flag that
> requires to change the entry assembly code to accept a bitfield larger than
> one byte.  The constants _TIF_SYSCALL_WORK and _TIF_WORK_MASK are now
> defined in the literal pool. The rest of the patch is straightforward and
> reflects what is done on other architectures.
> 
> To avoid problems with the tst instruction in the v7m build, we renumber
> TIF_SECCOMP to bit 8 and let TIF_TASK_ISOLATION use bit 7.

After a bit of digging (which could've been saved if our patch format
contained information about what kernel version this patch was
generated against) it turns out that this patch will not apply since
commit 73ac5d6a2b6ac ("arm/syscalls: Check address limit on user-mode
return") has been applied, which means the TIF numbers have changed
as well as the assembly code that your patch touches.

My guess is that this patch was generated from a 4.13 kernel, so
misses the 4.14-rc1 changes.  Since we're potentially about to start
the merge window for 4.15 this weekend, the timing of this doesn't
work well either.

Once 4.15-rc1 has been published, please rebase against that version
and resend.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
