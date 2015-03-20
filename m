From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 20 Mar 2015 15:25:19 +0000
Subject: [patch 2/7] dt: dtb version: document chosen/dtb-info node binding
In-Reply-To: <550B3F2E.2000303@gmail.com>
References: <550A42AC.8060104@gmail.com> <550A4382.4030209@gmail.com>
 <20150319134910.GF18473@leverpostej> <550B013B.1060002@gmail.com>
 <20150319191231.GC11683@leverpostej> <550B3F2E.2000303@gmail.com>
Message-ID: <20150320152518.GI14766@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > You can already check the hash if you want to check that you copies the
> > correct version; which is better than trusting an arbitrary string,
> > because if anything fiddles with the DTB it will change.
> 
> I'm confused.  If the bootloader fiddles with the DTB then I can not
> compare a hash of the DTB from the build host to a hash of the DTB
> on the target.  Of course the bootloader can also fiddle with the
> dtb-info if it wants to .  Bootloaders do what they want to do.  :-(

This is a fundamental issue with the approach: if bootloaders  mess with
the DTB, then the provenance information is at best misleading.

If bootloaders don't mess with the DTB, then a hash gives you reliable
provenance information, provided you have a DB of the hashes of DTBs
you've shipped. If you're already in the habit of distributing binaries
that should be fine, and if you're not then it presumably doesn't matter
anyway.

> >>>> +dtb-path
> >>>> +	The build directory relative path of the DTB.
> >>>> +
> >>>> +dts-path
> >>>> +	The absolute path of the .dts file compiled to create the DTB.
> >>>
> >>> Why do you need the DTB path?
> >>
> >> Paranoia.  Even if not probable, one could build different DTBs from
> >> the same .dts.
> > 
> > One could also build the same DTB from two different dts files, no?
> > 
> > You could build the same dtb from the same dts, but with some arbitrary
> > things changed, such that the at either end of the process is
> > irrelevant. Personally, I end up doing this a fair amount when testing.
> 
> Exactly.  And the dtb version number will change when the DTB is
> recompiled.

Consider having to work around stale object issues in the build system
with git clean -fdx or similar. While unfortunate, this is sometimes
necessary. Due to this, I build two different DTBs with exactly the same
"version".

If you need to tell these apart, you can do that by hash. You don't need
the "version" to do so.

(and yes, I am aware that the same is true of the kernel).

> >>> Why do these differ w.r.t. absolute/relative?
> >>
> >> Those are the forms of the path that are present in the build
> >> system.  If there is a good reason to change one of them to the
> >> other form, I could add the extra complexity to massage the path.
> >>
> >>>
> >>> Why would you _ever_ need an absolute path!?
> >>
> >> The absolute path tells you which source repository contained the source.
> > 
> > Except that the absolute path is realtive to the machine it was built
> > on, so doesn't actually help.
> 
> Different use cases for different people.

Given the reservations that have been expressed so far, it sounds like
the set of negative use cases is larger than the set of positives.

> In all cases the absolute path includes the relative path, so it is
> just a case of extra information.  The relative portion of the path
> is still useful for anyone who wants to know what .dts was used in
> the build, even if they don't have access to the build machine.
> (They do have access to the gpl v2 source code, which will have
> at least the relative portion of the path because that is needed
> to build the DTB from the .dts.)
> 
> The extra information in the absolute path could be useful to a
> build engineer, a distro engineer, or a support person for a distro.
> Or could just be useless extra info.

I very much suspect it will end up being the latter. For example I've
seen various iterations of certain FW ship with all-zero ID numbers, for
which the use-cases of said ID numbers are exactly those you mention
above.

As far as I can see, the only consistent and sane way to identify a
binary object is by its hash, which for obvious reasons cannot be
encoded within itself (though can be computed consistently).

> > On various machines I have folders called /home/mark/src/linux. These
> > are not the same folder. If I gave you a DTB that told you it was from
> > /home/mark/src/linux/arch/arm64/boot/dts/vendor/foo.dts, you would have
> > difficulty acquiring that precise file.
> 
> If you distributed the DTB to me under the gpl v2 then you have also
> either distributed the source to me or offered to make it available
> to me.

That being the case you don't care about the fields; we've established
that they're meaningless to the end user.

Were I to have distributed files to you, I would have archived the
relevant build (with source, config, and so on). I can look up what I've
distributed to you and hand you the source without needing additional
properties in the DTB.

Mark.
