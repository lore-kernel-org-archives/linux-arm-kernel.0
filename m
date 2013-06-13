From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Jun 2013 18:37:23 +0100
Subject: [PATCH] ARM: convert max_pfn and max_low_pfn to be relative to
 PFN0
In-Reply-To: <1371089603-22601-1-git-send-email-ccross@android.com>
References: <1371089603-22601-1-git-send-email-ccross@android.com>
Message-ID: <20130613173723.GK18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 07:13:23PM -0700, Colin Cross wrote:
> >From code inspection, I believe this will also improve block device
> performance where the bounce limit was set to BLK_BOUNCE_HIGH, which
> was bouncing unnecessarily for the top PHYS_PFN_OFFSET pages of low
> memory.

This has the potential to break platforms.  The problem is the duality
of the dma_mask - is it a mask of the bits which the device can drive,
or a PFN limit.  The block layer interprets it as a PFN limit, because
of course everywhere starts their memory at physical address zero.

This gets into a world of pain if you have any of these conditions:
(a) RAM not starting at physical address zero
(b) Any translation between physical addresses and bus addresses

What we know is that the existing stuff works.  What we don't know is
whether changing it will break anything which falls into the above
two categories.
