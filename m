From: jhugo@codeaurora.org (Jeffrey Hugo)
Date: Mon, 2 Jul 2018 08:58:17 -0600
Subject: [PATCH] arm64: acpi: reenumerate topology ids
In-Reply-To: <20180629154608.nqudibf54ti6dpjc@kamzik.brq.redhat.com>
References: <20180628145128.10057-1-drjones@redhat.com>
 <a38fb684-c023-1a96-464e-dd268f3132ea@arm.com>
 <20180628173243.obydzakh2stfs26w@kamzik.brq.redhat.com>
 <20180629102927.GA18043@e107155-lin>
 <20180629112354.hefdl2pe72frl6x3@kamzik.brq.redhat.com>
 <20180629132934.GA16282@e107155-lin>
 <20180629154608.nqudibf54ti6dpjc@kamzik.brq.redhat.com>
Message-ID: <3a393398-b340-84f0-3478-ebd7dba9a0ae@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/29/2018 9:46 AM, Andrew Jones wrote:
> On Fri, Jun 29, 2018 at 02:29:34PM +0100, Sudeep Holla wrote:
>> If it matters a lot, vendors must use UID for consistency. Since OS doesn't
>> use those IDs for any particular reason, OS must not care.
> 
> That depends. If you look at how topology_logical_package_id() is used in
> x86 code you'll see it gets used as an index to an array in a couple
> places. If we don't remap arbitrary IDs to counters than we may miss out
> on some opportunities to avoid lists.
> 
> Also, we're talking about what's visible to users. I think it's much more
> likely to break a user app by exposing topology IDs that have values
> greater than the linear CPU numbers (even though properly written apps
> shouldn't expect them to be strictly <=), than the opposite.

Libvirt has the assumption already that the sysfs numbers correspond to 
linear CPU numbers, and has an arbitrary limit of 4k.  When spinning up 
a VM, if libvirt sees a CPU ID > 4k, it fails to init the VM since it 
assumes the host has more than 4k CPUs, which is unsupported.

We found this when we were making our UIDs to be the same as MPIDR in 
MADT.  We changed our UIDs to be sequential 0-N numbering to workaround 
the issue.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
