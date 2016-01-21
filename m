From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 21 Jan 2016 12:02:11 +0000
Subject: [PATCH 18/19] arm64: kdump: update a kernel doc
In-Reply-To: <56A08076.8060302@linaro.org>
References: <20160119014332.GB2919@dhcp-128-65.nay.redhat.com>
 <569DCB30.9010501@linaro.org>
 <20160119122848.GA2904@dhcp-128-65.nay.redhat.com>
 <20160119125114.GH25024@leverpostej>
 <20160119134553.GA2986@dhcp-128-65.nay.redhat.com>
 <20160119140139.GC26545@leverpostej>
 <20160120024946.GA2999@dhcp-128-65.nay.redhat.com>
 <569F2439.9000604@linaro.org> <20160120114929.GB25829@leverpostej>
 <56A08076.8060302@linaro.org>
Message-ID: <20160121120210.GD2581@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2016 at 03:53:42PM +0900, AKASHI Takahiro wrote:
> On 01/20/2016 08:49 PM, Mark Rutland wrote:
> >On Wed, Jan 20, 2016 at 03:07:53PM +0900, AKASHI Takahiro wrote:
> >>On 01/20/2016 11:49 AM, Dave Young wrote:
> >>>On 01/19/16 at 02:01pm, Mark Rutland wrote:
> >>>>On Tue, Jan 19, 2016 at 09:45:53PM +0800, Dave Young wrote:
> >>>>>On 01/19/16 at 12:51pm, Mark Rutland wrote:
> >>>>>>On Tue, Jan 19, 2016 at 08:28:48PM +0800, Dave Young wrote:
> >>>>>>>On 01/19/16 at 02:35pm, AKASHI Takahiro wrote:
> >>>>>>>>On 01/19/2016 10:43 AM, Dave Young wrote:
> >>>>>>>>>X86 takes another way in latest kexec-tools and kexec_file_load, that is
> >>>>>>>>>recreating E820 table and pass it to kexec/kdump kernel, if the entries
> >>>>>>>>>are over E820 limitation then turn to use setup_data list for remain
> >>>>>>>>>entries.
> >>>>>>>>
> >>>>>>>>Thanks. I will visit x86 code again.
> >>>>>>>>
> >>>>>>>>>I think it is X86 specific. Personally I think device tree property is
> >>>>>>>>>better.
> >>>>>>>>
> >>>>>>>>Do you think so?
> >>>>>>>
> >>>>>>>I'm not sure it is the best way. For X86 we run into problem with
> >>>>>>>memmap= design, one example is pci domain X (X>1) need the pci memory
> >>>>>>>ranges being passed to kdump kernel. When we passed reserved ranges in /proc/iomem
> >>>>>>>to 2nd kernel we find that cmdline[] array is not big enough.
> >>>>>>
> >>>>>>I'm not sure how PCI ranges relate to the memory map used for normal
> >>>>>>memory (i.e. RAM), though I'm probably missing some caveat with the way
> >>>>>>ACPI and UEFI describe PCI. Why does memmap= affect PCI memory?
> >>>>>
> >>>>>Here is the old patch which was rejected in kexec-tools:
> >>>>>http://lists.infradead.org/pipermail/kexec/2013-February/007924.html
> >>>>>
> >>>>>>
> >>>>>>If the kernel got the rest of its system topology from DT, the PCI
> >>>>>>regions would be described there.
> >>>>>
> >>>>>Yes, if kdump kernel use same DT as 1st kernel.
> >>>>
> >>>>Other than for testing purposes, I don't see why you'd pass the kdump
> >>>>kernel a DTB inconsistent with that the 1st kernel was passsed (other
> >>>>than some proerties under /chosen).
> >>>>
> >>>>We added /sys/firmware/fdt specifically to allow the kexec tools to get
> >>>>the exact DTB the first kernel used. There's no reason for tools to have
> >>>>to make something up.
> >>>
> >>>Agreed, but kexec-tools has an option to pass in any dtb files. Who knows
> >>>how one will use it unless dropping the option and use /sys/firmware/fdt
> >>>unconditionally.
> >>
> >>As a matter of fact, specifying proper command line parameters as well as
> >>dtb is partly users' responsibility for kdump to work correctly.
> >>(especially for BE kernel)
> >>
> >>>If we choose to implement kexec_file_load only in kernel, the interfaces
> >>>provided are kernel, initrd and cmdline. We can always use same dtb.
> >>
> >>I would say that we can always use the same dtb even with kexec_load
> >>from user's perspective. Right?
> >
> >No.
> >
> >This breaks using kexec for boot-loader purposes, and imposes a policy.
> 
> What kind of policy?
> I said "can", but if we want to use other setting/configuration, we can
> still have a full control.

Apologies, I misunderstood.

In most cases, using the existing DTB (with minor modifications to
/chosen for bootargs and such) is fine. If the user just wants to boot
another Linux kernel, that's generally what they should do.

I think we're agreed on that.

However, there are cases when the user may want to use a different DTB,
or use a different purgatory. So we cannot mandate that the existing DTB
is reused, nor that an in-kernel purgatory must be used, as that imposes
a policy.

