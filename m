From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 4 Nov 2014 11:35:43 +0000
Subject: [PATCH 05/10] arm64: Convert dts to use reserved-memory nodes
In-Reply-To: <CAL_Jsq+V_tLkfwBKDQOOrkKtHWaRD5e1AHzbciwVYFYbpsAE=w@mail.gmail.com>
References: <cover.1414099246.git.geoff@infradead.org>
 <411296ab915959b862923d827e730a1db2ff9b4e.1414099246.git.geoff@infradead.org>
 <20141024105111.GD24265@leverpostej>
 <CACxGe6szzOXHkK9ukpcSBZgeyy5AgX3+7PgQseBnB9XWYLj-PQ@mail.gmail.com>
 <20141024122738.GH24265@leverpostej>
 <1414799092.23621.48.camel@smoke>
 <CAL_Jsq+V_tLkfwBKDQOOrkKtHWaRD5e1AHzbciwVYFYbpsAE=w@mail.gmail.com>
Message-ID: <20141104113542.GC31371@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 03, 2014 at 10:26:02PM +0000, Rob Herring wrote:
> Adding Leif...

[...]

> I'm just wondering does UEFI being used for the memory information
> have any impact here as the DT would not have valid memory nodes
> either?

For UEFI, things should just work (TM). The dtb will be free of memory
nodes (and memreserves), and the next kernel will discover the UEFI
memory map via the linux,uefi-mmap-* properties as the first kernel did.

We shouldn't need to pass any additional data in this case.

> I'd assume reserved memory comes from UEFI (or both) in that
> case?

Yes. Any memory that should be reserved should be described as such in
the UEFI memory map.

One caveat is that reserved-memory nodes are preserved (because they can
be referred to by phandle for CMA and such). There are few potential
problems with this (we'll have to reconcile it with the UEFI memory map,
prevent overlap when the kernel is relocated, etc). The reserved-memory
nodes should only be used for CMA type carve outs rather than for
protecting firmware and similar.

> Perhaps we need to expose memory layout independent of DT, UEFI
> or anything else.

I can see that being useful for debugging, but I don't think that we
require it.

Thanks,
Mark.
