From: will.deacon@arm.com (Will Deacon)
Date: Wed, 8 Aug 2012 14:57:24 +0100
Subject: [PATCH 00/22] Introducing the TI Keystone platform
In-Reply-To: <1343775898-28345-1-git-send-email-cyril@ti.com>
References: <1343775898-28345-1-git-send-email-cyril@ti.com>
Message-ID: <20120808135724.GC4579@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cyril,

On Wed, Aug 01, 2012 at 12:04:36AM +0100, Cyril Chemparathy wrote:
> This series is a follow on to the RFC series posted earlier (archived at [1]).
> The major change introduced here is the modification to the kernel patching
> mechanism for phys_to_virt/virt_to_phys, in order to support LPAE platforms
> that require late patching.  In addition to these changes, we've updated the
> series based on feedback from the earlier posting.

One thing I've noticed going through this code and also looking at the rest
of the LPAE code in mainline is that it's not at all clear what is the maximum
physical address we can support for memory.

We currently have the following restrictions:

ARM architecture: 40 bits
ARCH_PGD_SHIFT	: 38 bits
swapfile	: 36 bits (I posted some patches for this. We could
                           extend to 37 bits if we complicate the code)
SPARSEMEM	: 36 bits (due to limited number of page-flags)

It would be nice if we could define a 36-bit memory limit across the kernel
for LPAE whilst allowing higher addresses to be used for peripherals. This
also matches x86 PAE, so the common code will also work correctly.

Otherwise I worry that we will see platforms with memory right at the top of
the physical map and these will be incredibly painful to support.

Will
