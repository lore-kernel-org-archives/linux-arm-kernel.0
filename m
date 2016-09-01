From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 1 Sep 2016 17:45:49 +0100
Subject: [PATCH 2/2] arm64: regard FDT_SW_MAGIC as good fdt magic
In-Reply-To: <57C8516E.7000105@zoho.com>
References: <a6a8826c-3006-ae43-ef4c-8049ef93cd9f@zoho.com>
 <20160901112113.GA4220@leverpostej> <57C8516E.7000105@zoho.com>
Message-ID: <20160901164549.GA7136@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 02, 2016 at 12:03:58AM +0800, zijun_hu wrote:
> On 09/01/2016 07:21 PM, Mark Rutland wrote:
> > On Thu, Sep 01, 2016 at 06:58:29PM +0800, zijun_hu wrote:
> >> From: zijun_hu <zijun_hu@htc.com>
> >>
> >> regard FDT_SW_MAGIC as good fdt magic during mapping fdt area
> >> see fdt_check_header() for details
> > 
> > It looks like we should only see FDT_SW_MAGIC for a FDT that was in the
> > process of being created, but was not finished. So I'm somewhat confused
> > as to why fdt_check_header() would allow this.
> > 
> > Neither ePAPR nor the new devicetree spec define FDT_SW_MAGIC. They both
> > only define 0xd00dfeed as a valid magic value. In libfdt, FDT_SW_MAGIC
> > is an internal constant, and it looks like fdt_check_header() simply
> > accepts this for convenience within libfdt.

> > Why do you think this is necessary? Have you seen a problem in practice?

> i don't understand function modules involved with FDT_SW_MAGIC very well
> i just think it isn't a bad thing to keep consistent with fdt_check_header()

I agree that the inconsistency is not great.

However, I think that we do not want the kernel to accept FDT_SW_MAGIC
in any case, given this implies a DTB mid-creation.

Which is to say that either fdt_check_header() is doing the wrong thing,
or that we're using it in places where it's inappropriate.

> BTW
> it seems FDT_SW_MAGIC is involved in fdt_create_empty_tree()@fdt_sw.c which
> operate fdt in runtime
> in kernel, this function is used in drivers/firmware/efi/libstub/fdt.c
> in u-boot, in arch/sandbox/cpu/cpu.c an arch/sandbox/cpu/state.c
> the sources mentioned above maybe help you for further decision

Note that fdt_create_empty_tree() calls fdt_finish(), which fixes some
details up, then sets the magic to the real FDT_MAGIC.

So that should be fine.

Thanks,
Mark.
