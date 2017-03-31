From: ar@linux.vnet.ibm.com (Andrea Reale)
Date: Fri, 31 Mar 2017 15:16:04 +0100
Subject: [RFC PATCH] Memory hotplug support for arm64 platform
In-Reply-To: <ef53951f-ff03-91d2-506a-c5eccb6512b4@gmail.com>
References: <1481717765-31186-1-git-send-email-m.bielski@virtualopensystems.com>
 <75156ea7-6e74-27e8-bf29-762f79151d23@broadcom.com>
 <7977063a-20bb-cc85-449f-51bb7d20761e@virtualopensystems.com>
 <6568a65d-79c0-6fe4-e4d0-f1d3fe205321@broadcom.com>
 <20170206111732.GA5589@samekh>
 <ef53951f-ff03-91d2-506a-c5eccb6512b4@gmail.com>
Message-ID: <20170331141603.GA1440@samekh>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

thanks for your message. Please, find the replies in-line.

On Wed, Mar 29, 2017 at 05:40:02PM -0700, Florian Fainelli wrote:
> While the "hack" that sets/clears NOMAP in order for pfn_valid() to
> return false/true when appropriate during __add_pages() definitively
> does seem to work to probe the memory section, don't you also hit the
> same warning when you try to online that memory section in
> pages_correctly_reserved() once you have cleared the NOMAP flag?

Before arch_add_memory returns, we clear the nomap flag on the blocks,
so that pfn_valid will return true when executing on the corresponding
pages. This means that the condition in pages_correctly_reserved in
drivers/base/memory.c:

	if (WARN_ON_ONCE(!pfn_valid(pfn)))

will evaluate to false, so no warning should be issued, and the function
should continue to execute as expected.

Is it that you were referring to or did I miss the point?

> I will definitively give this a try on ARM64 since I need to get it
> working there.

Thanks a lot, any help in testing is really appreciated. 
 
> Do you mind posting a non-RFC patch?

We should release the hot-remove code that myself and Maciej have been
working on very soon (say, around one week); the plan is to rebase
everything and release hot-add and hot-remove as a single patch series
(including Scott's original patches and our hot-add patches). If you
can wait until then, we will probably minimize entropy; otherwise we
can also re-post the hot-add patches earlier and separately.
 
Thanks and regards,
Andrea
