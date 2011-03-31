From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 31 Mar 2011 15:26:50 -0400
Subject: [PATCH 05/12] mm: alloc_contig_range() added
In-Reply-To: <1301587361.31087.1040.camel@nimitz>
References: <1301577368-16095-1-git-send-email-m.szyprowski@samsung.com>
	<1301577368-16095-6-git-send-email-m.szyprowski@samsung.com>
	<1301587361.31087.1040.camel@nimitz>
Message-ID: <20110331192650.GE14441@home.goodmis.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2011 at 09:02:41AM -0700, Dave Hansen wrote:
> On Thu, 2011-03-31 at 15:16 +0200, Marek Szyprowski wrote:
> > +       ret = 0;
> > +       while (!PageBuddy(pfn_to_page(start & (~0UL << ret))))
> > +               if (WARN_ON(++ret >= MAX_ORDER))
> > +                       return -EINVAL; 
> 
> Holy cow, that's dense.  Is there really no more straightforward way to
> do that?
> 
> In any case, please pull the ++ret bit out of the WARN_ON().  Some
> people like to do:
> 
> #define WARN_ON(...) do{}while(0)
> 
> to save space on some systems.  

That should be fixed, as the if (WARN_ON()) has become a standard in
most of the kernel. Removing WARN_ON() should be:

#define WARN_ON(x) ({0;})

But I agree, that there should be no "side effects" inside a WARN_ON(),
which that "++ret" is definitely one.

-- Steve
