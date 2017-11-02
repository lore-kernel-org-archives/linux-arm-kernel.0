From: sakari.ailus@linux.intel.com (Sakari Ailus)
Date: Thu, 2 Nov 2017 11:20:15 +0200
Subject: [PATCH v2 14/26] media: xilinx: fix a debug printk
In-Reply-To: <2117711.dO2rQLXOup@avalon>
References: <c4389ab1c02bb08c1a55012fdb859c8b10bdc47e.1509569763.git.mchehab@s-opensource.com>
 <be86653c5e5641582f65f43780b1fe255e92cdc0.1509569763.git.mchehab@s-opensource.com>
 <2117711.dO2rQLXOup@avalon>
Message-ID: <20171102092015.kppthosrh5qhlpw5@paasikivi.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent and Mauro,

On Thu, Nov 02, 2017 at 04:43:51AM +0200, Laurent Pinchart wrote:
> Hi Mauro,
> 
> (CC'ing Rob and Sakari)
> 
> Thank you for the patch.
> 
> On Wednesday, 1 November 2017 23:05:51 EET Mauro Carvalho Chehab wrote:
> > Two orthogonal changesets caused a breakage at several printk
> > messages inside xilinx. Changeset 859969b38e2e
> > ("[media] v4l: Switch from V4L2 OF not V4L2 fwnode API")
> > made davinci to use struct fwnode_handle instead of
> > struct device_node. Changeset 68d9c47b1679
> > ("media: Convert to using %pOF instead of full_name")
> > changed the printk to not use ->full_name, but, instead,
> > to rely on %pOF.
> > 
> > With both patches applied, the Kernel will do the wrong
> > thing, as warned by smatch:
> > drivers/media/platform/xilinx/xilinx-vipp.c:108 xvip_graph_build_one()
> > error: '%pOF' expects argument of type 'struct device_node*', argument 4
> > has type 'void*'
> > drivers/media/platform/xilinx/xilinx-vipp.c:117 xvip_graph_build_one()
> > error: '%pOF' expects argument of type 'struct device_node*', argument 4 has
> > type 'void*'
> > drivers/media/platform/xilinx/xilinx-vipp.c:126 xvip_graph_build_one()
> > error: '%pOF' expects argument of type 'struct device_node*', argument 4
> > has type 'void*'
> > drivers/media/platform/xilinx/xilinx-vipp.c:138 xvip_graph_build_one()
> > error: '%pOF' expects argument of type 'struct device_node*', argument 3 has
> > type 'void*'
> > drivers/media/platform/xilinx/xilinx-vipp.c:148 xvip_graph_build_one()
> > error: '%pOF' expects argument of type 'struct device_node*', argument 4
> > has type 'void*'
> > drivers/media/platform/xilinx/xilinx-vipp.c:245 xvip_graph_build_dma()
> > error: '%pOF' expects argument of type 'struct device_node*', argument 3 has
> > type 'void*'
> > drivers/media/platform/xilinx/xilinx-vipp.c:254 xvip_graph_build_dma()
> > error: '%pOF' expects argument of type 'struct device_node*', argument 4
> > has type 'void*'
> > 
> > So, change the logic to actually print the device name
> > that was obtained before the print logic.
> 
> This doesn't seem like a good idea to me. The main point of commit 
> 68d9c47b1679 is to avoid accessing full_name directly to prepare for removal 
> of that field.
> 
> to_of_node() is defined as
> 
> #define to_of_node(__fwnode)                                            \
>         ({                                                              \
>                 typeof(__fwnode) __to_of_node_fwnode = (__fwnode);      \
>                                                                         \
>                 is_of_node(__to_of_node_fwnode) ?                       \
>                         container_of(__to_of_node_fwnode,               \
>                                      struct device_node, fwnode) :      \
>                         NULL;                                           \
>         })
> 
> when CONFIG_OF is set, and as
> 
> static inline struct device_node *to_of_node(const struct fwnode_handle 
> *fwnode)
> {
>         return NULL;
> }
> 
> otherwise. I wonder why smatch believes the value is a void *, but in any case 
> that should be fixed either in smatch (if it's a smatch bug) or in the 
> definition of the to_of_node() macro.

Probably because NULL maybe returned by the function. I can write a patch
for that. I presume the same issue would be present in a lot of places.

-- 
Sakari Ailus
sakari.ailus at linux.intel.com
