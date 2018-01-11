From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 11 Jan 2018 08:45:21 -0700
Subject: [PATCH 00/10] perf tools: Add support for CoreSight trace decoding
In-Reply-To: <20180111122317.GA7834@sirena.org.uk>
References: <1513356299-26274-1-git-send-email-mathieu.poirier@linaro.org>
 <20180110180821.a92368599af8708790e0362b@arm.com>
 <20180111122317.GA7834@sirena.org.uk>
Message-ID: <CANLsYkzBi3M48VtUYJcSREshXBxiaN5m5RsCcdi=4C1Z7jmMoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 January 2018 at 05:23, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Jan 10, 2018 at 06:08:21PM -0600, Kim Phillips wrote:
>> Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>
>> > Instructions on how to build and install the openCSD library are provided
>> > in the HOWTO.md of the project repository.
>
>> Usually when a perf builder sees something they need "on," they - or,
>> at least I - start querying the host's package manager for something
>> that provides it (e.g., apt search/install libopencsd), but since no
>> distro provides libopencsd, this is bad because it misleads the user.
>
> It's on the radar to push this at distros fairly soon.  Part of the
> discussion was wanting to get things to the point where the tools using
> the library were far enough along that we could be reasonably sure that
> there weren't any problems that were going to require ABI breaks to fix
> before pushing the library at distros since ABI churn isn't nice for
> packagers to deal with.  There's also a bit of a chicken and egg problem
> in that it's a lot easier to get distros to package libraries that have
> users available (some are not really bothered about this of course but
> it still helps).

Moreover including in the kernel tree every library that can
potentially be used by the perf tools simply doesn't scale.  The perf
tools project has come up with a very cleaver way to deal with
external dependencies and I don't see why the OpenCSD library should
be different.

>
>> Keeping the library external will also inevitably introduce more
>> source level synchronization problems because the perf sources being
>> built may not be compatible with their version of the library, whether
>> due to new features like new trace hardware support, or API changes.
>
> Perf users installing from source rather than from a package (who do
> tend to the more technical side even for kernel developers) already have
> to cope with potentially installing at least dwarf, gtk2, libaudit,
> libbfd, libelf, libnuma, libperl, libpython, libslang, libcrypto,
> libunwind, libdw-dwarf-unwind, zlib, lzma, bpf and OpenJDK depending on
> which features they want.  I'm not sure that adding one more library is
> going to be the end of the world here, especially once the packaging
> starts to filter through distros.  Until that happens at least people
> are no worse off for not having the feature.

I completely agree.  Just like any other package, people that want the
very latest code need to install from source.

>
>> As Mark Brown (cc'd) mentioned on the Coresight mailing list, this may
>> be able to be done the same way the dtc is incorporated into the
>> kernel, where only its relevant sources are included and updated as
>> needed:  see linux/scripts/dtc/update-dtc-source.sh.
>
> Bear in mind that we need dtc for essentially all kernel development on
> ARM and when it was introduced it was a new requirement for existing
> systems, it's a bit of a different case here where it's an optional
> feature in an optional tool.
