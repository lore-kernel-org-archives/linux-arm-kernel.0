From: mhocko@kernel.org (Michal Hocko)
Date: Thu, 30 Nov 2017 10:47:38 +0100
Subject: [PATCH v2 2/5] mm: memory_hotplug: Remove assumption on memory
 state before hotremove
In-Reply-To: <20171129012040.GC1469@linux-l9pv.suse>
References: <cover.1511433386.git.ar@linux.vnet.ibm.com>
 <4e21a27570f665793debf167c8567c6752116d0a.1511433386.git.ar@linux.vnet.ibm.com>
 <CAJZ5v0i7vOxwhgA1LWYDqxCKkHaYikCf_HZZQCbgApLpoyV2JA@mail.gmail.com>
 <20171124144917.GB1966@samekh>
 <20171124154317.copbe3u6y2q4mura@dhcp22.suse.cz>
 <20171124155458.GC1966@samekh>
 <20171124164042.3crcoz2lwgwv725l@dhcp22.suse.cz>
 <20171129012040.GC1469@linux-l9pv.suse>
Message-ID: <20171130094738.254w36va3lgqodpa@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 29-11-17 09:20:40, Joey Lee wrote:
> On Fri, Nov 24, 2017 at 07:17:41PM +0100, Michal Hocko wrote:
[...]
> > You cannot hotremove memory which is still online. This is what caller
> > should enforce. This is too late to handle the failure. At least for
> > ACPI.
> >
> 
> The logic in acpi_scan_hot_remove() calls memory_subsys_offline(). If
> there doesn't have any error returns by memory_subsys_offline, then ACPI
> assumes all devices are offlined by subsystem (memory subsystem in this case).

yes, that is what I meant by calling it caller responsibility

> Then system moves to remove stage, ACPI calls acpi_memory_device_remove().
> Here
>  
> > > I cannot see any need to
> > > BUG() in such a case: an error code seems more than sufficient to me.
> > 
> > I do not rememeber details but AFAIR ACPI is in a deferred (kworker)
> > context here and cannot simply communicate error code down the road.
> > I agree that we should be able to simply return an error but what is the
> > actual error condition that might happen here?
> >
> 
> Currently acpi_bus_trim() didn't handle any return error. If subsystem
> returns error, then ACPI can only interrupt hot-remove process.
> 
> > > This is why this patch removes the BUG() call when the "offline" check
> > > fails from the generic code. 
> > 
> > As I've said we should simply get rid of BUG rather than move it around.
> >
> 
> As I remember that the original BUG() helped us to find out a bug about the
> offline state doesn't sync between memblock device with memory state.
> Something likes:
> 	mem->dev.offline != (mem->state == MEM_OFFLINE)
> 
> So, the BUG() is useful to capture bug about state sync between device object
> and subsystem object.

BUG is a fatal condition under many contexts. And therefore not an
appropriate error handling.
-- 
Michal Hocko
SUSE Labs
