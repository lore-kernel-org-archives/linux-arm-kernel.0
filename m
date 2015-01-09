From: will.deacon@arm.com (Will Deacon)
Date: Fri, 9 Jan 2015 19:43:34 +0000
Subject: Linux 3.19-rc3
In-Reply-To: <54B01FF0.3020900@arm.com>
References: <CA+55aFwsxoyLb9OWMSCL3doe_cz_EQtKsEFCyPUYn_T87pbz0A@mail.gmail.com>
 <54AE7D53.2020305@redhat.com> <20150109121348.GD12942@leverpostej>
 <CAPvkgC23LHhs7Tw4rdAPFooimonji8R7kEAbWYRKPJwouwUzBA@mail.gmail.com>
 <54AFE53A.4020004@redhat.com> <20150109175702.GA27787@leverpostej>
 <54B01FF0.3020900@arm.com>
Message-ID: <20150109194333.GA23028@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 06:37:36PM +0000, Marc Zyngier wrote:
> On 09/01/15 17:57, Mark Rutland wrote:
> > On Fri, Jan 09, 2015 at 02:27:06PM +0000, Mark Langsdorf wrote:
> >> On 01/09/2015 08:19 AM, Steve Capper wrote:
> >>> On 9 January 2015 at 12:13, Mark Rutland <mark.rutland@arm.com> wrote:
> >>>> On Thu, Jan 08, 2015 at 12:51:31PM +0000, Mark Langsdorf wrote:
> >>>>> I'm consistently getting an out of memory killer triggered when
> >>>>> compiling the kernel (make -j 16 -s) on a 16 core ARM64 system
> >>>>> with 16 GB of memory. This doesn't happen when running a 3.18
> >>>>> kernel.
> >>>>>
> >>>>> I'm going to start bisecting the failure now, but here's the crash
> >>>>> log in case someone can see something obvious in it.
> >>>>
> >>>> FWIW I've just reproduced this with v3.19-rc3 defconfig +
> >>>> CONFIG_ARM64_64K_PAGES=y by attempting a git clone of mainline. My
> >>>> system has 16GB of RAM and 6 CPUs.

[...]

> > I wasn't able to trigger the issue again with git, and the only way I've
> > managed to trigger the issue is repeatedly building the kernel in a
> > loop:
> > 
> > while true; do
> > 	git clean -fdx > /dev/null 2>&1;
> > 	make defconfig > /dev/null 2>&1;
> > 	make > /dev/null > 2>&1;
> > done
> > 
> > Which after a while died:
> > 
> > -bash: fork: Cannot allocate memory

[...]

> Just as another data point: I'm reproducing the exact same thing (it
> only took a couple of kernel builds to kill the box), with almost all
> 16GB of RAM stuck in Active(anon). I do *not* have CMA enabled though.
> 
> I've kicked another run with 4k pages.

The `mallocstress' tool from LTP seems to be a quick way to reproduce
the memory leak behind this (leaks 5/8GB on my Juno). It spawns a bunch
of threads, that each call malloc until it returns NULL. I thought maybe
we're leaking page tables, but 5GB is pretty excessive.

However, I'm unable to reproduce the problem under a 32-bit kernel on my
TC2 board or on 3.18 + the 3.19 merge window pull for arm64.

I guess we should try to bisect using the above.

Will
