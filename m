From: albeu@free.fr (Alban)
Date: Tue, 21 Aug 2018 00:53:27 +0200
Subject: [PATCH v2 06/29] mtd: Add support for reading MTD devices via
 the nvmem API
In-Reply-To: <20180819184609.6dcdbb9a@bbrezillon>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-7-brgl@bgdev.pl>
 <20180817182720.6a6e5e8e@bbrezillon> <20180819133106.0420df5f@tock>
 <20180819184609.6dcdbb9a@bbrezillon>
Message-ID: <20180821005327.0d312a85@tock>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 19 Aug 2018 18:46:09 +0200
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> On Sun, 19 Aug 2018 13:31:06 +0200
> Alban <albeu@free.fr> wrote:
> 
> > On Fri, 17 Aug 2018 18:27:20 +0200
> > Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> >   
> > > Hi Bartosz,
> > > 
> > > On Fri, 10 Aug 2018 10:05:03 +0200
> > > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > >     
> > > > From: Alban Bedel <albeu@free.fr>
> > > > 
> > > > Allow drivers that use the nvmem API to read data stored on MTD devices.
> > > > For this the mtd devices are registered as read-only NVMEM providers.
> > > > 
> > > > Signed-off-by: Alban Bedel <albeu@free.fr>
> > > > [Bartosz:
> > > >   - use the managed variant of nvmem_register(),
> > > >   - set the nvmem name]
> > > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>      
> > > 
> > > What happened to the 2 other patches of Alban's series? I'd really
> > > like the DT case to be handled/agreed on in the same patchset, but
> > > IIRC, Alban and Srinivas disagreed on how this should be represented.
> > > I hope this time we'll come to an agreement, because the MTD <-> NVMEM
> > > glue has been floating around for quite some time...    
> > 
> > These other patches were to fix what I consider a fundamental flaw in
> > the generic NVMEM bindings, however we couldn't agree on this point.
> > Bartosz later contacted me to take over this series and I suggested to
> > just change the MTD NVMEM binding to use a compatible string on the
> > NVMEM cells as an alternative solution to fix the clash with the old
> > style MTD partition.
> > 
> > However all this has no impact on the code needed to add NVMEM support
> > to MTD, so the above patch didn't change at all.  
> 
> It does have an impact on the supported binding though.
> nvmem->dev.of_node is automatically assigned to mtd->dev.of_node, which
> means people will be able to define their NVMEM cells directly under
> the MTD device and reference them from other nodes (even if it's not
> documented), and as you said, it conflict with the old MTD partition
> bindings. So we'd better agree on this binding before merging this
> patch.

Unless the nvmem cell node has a compatible string, then it won't be
considered as a partition by the MTD code. That is were the clash is,
both bindings allow free named child nodes without a compatible string.

> I see several options:
> 
> 1/ provide a way to tell the NVMEM framework not to use parent->of_node
>    even if it's != NULL. This way we really don't support defining
>    NVMEM cells in the DT, and also don't support referencing the nvmem
>    device using a phandle.

I really don't get what the point of this would be. Make the whole API
useless?

> 2/ define a new binding where all nvmem-cells are placed in an
>    "nvmem" subnode (just like we have this "partitions" subnode for
>    partitions), and then add a config->of_node field so that the
>    nvmem provider can explicitly specify the DT node representing the
>    nvmem device. We'll also need to set this field to ERR_PTR(-ENOENT)
>    in case this node does not exist so that the nvmem framework knows
>    that it should not assign nvmem->dev.of_node to parent->of_node

This is not good. First the NVMEM device is only a virtual concept of
the Linux kernel, it has no place in the DT. Secondly the NVMEM
provider (here the MTD device) then has to manually parse its DT node to
find this subnode, pass it to the NVMEM framework to later again
resolve it back to the MTD device. Not very complex but still a lot of
useless code, just registering the MTD device is a lot simpler and much
more inline with most other kernel API that register a "service"
available from a device.

> 3/ only declare partitions as nvmem providers. This would solve the
>    problem we have with partitions defined in the DT since
>    defining sub-partitions in the DT is not (yet?) supported and
>    partition nodes are supposed to be leaf nodes. Still, I'm not a big
>    fan of this solution because it will prevent us from supporting
>    sub-partitions if we ever want/need to.

That sound like a poor workaround. Remember that this problem could
appear with any device that has a binding that use child nodes.

> 4/ Add a ->of_xlate() hook that would be called if present by the
>    framework instead of using the default parsing we have right now.

That is a bit cleaner, but I don't think it would be worse the
complexity. Furthermore xlate functions are more about converting
from hardware parameters to internal kernel representation than to hide
extra DT parsing.

> 5/ Tell the nvmem framework the name of the subnode containing nvmem
>    cell definitions (if NULL that means cells are directly defined
>    under the nvmem provider node). We would set it to "nvmem-cells" (or
>    whatever you like) for the MTD case.

If so please match on compatible and not on the node name.

6/ Extend the current NVMEM cell lookup to check if the parent node of
the cell has a compatible string set to "nvmem-cells". If it doesn't it
mean we have the current binding and this node is the NVMEM device. If
it does the device node is just the next parent. This is trivial to
implement (literally 2 lines of code) and cover all the cases currently
known.

7/ Just add a compatible string to the nvmem cell. No code change is
needed, however as the nvmem cells have an address space (the offset in
byte in the storage) it might still clash with another address space
used by the main device biding (for example a number of child
functions).

> There are probably other options (some were proposed by Alban and
> Srinivas already), but I'd like to get this sorted out before we merge
> this patch.
> 
> Alban, Srinivas, any opinion?

My preference goes to 6/ as it is trivial to implement, solves all
known shortcomings and is backward compatible with the current binding.
All other solutions have limitations and/or require too complex
implementations compared to what they try to solve.

Alban
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180821/fd409387/attachment-0001.sig>
