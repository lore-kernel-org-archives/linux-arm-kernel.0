From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 10 Aug 2015 14:36:10 +0100
Subject: [PATCH v3 12/20] xen/balloon: Don't rely on the page granularity
 is the same for Xen and Linux
In-Reply-To: <alpine.DEB.2.02.1508101352370.11337@kaball.uk.xensource.com>
References: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
 <1438966019-19322-13-git-send-email-julien.grall@citrix.com>
 <alpine.DEB.2.02.1508101207071.11337@kaball.uk.xensource.com>
 <55C88B77.8030700@citrix.com>
 <alpine.DEB.2.02.1508101352370.11337@kaball.uk.xensource.com>
Message-ID: <55C8A8CA.7070409@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/15 13:55, Stefano Stabellini wrote:
>> If your only concern is the size of the array, we could decrease the
>> number of frames by batch. Or allocation the variable once a boot time.
> 
> Yes, that is my only concern. Allocating only nr_pages new struct page*
> would be good enough I guess.

That would be even worst. We shouldn't allocate the array at every call,
but at boot time.

Note that frame_list is already a static variable use 64KB when 64KB
page is used. I guess this will be unlikely to remove that much frame in
a single batch. But I will keep this optimization for later.

Anyway, I'm wondering if we could re-use the lru field to link the page
when allocate them and retrieve in the second loop in order to avoid the
pages array.

Regards,

-- 
Julien Grall
