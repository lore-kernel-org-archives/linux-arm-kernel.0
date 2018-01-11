From: kim.phillips@arm.com (Kim Phillips)
Date: Thu, 11 Jan 2018 11:28:35 -0600
Subject: [PATCH 00/10] perf tools: Add support for CoreSight trace decoding
In-Reply-To: <CANLsYkzBi3M48VtUYJcSREshXBxiaN5m5RsCcdi=4C1Z7jmMoA@mail.gmail.com>
References: <1513356299-26274-1-git-send-email-mathieu.poirier@linaro.org>
 <20180110180821.a92368599af8708790e0362b@arm.com>
 <20180111122317.GA7834@sirena.org.uk>
 <CANLsYkzBi3M48VtUYJcSREshXBxiaN5m5RsCcdi=4C1Z7jmMoA@mail.gmail.com>
Message-ID: <20180111112835.1511702c2e6ba0077af4112e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 11 Jan 2018 08:45:21 -0700
Mathieu Poirier <mathieu.poirier@linaro.org> wrote:

> On 11 January 2018 at 05:23, Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Jan 10, 2018 at 06:08:21PM -0600, Kim Phillips wrote:
> >> Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> >
> >> > Instructions on how to build and install the openCSD library are provided
> >> > in the HOWTO.md of the project repository.
> >
> >> Usually when a perf builder sees something they need "on," they - or,
> >> at least I - start querying the host's package manager for something
> >> that provides it (e.g., apt search/install libopencsd), but since no
> >> distro provides libopencsd, this is bad because it misleads the user.
> >
> > It's on the radar to push this at distros fairly soon.

Adding packages to distros takes years, this patchset is being
submitted for inclusion *now*.  So until then, it would greatly
facilitate users if the relevant libopencsd source files were
self-contained within perf from the get go.

> >  Part of the
> > discussion was wanting to get things to the point where the tools using
> > the library were far enough along that we could be reasonably sure that

Curious, what other tools are there?

> > there weren't any problems that were going to require ABI breaks to fix
> > before pushing the library at distros since ABI churn isn't nice for
> > packagers to deal with.  

Why make perf the guinea pig?  Whatever, this doesn't preclude
adding the code into the tree; it can be removed years from now when
libopencsd becomes ubiquitous among distros.

> > There's also a bit of a chicken and egg problem
> > in that it's a lot easier to get distros to package libraries that have
> > users available (some are not really bothered about this of course but
> > it still helps).
> 
> Moreover including in the kernel tree every library that can
> potentially be used by the perf tools simply doesn't scale.

This is a trace decoder library we're talking about:  there are no
others in perf's system features autodetection list.  And why wouldn't
adding such libraries scale?

>  The perf
> tools project has come up with a very cleaver way to deal with
> external dependencies and I don't see why the OpenCSD library should
> be different.

Again, the opencsd library is a decoder library:  this patchseries adds
it as a package dependency (when it isn't even a package in any
distro), and it's different in that it's the first decoder library to
be submitted as an external dependency (i.e., not fully built-in, like
Intel's, or even the Arm SPE's pending submission).

> >> Keeping the library external will also inevitably introduce more
> >> source level synchronization problems because the perf sources being
> >> built may not be compatible with their version of the library, whether
> >> due to new features like new trace hardware support, or API changes.
> >
> > Perf users installing from source rather than from a package (who do
> > tend to the more technical side even for kernel developers) already have
> > to cope with potentially installing at least dwarf, gtk2, libaudit,
> > libbfd, libelf, libnuma, libperl, libpython, libslang, libcrypto,
> > libunwind, libdw-dwarf-unwind, zlib, lzma, bpf and OpenJDK depending on
> > which features they want.  I'm not sure that adding one more library is
> > going to be the end of the world here, especially once the packaging
> > starts to filter through distros.  Until that happens at least people
> > are no worse off for not having the feature.
> 
> I completely agree.  Just like any other package, people that want the
> very latest code need to install from source.

A fully-integrated solution would work better for people, e.g., how are
people supposed to know what 'latest' is when there are separate,
unsynchronized git repos?

> >> As Mark Brown (cc'd) mentioned on the Coresight mailing list, this may
> >> be able to be done the same way the dtc is incorporated into the
> >> kernel, where only its relevant sources are included and updated as
> >> needed:  see linux/scripts/dtc/update-dtc-source.sh.
> >
> > Bear in mind that we need dtc for essentially all kernel development on
> > ARM and when it was introduced it was a new requirement for existing
> > systems, it's a bit of a different case here where it's an optional
> > feature in an optional tool.

That argument applies to Intel-PT, yet its decoder is self-contained
within perf: all non-x86 perf binaries are capable of decoding PT.
We'd want that for Arm Coresight where perf gets statically built to
run on much more constrained systems like Android.

Or are you referring to the higher level linux/scripts/ location of the
dtc?  That's not my point: the libopencsd sources can live under
somewhere like linux/tools/.

Kim
