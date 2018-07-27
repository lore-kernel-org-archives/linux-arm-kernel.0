From: oleg@redhat.com (Oleg Nesterov)
Date: Fri, 27 Jul 2018 15:55:29 +0200
Subject: [PATCH v6 5/6] Uprobes/sdt: Prevent multiple reference counter
 for same uprobe
In-Reply-To: <19d8abb0-44a3-cb26-405d-95f63fc01517@linux.ibm.com>
References: <20180716084706.28244-1-ravi.bangoria@linux.ibm.com>
 <20180716084706.28244-6-ravi.bangoria@linux.ibm.com>
 <20180725110802.GA27325@redhat.com>
 <19d8abb0-44a3-cb26-405d-95f63fc01517@linux.ibm.com>
Message-ID: <20180727135528.GA3618@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ravi,

On 07/27, Ravi Bangoria wrote:
>
> > I simply can't understand this "bool installed"....
>
>
> That boolean is needed because consumer_filter() returns false when this
> function gets called first time from uprobe_register().

Ah yes, I forgot about the (ugly) 2-stage TRACE_REG_PERF_REGISTER +
TRACE_REG_PERF_OPEN logic...

But then I think the whole idea of REF_CTR_OFF_RELOADED is even more broken.
Nevermind.

> I have a solution for this. Idea is, if reference counter is reloaded, save
> of all mms for which consumer_filter() denied to updated when being called
> from register_for_each_vma(). Use this list of mms as checklist next time
> onwards. I don't know if it's good to do that or not.

Sounds horrible ;) and I bet this is not enough.

> Please let me know if you have any better approach.

Just drop this patch.

If we can't make it per consumer, let it be global like it was in first version.

Oleg.
