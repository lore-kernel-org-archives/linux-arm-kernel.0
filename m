From: kevin.tian@intel.com (Tian, Kevin)
Date: Thu, 13 Sep 2018 07:26:30 +0000
Subject: [PATCH v2 01/40] iommu: Introduce Shared Virtual Addressing API
In-Reply-To: <2fd4a0a1-1a35-bf82-df84-b995cce011d9@amd.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-2-jean-philippe.brucker@arm.com>
 <bf42affd-e9d0-e4fc-6d28-f3c3f7795348@redhat.com>
 <03d31ba5-1eda-ea86-8c0c-91d14c86fe83@arm.com>
 <ed39159c-087e-7e56-7d29-d1de9fa1677f@amd.com>
 <f0b317d5-e2e9-5478-952c-05e8b97bd68b@arm.com>
 <2fd4a0a1-1a35-bf82-df84-b995cce011d9@amd.com>
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D191301D0A@SHSMSX101.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Christian K?nig
> Sent: Friday, September 7, 2018 4:56 PM
> 
> 5. It would be nice to have to allocate multiple PASIDs for the same
> process address space.
>  ??? ??? E.g. some teams at AMD want to use a separate GPU address space
> for their userspace client library. I'm still trying to avoid that, but
> it is perfectly possible that we are going to need that.
>  ??? ??? Additional to that it is sometimes quite useful for debugging
> to isolate where exactly an incorrect access (segfault) is coming from.
> 
> Let me know if there are some problems with that, especially I want to
> know if there is pushback on #5 so that I can forward that :)
> 

We have similar requirement, except that it is "multiple PASIDs for
same process" instead of "for same process address space".

Intel VT-d goes to a 'true' system-wide PASID allocation policy, 
cross both host processes and guest processes. As Jacob explains,
there will be a virtual cmd register on virtual vtd, through which
guest IOMMU driver requests to get system-wide PASIDs allocated
by host IOMMU driver.

with that design, Qemu represents all guest processes in host
side, thus will get "multiple PASIDs allocated for same process".
However instead of binding all PASIDs to same host address space
of  Qemu, each of PASID entry points to guest address space if 
used by guest process.

Thanks
Kevin
