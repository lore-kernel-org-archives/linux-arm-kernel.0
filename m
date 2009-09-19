From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 19 Sep 2009 09:40:52 +0100
Subject: [PATCH 1/2] OMAP1/2/3/4: DEBUG_LL run time detection
In-Reply-To: <1253320780-19396-2-git-send-email-vikram.pandita@ti.com>
References: <1253320780-19396-1-git-send-email-vikram.pandita@ti.com>
	<1253320780-19396-2-git-send-email-vikram.pandita@ti.com>
Message-ID: <20090919084051.GA20296@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2009 at 07:39:39PM -0500, Vikram Pandita wrote:
> The decision of finding the physical address of debug uart is done
> at runtime now, making possible to use a single defconfig for multiple boards.
> 
> This patch gets rid of  menuconfig options of choosing low level debug uarts.

This approach won't work in all cases where the debug functions are called
(which can be before the MMU is enabled.)

The problem is that you can't run C code before the MMU is setup because
C code always encodes absolute address locations, which won't be valid
at that time.

Also, since there is no stack during the initial kernel boot, you can't
stack registers in the LL debug functions.
