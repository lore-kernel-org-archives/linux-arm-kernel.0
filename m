From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Apr 2014 19:45:16 +0100
Subject: [PATCH v6 0/6] ARM: vdso gettimeofday using generic timer
 architecture
In-Reply-To: <53595AE9.5000506@mentor.com>
References: <cover.1398213562.git.nathan_lynch@mentor.com>
 <20140423215040.GC26756@n2100.arm.linux.org.uk> <535926EF.20805@mentor.com>
 <20140424162229.GU26756@n2100.arm.linux.org.uk> <53595AE9.5000506@mentor.com>
Message-ID: <20140424184516.GY26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 01:41:45PM -0500, Nathan Lynch wrote:
> On 04/24/2014 11:22 AM, Russell King - ARM Linux wrote:
> > 
> > The obvious question therefore is, if the dynamic linker throws its toys
> > out if it encounters a wrong-float-ABI library during a standard library
> > search, why would it _not_ throw its toys out on dlsym.  The difference
> > in behaviour would to me seem to be a bug - both should behave the same,
> > though of course not throwing its toys out, but instead producing an error
> > _or_ accepting the difference.  Given that it's an ABI difference,
> > rejecting the library is the only sane approach.
> 
> The VDSO would appear to not be subject to the same validation that a
> file-based DSO is.  I'll dig deeper into this to understand exactly
> what's going on, but I have a guess as to why the VDSO happens to work
> with armhf userspace: the calling convention is different only for
> floating point arguments, and there are none in the VDSO routines.

I don't believe the dynamic linker has the necessary information to
know whether any functions take FP arguments.  I have some armel
libraries which definitely make no use of FP, and the linker refuses
to use them with armhf.

It's something that the linker doesn't take account of either - we've
had issues in the kernel with differing float ABIs which cause hard
errors when two dissimilar objects are tried to be linked, even though
they make no use of FP.  They just seem to need to be marked differently
for stuff to complain/reject them.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
