From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 24 Mar 2017 17:25:33 +0000
Subject: Query: ARM64: A random failure with hugetlbfs linked mmap() of a
 stack area
In-Reply-To: <d6ee1a17-4518-5a37-f8b7-b62030c24cc7@redhat.com>
References: <4e776e1f-dd11-2fa2-5109-6c2b5184b70d@redhat.com>
 <20170324161558.GA10491@leverpostej>
 <d6ee1a17-4518-5a37-f8b7-b62030c24cc7@redhat.com>
Message-ID: <20170324172533.GA10746@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 10:11:10PM +0530, Pratyush Anand wrote:
> Hi Mark,
> 
> On Friday 24 March 2017 09:45 PM, Mark Rutland wrote:
> >It's clear from the log that the test is simply blatting a number of
> >important mappings including libc, so I think this is simply a broken
> >test.
> 
> Thanks a lot for taking out time and investigating it so quickly.
> Yes, I noticed that as well. Frankly, I do not understand that why
> that upstream libhugetlbfs test is like that. But that test has been
> passing on different architecture for quite long time.

I guess that on other architectures, the test is run with a smaller
hugepage size, which happens to not clobber impoertant data.

> Moreover, even if mmap() in test routine crosses over many other
> text/rd/rw area mappings, should it fail? We are not writing
> anything to mmaped area. So, why should just a creation of another
> map result in segmentation fault?

The new mapping replaces the old mappings that it clobbers, so all the
old data/code is gone. Loads or instruction fetches will see data from
the new mapping.

In my case, since the libc code was clobbered, the CPU tried to execute
the zeroes it was clobbered with, and took an illegal instruction abort.

For your report, it's not clear to me what's going on. Did you take the
/proc/pid/maps data from teh exact same process that the segfault
occurred in? and/or did you disable ASLR?

Thanks,
Mark.
