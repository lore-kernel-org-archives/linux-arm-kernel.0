From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Aug 2010 08:41:37 +0100
Subject: [PATCH 3/4] [ARM] mm: add memory type for inner-writeback
In-Reply-To: <1280803369-13362-4-git-send-email-gking@nvidia.com>
References: <1280803369-13362-1-git-send-email-gking@nvidia.com>
	<1280803369-13362-4-git-send-email-gking@nvidia.com>
Message-ID: <20100803074137.GC11987@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 02, 2010 at 07:42:48PM -0700, Gary King wrote:
> This change uses the currently-unused mapping 5 (TEX[0]=1, C=0, B=1)
> in the tex remapping tables as an inner-writeback-write-allocate, outer
> non-cacheable memory type, so that this mapping will be available to
> clients which will benefit from the reduced L2 maintenance.

No.  This is not "free for use".  Mapping 5 is unused because it's not
architecturally defined - CPU implementations may not implement it.
This is what the ARM ARM says:

  For seven of the eight possible combinations of the TEX[0], C and B bits,
  a field in the PRRR defines the corresponding memory region as being
  Normal, Device or Strongly-ordered memory a field in the NMRR defines
  the Inner cache attributes that apply if the PRRR field identifies the
  region as Normal memory a second field in the NMRR defines the Outer
  cache attributes that apply if the PRRR field identifies the region as
  Normal memory.

  The meaning of the eighth combination for the TEX[0], C and B bits is
  IMPLEMENTATION DEFINED

So we can't be sure that the PRRR and NMRR bits which correspond with
mapping 5 even exist.
