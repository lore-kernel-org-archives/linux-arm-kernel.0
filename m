From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 19 Mar 2015 19:12:31 +0000
Subject: [patch 2/7] dt: dtb version: document chosen/dtb-info node binding
In-Reply-To: <550B013B.1060002@gmail.com>
References: <550A42AC.8060104@gmail.com> <550A4382.4030209@gmail.com>
 <20150319134910.GF18473@leverpostej> <550B013B.1060002@gmail.com>
Message-ID: <20150319191231.GC11683@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I'm not sure I see the point in adding a property which is not
> > well-defined and not guarnateed to be in any way stable.
> 
> This binding is kind of an odd ball to me.  It is clearly _not_ describing
> hardware, which is really the central point of the dtb.  But the chosen
> node is allowed to cover policy things like the boot command line.

Sure, but this has nothing to do with policy regarding the HW. This is
entirely to do with the build environment of the DTB, which in general
you don't need to know.

> If I want to debug DTB related issues, read the source that was used
> to create the DTB, or slightly modify the DTB - where is the source
> and what is the version of it in the source control system.

That's only useful if you have access to the machine that the source is
on, access to the repo on said machine, and so on.

You can easily slightly modify a DTB by decompiling and recompiling it,
as bootloaders do to inject /chosen/bootargs. Admittedly this can be
painful, but at least you know exactly what was changed, because you
know which DTB you started with.

Consider what modification by other agents means for provenance of the
DTB. We've already been bitten by bootloaders messing with the DTB [1],
and simple loaders can change things substantially [2,3], and won't
update any provenance binding.

> When building and installing a DTB, did the version that I wanted to
> install on the target actually get on the target.

You can already check the hash if you want to check that you copies the
correct version; which is better than trusting an arbitrary string,
because if anything fiddles with the DTB it will change.

[...]

> >> +dtb-path
> >> +	The build directory relative path of the DTB.
> >> +
> >> +dts-path
> >> +	The absolute path of the .dts file compiled to create the DTB.
> > 
> > Why do you need the DTB path?
> 
> Paranoia.  Even if not probable, one could build different DTBs from
> the same .dts.

One could also build the same DTB from two different dts files, no?

You could build the same dtb from the same dts, but with some arbitrary
things changed, such that the at either end of the process is
irrelevant. Personally, I end up doing this a fair amount when testing.

> > Why do these differ w.r.t. absolute/relative?
> 
> Those are the forms of the path that are present in the build
> system.  If there is a good reason to change one of them to the
> other form, I could add the extra complexity to massage the path.
> 
> > 
> > Why would you _ever_ need an absolute path!?
> 
> The absolute path tells you which source repository contained the source.

Except that the absolute path is realtive to the machine it was built
on, so doesn't actually help.

On various machines I have folders called /home/mark/src/linux. These
are not the same folder. If I gave you a DTB that told you it was from
/home/mark/src/linux/arch/arm64/boot/dts/vendor/foo.dts, you would have
difficulty acquiring that precise file.

As far as I can tell, this binding just allows you to place a
meaningless set of strings in the DTB, that don't actually tell you
anything useful.

Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/329938.html
[2] https://git.kernel.org/cgit/linux/kernel/git/mark/boot-wrapper-aarch64.git/
[3] https://git.kernel.org/cgit/linux/kernel/git/mark/boot-wrapper-aarch64.git/commit/?id=e4ae51a1c128ccaac01bdc834692fd15c3a3c8de
