From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 6 Jun 2018 09:53:39 -0500
Subject: [PATCH] arm64: topology: Avoid checking numa mask for scheduler
 MC selection
In-Reply-To: <20180606144444.GB8461@e105550-lin.cambridge.arm.com>
References: <20180605190837.493505-1-jeremy.linton@arm.com>
 <20180606144444.GB8461@e105550-lin.cambridge.arm.com>
Message-ID: <be5f7066-0b44-ff11-37e9-87512df2294f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2018 09:44 AM, Morten Rasmussen wrote:
> On Tue, Jun 05, 2018 at 02:08:37PM -0500, Jeremy Linton wrote:
>> The numa mask subset check has problems if !CONFIG_NUMA, over hotplug
>> operations or during early boot. Lets disable the NUMA siblings checks
>> for the time being, as NUMA in socket machines have LLC's that will
>> assure that the scheduler topology isn't "borken".
> 
> Could we add an explanation why the numa node mask check is needed in
> the first place. >
> IIUC, we have the check in case the LLC is shared across numa nodes as
> this would cause core_siblings > cpumask_of_node() which breaks the
> scheduler topology.

Yes, that sounds like a good idea, my comments probably assume that the 
reader has been part of these conversations.


> 
> While sharing LLC across numa nodes seems quite unusual, I think it is
> allowed by ACPI. Those systems might already be broken before, so might
> not change anything. It is just worth noting why the check should be
> added back later.

Right, there isn't anything in ACPI that dictates a system topology 
restriction like this. Given that other architectures have built 
machines with large directory caches that span numa nodes the check was 
a safety measure.