> >For better or worse kexec_file_load has always imposed a constrained
> >Linux-only policy, so that's a different story.
> >
> >>>>There's a horrible edge case I've spotted if performing a chain of
> >>>>cross-endian kexecs: LE -> BE -> LE, as the BE kernel would have to
> >>>>respect the EFI memory map so as to avoid corrupting it for the
> >>>>subsequent LE kernel. Other than this I believe everything should just
> >>>>work.
> >>>
> >>>Firmware do not know kernel endianniess, kernel should respect firmware
> >>>maps and adapt to it, it sounds like a generic issue not specfic to kexec.
> >>
> >>On arm64, a kernel image header has a bit field to specify the image's endianness.
> >>Anyway, our current implementation replies on a user-supplied dtb to start BE kernel.
> >
> >The firmware should _never_ care about the kernel's endianness. The
> >bootlaoder or first kernel shouldn't care about the next kernel's
> >endianness apart from in exceptional circumstances. The DTB for a LE
> >kernel should look identical to that passed to a BE kernel.
> 
> Please note that I didn't say anything different from your last two statements.
> The current arm64 kexec implementation doesn't do anything specific to BE,
> but as far as BE kernel doesn't support UEFI, users are responsible for
> providing a proper dtb.

I'm just confused as to what you mean by a "proper dtb" in that case.

If you just mean one with memory nodes hacked in, then that would
currently be a way to make that work, yes.

It seems like the better option is to fix the BE kernel to support a
UEFI memory map, as that solves other issues.

> 
> >In my mind, the only valid reason to look at that bit is so that
> >bootloaders can provide a warning if the CPU does not implement that
> >endianness.
> >
> >The issue I mention above should be solved by changes to the BE kernel.
> >
> >>>>>Is it possible to modify uefi memmap for kdump case?
> >>>>
> >>>>Technically it would be possible, however I don't think it's necessary,
> >>>>and I think it would be disadvantageous to do so.
> >>>>
> >>>>Describing the range(s) the crash kernel can use in separate properties
> >>>>under /chosen has a number of advantages.
> >>>
> >>>Ok, I got the points. We have a is_kdump_kernel() by checking if there is
> >>>elfcorehdr_addr kernel cmdline. This is mainly for some drivers which
> >>>do not work well in kdump kernel some uncertain reasons. But ideally I
> >>>think kernel should handle things just like in 1st kernel and avoid to use
> >>>it.
> >>
> >>So I'm not still sure about what are advantages of a property under /chosen
> >>over "memmap=" kernel parameter.
> >>Both are simple and can have the same effect with minimizing changes to dtb.
> >>(But if, in the latter case, we have to provide *all* the memory-related information
> >>through "memmap=" parameters, it would be much complicated.)
> >
> >The reason I prefer a property over command line additions include:
> 
> Take some examples:
> (a) a property under /chosen
>   {
>     chosen = {
>       cmdline = "elfcorehdr=AA at BB maxcpus=1 ...";
>     }
>     usable-memory = <XX YY>;
>     memory {
>       ...
>     }
>   }
> 
> (b) a kernel command line parameter
>   (I use the same name, "usable-memory", to show the similarity. may use another name though.)
>   {
>     chosen = {
>       cmdline = "elfcorehdr=AA at BB maxcpus=1 usable-memory=YY at XX ...";
>     }
>     memory {
>       ...
>     }
>   }
> 
> >* It keeps the command line simple (as you mention the opposite is
> >   "complicated").
> 
> I think both are simple.
> 
> >* It is logically separate from options the user may pass to the kernel
> >   in that the restricted region(s) of memory avaialble are effectively
> >   properties of the system (in that the crashed OS is part of the system
> >   state).
> 
> "elfcorehdr=" parameter already breaks your point.
> "elfcorehdr=" looks to be, what you say, a system property, and is actually
> added by kexec-tools on all architectures, and "usable-memory", whether it is
> a DT property or a kernel parameter, will also be added by kexec-tools.
> (Users don't have to care.)

Just because architectures do one thing today does not mean that we have
to follow it.

I don't think that breaks my point so much as shows that a different
approach is taken by others today.

There's also no reason this cannot be a property under /chosen.

> >* The semantics of the command line parsing can change subtly over time
> >   (for example, see 51e158c12aca3c9a, which terminates command line
> >   parseing at "--"). Maknig sure that a command line option will
> >   actually be parsed by the next kernel is not trivial.
> >
> >   Keeping this information isolated from the command line is more
> >   robust.
> 
> Even so, who wants to use kdump without testing?
> and this is not a kdump specific issue.
> 
> >* Addition of a property is a self-contained operation, that doesn't
> >   require any knowledge about the command line.
> 
> I don't get your point here.
> For a kernel parameter, early_param() can encapsulate all the stuffs necessary.
> Once the kernel recognizes a usable memory region, limiting available
> memory should be done in the exact same way.

I mean when modifying the command line.

To place "elfcorehdr=" or "memmap="/"usable-memory=" into the command
line, one needs to know where it is valid to place it. Appending doesn't
always work, as per the example above with 51e158c12aca3c9a.

For both of these my point was that generally there is some fragility in
this area. While it's easy to say that breaking this would be someone
else's fault, we can easily avoid the possibility of that happening, and
avoid a set of problems trying to maintain backwards compatibility if
there were a sensible change that happened to break things.

Thanks,
Mark.
