From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Dec 2015 15:28:42 +0000
Subject: [RFC PATCH 2/4] device property: Introduce helper
 device_get_reference_node()
In-Reply-To: <1449047368-5768-3-git-send-email-wangkefeng.wang@huawei.com>
References: <1449047368-5768-1-git-send-email-wangkefeng.wang@huawei.com>
 <1449047368-5768-3-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <20151203152842.GO8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 05:09:26PM +0800, Kefeng Wang wrote:
> With of_parse_phandle() and acpi_dev_get_reference_device(), we can introduce
> a universal helper device_get_reference_node() to read and parse a device
> property and return a pointer to the resulting firmware node.

What's happening to make this fwnode stuff actually usable?  Whenever
I've looked at it from the DT perspective, it looks very much like a
half-baked train wreck - although the struct device_node contains a
fwnode, of_node_init() initialises it partially, and we have a way to
convert _from_ a fwnode to a device_node (to_of_node), nothing sets
the struct device fwnode pointer.

Whenever I've looked at this, it's always led me to the conclusion
that the way that fwnode stuff has currently been written, I'm
supposed to get the device_node, and then use the embedded fwnode
directly, which I'm pretty sure misses the point of fwnode (as it
means any driver code making use of this is tied to DT.)

This patch seems to confirm my suspicions that it's just wrong -
trying to use device_get_reference_node() here will fail in a DT
based setup, because (I assume) dev_fwnode(dev) returns dev->fwnode
which is NULL there.

I don't know, maybe there is an intention that fwnode should not be
used for DT?

Maybe someone who knows what the intentions are behind this fwnode stuff
can enlighten the situation, and maybe sort out this apparent oversight
which IMHO should've been spotted in the initial fwnode review?

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
