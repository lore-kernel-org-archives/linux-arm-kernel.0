From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Dec 2013 14:24:07 +0000
Subject: [PATCH] arm64: print cpu frequency in /proc/cpuinfo
In-Reply-To: <CAL_Jsq+Z9K4sus6xwN9KYyCUVWy7NFBQCGYvz0wrt=J7h+G35Q@mail.gmail.com>
References: <1386924222-23169-1-git-send-email-vkale@apm.com>
 <20131213103632.GC19177@mudshark.cambridge.arm.com>
 <CAL_Jsq+Z9K4sus6xwN9KYyCUVWy7NFBQCGYvz0wrt=J7h+G35Q@mail.gmail.com>
Message-ID: <20131213142407.GI4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 08:16:16AM -0600, Rob Herring wrote:
> On Fri, Dec 13, 2013 at 4:36 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Fri, Dec 13, 2013 at 08:43:42AM +0000, Vinayak Kale wrote:
> >> Print the cpu frequency field in /proc/cpuinfo.
> >
> > Why? ["x86 does this" isn't a valid answer :)].
> 
> People want to know this stuff.

People want to know this stuff so they can do stupid things in userspace,
like make the assumption that if it gets reported that the CPU is running
at N MHz, then that means to delay M us, they need Z instructions in a
loop.

We've also had people want the cache information in userspace, so that
they can use that to make a decision on whether function X would be
faster than Y, rather than measuring each implementation and basing it
off measurement - we've shown in the past that the cache information
doesn't let you make that kind of decision, because the result is
affected not only by the cache but many other parameters as well (such
as the implementation of the CPU itself.)

I've been dead against exporting cache information from the kernel into
userspace: it's not something that userspace should ever concern itself
with, and it's not something that userspace should ever use to make
decisions about what code should be run.

So, "people want to know this stuff" is a poor reason.  A good reason is
"If I have access to X, then it allows me to do Y, and this is the right
way to allow me to do Y".  So far, I haven't seen any evidence that the
export of cache information gives the right solution to any userspace
problem.  Hence, my position is still the same as above, and this
information should *never* be exported to userspace.
