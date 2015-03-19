From: frowand.list@gmail.com (Frank Rowand)
Date: Thu, 19 Mar 2015 14:27:10 -0700
Subject: [patch 2/7] dt: dtb version: document chosen/dtb-info node binding
In-Reply-To: <20150319191231.GC11683@leverpostej>
References: <550A42AC.8060104@gmail.com> <550A4382.4030209@gmail.com>
 <20150319134910.GF18473@leverpostej> <550B013B.1060002@gmail.com>
 <20150319191231.GC11683@leverpostej>
Message-ID: <550B3F2E.2000303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/19/2015 12:12 PM, Mark Rutland wrote:
>>> I'm not sure I see the point in adding a property which is not
>>> well-defined and not guarnateed to be in any way stable.
>>
>> This binding is kind of an odd ball to me.  It is clearly _not_ describing
>> hardware, which is really the central point of the dtb.  But the chosen
>> node is allowed to cover policy things like the boot command line.
> 
> Sure, but this has nothing to do with policy regarding the HW. This is
> entirely to do with the build environment of the DTB, which in general
> you don't need to know.
> 
>> If I want to debug DTB related issues, read the source that was used
>> to create the DTB, or slightly modify the DTB - where is the source
>> and what is the version of it in the source control system.
> 
> That's only useful if you have access to the machine that the source is
> on, access to the repo on said machine, and so on.

Consider substituting the Linux kernel for the DTB and make the same
statement to see if that sounds like a concern.

Then consider that in many cases a DTB could come from a Linux or
Android distribution, just like many Linux kernels do.  My understanding
is that the sources in the kernel tree used to make DTBs are gpl v2
and thus just as available as the source to a Linux kernel would be.

> 
> You can easily slightly modify a DTB by decompiling and recompiling it,
> as bootloaders do to inject /chosen/bootargs. Admittedly this can be
> painful, but at least you know exactly what was changed, because you
> know which DTB you started with.

Yes, there are circumstances where I might find that the best way to
work on a problem.  I also often use debuggers to show me an assembly
display when debugging a kernel problem.  But I sometimes prefer to
start at the source code level.

> 
> Consider what modification by other agents means for provenance of the
> DTB. We've already been bitten by bootloaders messing with the DTB [1],
> and simple loaders can change things substantially [2,3], and won't
> update any provenance binding.

Yes, bootloaders can cause issues.  This patch set is not intended to
deal with those problems.

btw, thank you for the references, concrete examples help a lot (and
they are interesting examples)!

> 
>> When building and installing a DTB, did the version that I wanted to
>> install on the target actually get on the target.
> 
> You can already check the hash if you want to check that you copies the
> correct version; which is better than trusting an arbitrary string,
> because if anything fiddles with the DTB it will change.

I'm confused.  If the bootloader fiddles with the DTB then I can not
compare a hash of the DTB from the build host to a hash of the DTB
on the target.  Of course the bootloader can also fiddle with the
dtb-info if it wants to .  Bootloaders do what they want to do.  :-(

> 
> [...]
> 
>>>> +dtb-path
>>>> +	The build directory relative path of the DTB.
>>>> +
>>>> +dts-path
>>>> +	The absolute path of the .dts file compiled to create the DTB.
>>>
>>> Why do you need the DTB path?
>>
>> Paranoia.  Even if not probable, one could build different DTBs from
>> the same .dts.
> 
> One could also build the same DTB from two different dts files, no?
> 
> You could build the same dtb from the same dts, but with some arbitrary
> things changed, such that the at either end of the process is
> irrelevant. Personally, I end up doing this a fair amount when testing.

Exactly.  And the dtb version number will change when the DTB is
recompiled.

> 
>>> Why do these differ w.r.t. absolute/relative?
>>
>> Those are the forms of the path that are present in the build
>> system.  If there is a good reason to change one of them to the
>> other form, I could add the extra complexity to massage the path.
>>
>>>
>>> Why would you _ever_ need an absolute path!?
>>
>> The absolute path tells you which source repository contained the source.
> 
> Except that the absolute path is realtive to the machine it was built
> on, so doesn't actually help.

Different use cases for different people.

In all cases the absolute path includes the relative path, so it is
just a case of extra information.  The relative portion of the path
is still useful for anyone who wants to know what .dts was used in
the build, even if they don't have access to the build machine.
(They do have access to the gpl v2 source code, which will have
at least the relative portion of the path because that is needed
to build the DTB from the .dts.)

The extra information in the absolute path could be useful to a
build engineer, a distro engineer, or a support person for a distro.
Or could just be useless extra info.

> 
> On various machines I have folders called /home/mark/src/linux. These
> are not the same folder. If I gave you a DTB that told you it was from
> /home/mark/src/linux/arch/arm64/boot/dts/vendor/foo.dts, you would have
> difficulty acquiring that precise file.

If you distributed the DTB to me under the gpl v2 then you have also
either distributed the source to me or offered to make it available
to me.

> 
> As far as I can tell, this binding just allows you to place a
> meaningless set of strings in the DTB, that don't actually tell you
> anything useful.
> 
> Mark.
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/329938.html
> [2] https://git.kernel.org/cgit/linux/kernel/git/mark/boot-wrapper-aarch64.git/
> [3] https://git.kernel.org/cgit/linux/kernel/git/mark/boot-wrapper-aarch64.git/commit/?id=e4ae51a1c128ccaac01bdc834692fd15c3a3c8de
> 
