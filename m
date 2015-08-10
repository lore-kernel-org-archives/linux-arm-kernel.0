From: david.vrabel@citrix.com (David Vrabel)
Date: Mon, 10 Aug 2015 13:14:32 +0100
Subject: [Xen-devel] [PATCH v3 19/20] xen/privcmd: Add support for Linux
 64KB page granularity
In-Reply-To: <alpine.DEB.2.02.1508101230260.11337@kaball.uk.xensource.com>
References: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
 <1438966019-19322-20-git-send-email-julien.grall@citrix.com>
 <alpine.DEB.2.02.1508101230260.11337@kaball.uk.xensource.com>
Message-ID: <55C895A8.9020004@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/15 13:03, Stefano Stabellini wrote:
> On Fri, 7 Aug 2015, Julien Grall wrote:
>> -	rc = HYPERVISOR_memory_op(XENMEM_add_to_physmap_range, &xatp);
>> -	return rc < 0 ? rc : err;
>> +	for (i = 0; i < nr_gfn; i++) {
>> +		if ((i % XEN_PFN_PER_PAGE) == 0) {
>> +			page = pages[i / XEN_PFN_PER_PAGE];
> 
> If this function is going to be called very frequently you might want to
> consider using a shift instead.
> 
>     page = pages[i >> 4];
> 
> With an appropriate macro of course.

This change isn't necessary.  Compilers already turn divides into
suitable shifts.

David
