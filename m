From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Feb 2012 22:36:53 +0000
Subject: [PATCH 13/15] ARM: make mach/io.h include optional
In-Reply-To: <1329169408-17253-14-git-send-email-robherring2@gmail.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <1329169408-17253-14-git-send-email-robherring2@gmail.com>
Message-ID: <20120213223653.GF25655@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 03:43:26PM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Add a kconfig option NEED_MACH_IO_H to conditionally include mach/io.h.
> 
> Basing this on CONFIG_PCI and CONFIG_ISA doesn't quite work. Most ISA
> platforms don't need mach/io.h, but ebsa110 does.

This is architecturally wrong.  If you have ISA, and your __io() macro
is essentially a 1:1 translation, you're asking for ISA drivers to
scribble on whatever is at virtual address 0-64K.  Too bad if that
happens to be where your CPU vectors are stored, you'll lose control
of the CPU in that case.

In other words, if you have PCI or ISA and your __io() macro is a 1:1
translation, you _need_ an io.h to define a proper offset for this.

So, I think this patch series moves things in the wrong direction.
