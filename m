From: miles.chen@mediatek.com (Miles Chen)
Date: Wed, 28 Nov 2018 09:56:04 +0800
Subject: [RFC PATCH] of: make MAX_RESERVED_REGIONS configurable
In-Reply-To: <1543196004.21289.1.camel@mtkswgap22>
References: <1542787873-8429-1-git-send-email-miles.chen@mediatek.com>
 <CAL_JsqLGvUYQmCGXLgSO+6kFj2i87dpaTbMGbyu5oMt=eeu35A@mail.gmail.com>
 <1542855088.15789.6.camel@mtkswgap22>
 <CAL_Jsq+O1YDP1yiHZpcxUaFG1LYDqi74D_kEnErP+cwGDppVWQ@mail.gmail.com>
 <1543196004.21289.1.camel@mtkswgap22>
Message-ID: <1543370164.29143.9.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-11-26 at 09:33 +0800, Miles Chen wrote:
> On Sat, 2018-11-24 at 14:56 -0600, Rob Herring wrote:
> > On Wed, Nov 21, 2018 at 8:51 PM Miles Chen <miles.chen@mediatek.com> wrote:
> > >
> > > On Wed, 2018-11-21 at 10:39 -0600, Rob Herring wrote:
> > > > On Wed, Nov 21, 2018 at 2:11 AM <miles.chen@mediatek.com> wrote:
> > > > >
> > > > > From: Miles Chen <miles.chen@mediatek.com>
> > > > >
> > > > > When we use more than 32 entries in /resered-memory,
> > > > > there will be an error message: "not enough space all defined regions.".
> > > > > We can increase MAX_RESERVED_REGIONS to fix this.
> > > > >
> > > > > commit 22f8cc6e3373 ("drivers: of: increase MAX_RESERVED_REGIONS to 32")
> > > > > increased MAX_RESERVED_REGIONS to 32 but I'm not sure if increasing
> > > > > MAX_RESERVED_REGIONS to 64 is suitable for everyone.
> > > > >
> > > > > In this RFC patch, CONFIG_MAX_OF_RESERVED_REGIONS is added and used as
> > > > > MAX_RESERVED_REGIONS. Add a sanity test to make sure that
> > > > > MAX_RESERVED_REGIONS is less than INIT_MEMBLOCK_REGIONS.
> > > > > Users can configure CONFIG_MAX_OF_RESERVED_REGIONS according to their
> > > > > need.
> > > >
> > > > I don't want a kconfig option for this. I think it should be dynamic instead.
> > > >
> > > > The current flow is like this:
> > > >
> > > > for each reserved node:
> > > >   - call memblock_reserve
> > > >   - Add info to reserved_mem array
> > > >
> > > > I think we should change it to:
> > > >
> > > > for each reserved node:
> > > >   - call memblock_reserve
> > > >   - count number of nodes
> > > >
> > > > Alloc array using memblock_alloc
> > > >
> > > > for each reserved node:
> > > >    - Add info to reserved_mem array
> > > >
> > >
> > > thanks for your comment.
> > >
> > > I reviewed the flow and it might be easier to count the
> > > nodes and setup array first:
> > >
> > > for each reserved node:
> > >     - count number of nodes
> > >
> > > Alloc array using memblock_alloc
> > >
> > >
> > > for each reserved node:
> > >    - call memblock_reserve
> > 
> > The order here is wrong. It is important that you reserve the memory
> > blocks before doing any allocations.
> 
> thanks for pointing that out. You are right. I'll follow your
> suggestion.

I got a problem while implementing this change: the array allocation
is done successfully but the kernel does not create mappings for it yet,
so the array is not accessible. (kernel will create the mapping later in
paging_init())

For example: aarch64 setup_arch()
setup_arch()
{
    memblock_init(); /* early_init_fdt_scan_reserved_mem() is called */
    paging_init();
}

Could you give me some advice, please?

Miles
> 
> > 
> > >    - Add info to reserved_mem array
> > >
> > > What do you think?
> > >
> > > > Rob
> > >
> > >
> 
> 
