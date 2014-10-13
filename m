From: aneesh.kumar@linux.vnet.ibm.com (Aneesh Kumar K.V)
Date: Mon, 13 Oct 2014 10:45:24 +0530
Subject: [PATCH V4 1/6] mm: Introduce a general RCU get_user_pages_fast.
In-Reply-To: <20141002121902.GA2342@redhat.com>
References: <1411740233-28038-1-git-send-email-steve.capper@linaro.org>
 <1411740233-28038-2-git-send-email-steve.capper@linaro.org>
 <20141002121902.GA2342@redhat.com>
Message-ID: <87d29w1rf7.fsf@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrea Arcangeli <aarcange@redhat.com> writes:

> Hi Steve,
>
> On Fri, Sep 26, 2014 at 03:03:48PM +0100, Steve Capper wrote:
>> This patch provides a general RCU implementation of get_user_pages_fast
>> that can be used by architectures that perform hardware broadcast of
>> TLB invalidations.
>> 
>> It is based heavily on the PowerPC implementation by Nick Piggin.
>
> It'd be nice if you could also at the same time apply it to sparc and
> powerpc in this same patchset to show the effectiveness of having a
> generic version. Because if it's not a trivial drop-in replacement,
> then this should go in arch/arm* instead of mm/gup.c...

on ppc64 we have one challenge, we do need to support hugepd. At the pmd
level we can have hugepte, normal pmd pointer or a pointer to hugepage
directory which is used in case of some sub-architectures/platforms. ie,
the below part of gup implementation in ppc64

else if (is_hugepd(pmdp)) {
	if (!gup_hugepd((hugepd_t *)pmdp, PMD_SHIFT,
			addr, next, write, pages, nr))
		return 0;


-aneesh
