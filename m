From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 24 Mar 2017 18:16:53 +0000
Subject: Query: ARM64: A random failure with hugetlbfs linked mmap() of a
 stack area
In-Reply-To: <2b8bf63f-3e20-aa26-2d75-83aa2ab35cde@redhat.com>
References: <4e776e1f-dd11-2fa2-5109-6c2b5184b70d@redhat.com>
 <20170324161558.GA10491@leverpostej>
 <d6ee1a17-4518-5a37-f8b7-b62030c24cc7@redhat.com>
 <20170324172533.GA10746@leverpostej>
 <2b8bf63f-3e20-aa26-2d75-83aa2ab35cde@redhat.com>
Message-ID: <20170324181652.GC10746@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 11:32:58PM +0530, Pratyush Anand wrote:
> 
> 
> On Friday 24 March 2017 10:55 PM, Mark Rutland wrote:
> >>Moreover, even if mmap() in test routine crosses over many other
> >>text/rd/rw area mappings, should it fail? We are not writing
> >>anything to mmaped area. So, why should just a creation of another
> >>map result in segmentation fault?
> >The new mapping replaces the old mappings that it clobbers, so all the
> >old data/code is gone. Loads or instruction fetches will see data from
> >the new mapping.
> 
> Humm..I see..But in that case mmap() should have failed and return
> MAP_FAILED instead of remapping and which could cause a segfault.

That does nto appear to be the case. As per the mmap man page:

  MAP_FIXED
      Don't  interpret addr as a hint: place the mapping at exactly that
      address.  addr must be a multiple of the page size.  If the memory
      region specified by addr and len overlaps pages of any existing
      mapping(s), then the overlapped part of the existing mapping(s)
      will  be discarded.  If the specified address cannot be used,
      mmap() will fail.  Because requiring a fixed address for a mapping
      is less portable, the use of this option is discouraged.

[...]

> >For your report, it's not clear to me what's going on. Did you take the
> >/proc/pid/maps data from teh exact same process that the segfault
> >occurred in? and/or did you disable ASLR?
> 
> Yes, it is from the same process.

That is troubling; I cannot explain that.

> Since, I was not able to reproduce with gdb so, I had inserted a
> scanf() just before mmap() and then had read /proc/pid/maps.

That might be because GDB disables ASLR by default. Did you re-enable
ASLR within GDB with:

	set disable-randomization off

If not, could you give that a go?

Thanks,
Mark.
