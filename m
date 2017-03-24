From: panand@redhat.com (Pratyush Anand)
Date: Fri, 24 Mar 2017 23:32:58 +0530
Subject: Query: ARM64: A random failure with hugetlbfs linked mmap() of a
 stack area
In-Reply-To: <20170324172533.GA10746@leverpostej>
References: <4e776e1f-dd11-2fa2-5109-6c2b5184b70d@redhat.com>
 <20170324161558.GA10491@leverpostej>
 <d6ee1a17-4518-5a37-f8b7-b62030c24cc7@redhat.com>
 <20170324172533.GA10746@leverpostej>
Message-ID: <2b8bf63f-3e20-aa26-2d75-83aa2ab35cde@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 24 March 2017 10:55 PM, Mark Rutland wrote:
>> Moreover, even if mmap() in test routine crosses over many other
>> text/rd/rw area mappings, should it fail? We are not writing
>> anything to mmaped area. So, why should just a creation of another
>> map result in segmentation fault?
> The new mapping replaces the old mappings that it clobbers, so all the
> old data/code is gone. Loads or instruction fetches will see data from
> the new mapping.
>

Humm..I see..But in that case mmap() should have failed and return 
MAP_FAILED instead of remapping and which could cause a segfault.
I see that upstream test case, has mmap() in a loop and it goes further 
only with a successful mapping. So, if it would have failed then 
probably test would have tried next address for mmaping until it would 
have touched heap area.

> In my case, since the libc code was clobbered, the CPU tried to execute
> the zeroes it was clobbered with, and took an illegal instruction abort.
>
> For your report, it's not clear to me what's going on. Did you take the
> /proc/pid/maps data from teh exact same process that the segfault
> occurred in? and/or did you disable ASLR?

Yes, it is from the same process. Since, I was not able to reproduce 
with gdb so, I had inserted a scanf() just before mmap() and then had 
read /proc/pid/maps.

~Pratyush
