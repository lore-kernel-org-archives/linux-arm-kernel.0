From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jul 2011 21:36:34 +0100
Subject: [PATCH 01/52] ARM: introduce atag_offset to replace boot_params
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20110708203634.GU4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 10:46:46PM -0400, Nicolas Pitre wrote:
> The boot_params member of the mdesc structure is used to provide a
> default physical address for the ATAG list.  Since this value is fixed
> at compile time and often based on ARCH_PHYS_OFFSET, it gets in the way
> of runtime PHYS_OFFSET usage.
> 
> Let's introduce atag_offset which should contains only the relative
> offset from start of memory instead of an absolute value, in preparation
> to move all instance of boot_params over to it.

I don't like this.

While I understand the issue (the oops when we try to dereference the
absolute address), the fact is that's how it is.

Take a moment to think about this.  The ATAG list is normally setup at a
fixed physical address by the boot loader.  While there are some boot
loaders which allow you to load the kernel at different physical addresses,
they still place the ATAG list at that same physical address.

That means if you change this into an offset from the kernels idea of
PHYS_OFFSET, it's not going to find the ATAGs.

So we're probably better off checking whether the platform provided ATAG
pointer is below our idea of PHYS_OFFSET, and if it is to ignore that.
The ultimate effect will be the same - the kernel won't find the ATAGs
and won't crash instead.  And no need for all this churn either.
