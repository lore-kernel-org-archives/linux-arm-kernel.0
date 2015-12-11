From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 11 Dec 2015 12:35:06 +0000
Subject: [RFC PATCH 2/4] device property: Introduce helper
 device_get_reference_node()
In-Reply-To: <20151203152842.GO8644@n2100.arm.linux.org.uk>
References: <1449047368-5768-1-git-send-email-wangkefeng.wang@huawei.com>
 <1449047368-5768-3-git-send-email-wangkefeng.wang@huawei.com>
 <20151203152842.GO8644@n2100.arm.linux.org.uk>
Message-ID: <20151211123506.GA30463@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thu, Dec 03, 2015 at 03:28:42PM +0000, Russell King - ARM Linux wrote:
> On Wed, Dec 02, 2015 at 05:09:26PM +0800, Kefeng Wang wrote:
> > With of_parse_phandle() and acpi_dev_get_reference_device(), we can introduce
> > a universal helper device_get_reference_node() to read and parse a device
> > property and return a pointer to the resulting firmware node.
> 
> What's happening to make this fwnode stuff actually usable?  Whenever
> I've looked at it from the DT perspective, it looks very much like a
> half-baked train wreck - although the struct device_node contains a
> fwnode, of_node_init() initialises it partially, and we have a way to
> convert _from_ a fwnode to a device_node (to_of_node), nothing sets
> the struct device fwnode pointer.

I might have missed why that pointer is left to NULL in DT, it is
not that complicated to set it up and may actually simplify things
in the process.

Rafael certainly knows better than I do, it could have been done in
commit:

9017f25254e4 ("driver core: Implement device property accessors through
fwnode ones")

except that as you noticed the dev_fwnode has to be special cased since
the OF core does not set the fwnode pointer (there must be a reason
why, if there is not a patch to implement that is simple).

On DT the fwnode_handle is allocated in the struct device_node that
contains it but I still do not see why the fwnode pointer in struct
device can't be made to point at it.

> Whenever I've looked at this, it's always led me to the conclusion
> that the way that fwnode stuff has currently been written, I'm
> supposed to get the device_node, and then use the embedded fwnode
> directly, which I'm pretty sure misses the point of fwnode (as it
> means any driver code making use of this is tied to DT.)
> 
> This patch seems to confirm my suspicions that it's just wrong -
> trying to use device_get_reference_node() here will fail in a DT
> based setup, because (I assume) dev_fwnode(dev) returns dev->fwnode
> which is NULL there.

No, dev_fwnode is special cased for OF (have a look at it in
/drivers/base/property.c), I share your question on why it has to
be so, actually this would make dev_fwnode() even simpler.

> I don't know, maybe there is an intention that fwnode should not be
> used for DT?

That's the question we need to get answered :), it might well be that
we can simply update the OF populate code to initialize the pointer
in the struct device.

Thanks,
Lorenzo
