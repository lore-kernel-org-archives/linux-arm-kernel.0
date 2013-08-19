From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 19 Aug 2013 16:47:17 +0200
Subject: [PATCH v5 2/3] drivers: of: add initialization code for dma
 reserved memory
In-Reply-To: <CAL_JsqJR_mdCiA8knd3COuZ=DcpuAtdzsCy8tAPMSMq67m=SAw@mail.gmail.com>
References: <1376049119-12655-1-git-send-email-m.szyprowski@samsung.com>
 <1376049119-12655-3-git-send-email-m.szyprowski@samsung.com>
 <CAL_JsqJLv-dUb=64vP+OeP8=Usw7=r6RKqJAXCSPryCFGZ89_w@mail.gmail.com>
 <52089E23.1090406@samsung.com>
 <CAL_JsqJR_mdCiA8knd3COuZ=DcpuAtdzsCy8tAPMSMq67m=SAw@mail.gmail.com>
Message-ID: <52122FF5.7000802@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 8/13/2013 3:00 PM, Rob Herring wrote:
> On Mon, Aug 12, 2013 at 3:34 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> > Hello,
> >
> >
> > On 8/10/2013 7:33 PM, Rob Herring wrote:
> >>
> >> On Fri, Aug 9, 2013 at 6:51 AM, Marek Szyprowski
> >> <m.szyprowski@samsung.com> wrote:
> >> > Add device tree support for contiguous and reserved memory regions
> >> > defined in device tree. Initialization is done in 2 steps. First, the
> >> > memory is reserved, what happens very early when only flattened device
> >>
> >> s/what/which/
> >>
> >> > tree is available. Then on device initialization the corresponding cma
> >> > and reserved regions are assigned to each device structure.
> >>
> >> What this commit message does not tell me is why does the reservation
> >> have to happen before the fdt is unflattened? It would greatly
> >> simplify the code if it didn't.
> >
> >
> > Large memory blocks can be RELIABLY reserved only during early boot. This
> > must happen before the whole memory management subsystem is initialized,
> > because we need to ensure that the given contiguous blocks are not yet
> > allocated by kernel. Also it must happen before kernel mappings for the
> > whole low memory are created, to ensure that there will be no mappings
> > (for reserved blocks) or mapping with special properties can be created
> > (for CMA blocks). This all happens before device tree structures are
> > unflattened, so we need to get reserved memory layout directly from fdt.
> >
>
> Okay. Just making sure.
>
>
> >> > +       } else if (depth == 2 && my_depth == 1 &&
> >> > +           strcmp(uname, "reserved-memory") == 0) {
> >> > +               prop = of_get_flat_dt_prop(node, "#size-cells", NULL);
> >> > +               if (prop)
> >> > +                       size_cells = be32_to_cpup(prop);
> >> > +
> >> > +               prop = of_get_flat_dt_prop(node, "#address-cells",
> >> > NULL);
> >> > +               if (prop)
> >> > +                       addr_cells = be32_to_cpup(prop);
> >>
> >> I think we should just require these be the same size as the memory
> >> node which would be dt_root_*_cells.
> >>
> >> I'm fine with moving this into drivers/of/fdt.c if that simplifies things.
> >
> >
> > dt_root_*_cells are global variables, so its not a problem to get access to
> > them. However I wonder how can we ensure that user/device tree creator will
> > set #size-cells/#address-cells to the same values as for root memory node?
> > Would it be enough to state that in binding documentation? If so then the
> > reserved memory code can skip parsing them and use dt_root_*_cells directly,
> > what will simplify the code.
>
> Yes, just add a note to the binding that the cell sizes are the same
> as the memory node.
>
> >> > +
> >> > +               my_depth = depth;
> >> > +               /* scan next node */
> >> > +               return 0;
> >> > +       } else if (depth != 3 && my_depth != 2) {
> >> > +               /* scan next node */
> >> > +               return 0;
> >> > +       } else if (depth < my_depth) {
> >> > +               /* break scan now */
> >> > +               return 1;
> >> > +       }
> >>
> >> This code bothers me and is hard to follow. I don't think trying to
> >> use of_scan_flat_dt is the right approach here. What you really want
> >> here is check for reserved-memory node under the memory node and then
> >> scan each child node. This could all be done from
> >> early_init_dt_scan_memory.
> >
> >
> > early_init_dt_scan_memory() is also called from of_scan_flat_dt() and
> > it also implements similar state machine to parse fdt. The only
> > difference is the fact that "memory" is a direct child of root node,
> > so the state machine is much simpler (there is no need to parse
> > /memory/reserved-memory path).
> >
>
> If you have already found the memory node, then why find it again? I
> don't think the existing scan functions handle anything but top-level
> nodes very well. So doing something like this from
> early_init_dt_scan_memory() is what I was thinking. It is a very rough
> sketch:
>
> // find the reserved-memory node
> for (ndepth = 0, off = fdt_next_node(blob, parent_offset, &ndepth);
>      (off >= 0) && (ndepth > 0);
>      off = fdt_next_node(blob, off, &ndepth)) {
>      if (ndepth == 1) {
>          name = fdt_get_name(blob, off, 0), off);
>          if (strcmp(name, "reserved-memory") == 0) {
>               parent_offset = off;
>               break; // found
>      }
> }
>
> // find the child nodes
> for (ndepth = 0, off = fdt_next_node(blob, parent_offset, &ndepth);
>      (off >= 0) && (ndepth == 1);
>      off = fdt_next_node(blob, off, &ndepth)) {
>      // now handle each child
> }
>
> These could probably be further refined with some loop iterator macros.

The above code looks pretty nice, but there are some problems with it:

1. Although it would look nice to call it from early_init_dt_scan_memory()
it won't be possible, because that time it is too early. memblock structures
are initialized after a call to early_init_dt_scan_memory() and until that
no changes to memory layout are easily possible.

2. Currently there are no fdt parsing functions in the kernel. I've tried
to split of_scan_flat_dt() into fdt_next_node() + fdt_get_name() and use
them both in of_scan_flat_dt() and above reserved memory parsing functions.
In the end I got quite a lot of code, which is still quite hard to follow.

Because of the above I decided to resurrect of_scan_flat_dt_by_path()
function from the previous version and use #size-cells/#address-cells
attributes from root node what in the end simplified reserved memory
parsing function. I hope that it can be accepted after such changes
without introducing a burden caused by the whole infrastructure for
manual parsing fdt.

> >> > +       name = kbasename(node->full_name);
> >> > +       for (i = 0; i < reserved_mem_count; i++)
> >> > +               if (strcmp(name, reserved_mem[i].name) == 0)
> >> > +                       return &reserved_mem[i];
> >> > +       return NULL;
> >>
> >> Matching against a struct device_node pointer would be more common way
> >> to match. So it would be good to update reserved_mem with a
> >> device_node ptr when we unflatten the DT.
> >
> >
> > I wonder if it really makes sense. To get device_node ptr I will need to
> > scan /memody/reserved-memory node and match all its children BY NAME
> > with the structures parsed from FDT (stored in reserved_mem array). Then
> > I will need to iterate again for each device node with memory-region
> > property to find the needed entry. Names are unique, IMHO they can serve
> > as a key for matching structures between FDT and regular, unflattened DT.
>
> You are iterating multiple times using a string match versus iterating
> once more and then doing a pointer match. However, it is not really
> performance critical and is fine for now.

Thanks!

Best regards
-- 
Marek Szyprowski
Samsung R&D Institute Poland
