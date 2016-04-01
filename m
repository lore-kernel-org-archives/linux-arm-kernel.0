From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Fri, 1 Apr 2016 17:25:25 +0800
Subject: [PATCH v7 12/17] ARM64: ACPI: Check if it runs on Xen to enable
 or disable ACPI
In-Reply-To: <20160331124216.GE26532@leverpostej>
References: <1458830676-27075-1-git-send-email-shannon.zhao@linaro.org>
 <1458830676-27075-13-git-send-email-shannon.zhao@linaro.org>
 <20160329161837.GH6745@arm.com> <20160329163147.GB27223@leverpostej>
 <56FB7E00.7030400@huawei.com>
 <alpine.DEB.2.02.1603311155450.11739@kaball.uk.xensource.com>
 <CAKv+Gu-wPq_FzO3sm7bhSFuu7EVxHWB_v6HOn1GqNbdaE-iBoQ@mail.gmail.com>
 <20160331124216.GE26532@leverpostej>
Message-ID: <56FE3E85.60403@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/3/31 20:42, Mark Rutland wrote:
> On Thu, Mar 31, 2016 at 01:44:08PM +0200, Ard Biesheuvel wrote:
>> > The heuristic is there to decide whether some DTB image contains a
>> > complete description of the platform, or only some data handed over by
>> > the bootloader. Arguably, a DT containing both /chosen and /hypervisor
>> > but nothing else can still not describe an actual platform, and
>> > whether we execute under Xen or not is completely irrelevant.
> I disagree somewhat.
> 
> In general, a /hypervisor node may not be a Xen node, and could
> potentially imply some platform description. As /hypervisor is a generic
> name up for grabs by any hypervisor, we simply cannot make assumptions
> about it.
> 
> As /chosen is a special reserved path that implies a particular binding
> and has no compatible string, so checking its path alone is correct.
> 
> While we do check that the /hypervisor node is "xen,xen" compatible
> elsewhere, the canonical mechanism of checking for a Xen node (as
> opposed to any hypervisor's node) is to check the compatible string.
> 
> If we are going to handle nodes for other hypervisors while treating the
> DTB as empty, we need code and discussion regarding said hypervisor.
> 
> Hence, for checking for a Xen /hypervisor node, I would prefer we
> checked the compatible string rather than the path.
> 
> An is_xen_node() helper (which could also check that the path is
> "/hypervisor") would avoid having redundant, subtly distinct ways of
> checking, and would explicitly document precisely what we are checking
> for.

So if we use is_xen_node(), do we need to call xen_initial_domain()
again? I still think here is_xen_node() and xen_initial_domain() have
same meaning. Why do we need that?

If it really needs is_xen_node(), I will not factor
fdt_find_hyper_node() in patch 11 since it uses flat DT while here it's
going to use unflatten DT.

Thanks,
-- 
Shannon
