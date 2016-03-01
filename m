From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Tue, 1 Mar 2016 13:21:12 +0100
Subject: [PATCH v12 4/5] arm64, numa: Add NUMA support for arm64 platforms.
In-Reply-To: <56D4D782.3010503@gmail.com>
References: <1456192703-2274-1-git-send-email-ddaney.cavm@gmail.com>
 <1456192703-2274-5-git-send-email-ddaney.cavm@gmail.com>
 <20160229173446.GG31343@rric.localdomain>
 <56D4D782.3010503@gmail.com>
Message-ID: <20160301122112.GU24726@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.02.16 15:42:58, David Daney wrote:
> On 02/29/2016 09:34 AM, Robert Richter wrote:
> >On 22.02.16 17:58:22, David Daney wrote:
> >>From: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>

> >>+static int __init numa_init(int (*init_func)(void))
> >>+{
> >>+	int ret;
> >>+
> >>+	nodes_clear(numa_nodes_parsed);
> >>+	nodes_clear(node_possible_map);
> >>+	nodes_clear(node_online_map);
> >>+	numa_free_distance();
> 
>         ^^^^^^^^^^^^^
>      Cleanup for any previous numa_alloc_distance()
> 
> >>+
> >>+	ret = numa_alloc_distance();
> >>+	if (ret < 0)
> >>+		return ret;
> >
> >If you move this before the remaining initializers, you will need to
> >clean this up on error.
> 
> Yes, we do this.  See above.
> 
> >So better move it back after
> >numa_register_nodes() as it was in v10. This should work since
> >distances are used not earlier than numa is enabled.
> 
> I moved it here for a reason.
> 
> The init_func (of_numa_init() in this case) makes callbacks that use the
> numa_distance object.  We need to allocate it before using it. Allocating it
> after calling the init_func() is too late.

Sounds reasonable and looks sane now.

Thanks,

-Robert
