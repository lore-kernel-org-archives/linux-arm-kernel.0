From: bhsharma@redhat.com (Bhupesh Sharma)
Date: Tue, 27 Nov 2018 01:01:49 +0530
Subject: [PATCH v2] x86_64,
 vmcoreinfo: Append 'page_offset_base' to vmcoreinfo
In-Reply-To: <20181126012824.GB1824@MiWiFi-R3L-srv>
References: <1542318469-13699-1-git-send-email-bhsharma@redhat.com>
 <20181126012824.GB1824@MiWiFi-R3L-srv>
Message-ID: <CACi5LpPqdzNxi4=UQqVgT6aCyn9nx+sjM-ds0Xx6qBji_xgP1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2018 at 6:58 AM Baoquan He <bhe@redhat.com> wrote:
>
> On 11/16/18 at 03:17am, Bhupesh Sharma wrote:
> > Adding 'page_offset_base' to the vmcoreinfo can be specially useful for
> > live-debugging of a running kernel via user-space utilities
> > like makedumpfile (see [1]).
> >
> > Recently, I saw an issue with the 'makedumpfile' utility (see [2] for
> > details), whose live debugging feature is broken with newer kernels
>
> I think this paragraph explained why KCORE_REMAP adding caused the
> mistake of page_offset calculation in makedumpfile. It can prove the
> advantage of appending 'page_offset_base' to vmcoreinfo. The old way I
> took in makedumpfile could be impacted by kernel code change, adding it
> to vmcoreinfo can make it stable. The example is KCORE_REMAP adding, and
> later it's removed.
>
> But it's not live debugging feature of makedumpfile. Makedumpfile can't be
> used to live debug. The feature is called '--mem-usage' in makedumpfile,
> in fact it's used to estimate how big the vmcore could be so that customer
> can deply an appropriate size of storage space to store it. Because both
> kcore and vmcore are all elf files which the 1st kernel's memory is
> mapped to, even though they are different, kcore is dynamically changing.
> This is more likely a precision in order of of magnitude. This is a feature
> required by redhat customer.

Indeed this is a live debugging feature - see we are running this in
the primary kernel
context, not in kdump context. We are trying to debug a kernel we are
presently running (in this case determining the page mapping)
hence the term live debugging.

Also, this feature is not limited to redhat - we are talking in
upstream makedumpfile context here - it is used by other projects as
well which can have even a simple busybox rootfs configuration (e.g.
qemu).

> I thought you are talking about using DaveA's crash utility to live
> debug the running kernel, like we usually do with gdb.
>
>         gdb vmlinux /proc/kcore
>
> Yes, this gdb live debugging is broken because of KASLR. We have bug about
> this, while it has not been fixed. Using Crash utility to replace gdb is
> one way if Crash code is adjusted.
>
> > (I tested the same with 4.19-rc8+ kernel), as KCORE_REMAP segments were
> > added to kcore, thus leading to an additional sections in the same, and
> > makedumpfile is not longer able to determine the start of direct
> > mapping of all physical memory, as it relies on traversing the PT_LOAD
> > segments inside kcore and using the last PT_LOAD segment
> > to determine the start of direct mapping.
> ...
> > Testing:
> > -------
>
> This one vmcoreinfo entry adding won't impact kernel performance. And
> page_offset_base need be got during makedumpfile initialization, it
> won't impact makedumpfile efficiency either, especially compared with
> the later page filterring and writting out to storage space. I don't
> think there's any need to provide a detailed test result here. If
> possible, just mention it works in this way, maybe it's better in some
> aspects, such as code simplicity, etc.
>
> >  - I tested this patch (rebased on 'linux-next') on a x86_64 machine
> >    using the modified 'makedumpfile' user-space code (see [3] for my
> >    github tree which contains the same) for determining how many pages
> >    are dumpable when different dump_level is specified (which is
> >    one use-case of live-debugging via 'makedumpfile').
> >  - I tested both the KASLR and non-KASLR boot cases with this patch.
> >  - Here is one sample log (for KASLR boot case) on my x86_64 machine:
> >
> >    < snip..>
> >    The kernel doesn't support mmap(),read() will be used instead.
> >
> >    TYPE               PAGES                   EXCLUDABLE      DESCRIPTION
> >    ----------------------------------------------------------------------
> >    ZERO               21299                   yes             Pages filled
> >    with zero
> >    NON_PRI_CACHE      91785                   yes             Cache
> >    pages without private flag
> >    PRI_CACHE  1                       yes             Cache pages with
> >    private flag
> >    USER               14057                   yes             User process
> >    pages
> >    FREE               740346                  yes             Free pages
> >    KERN_DATA  58152                   no              Dumpable kernel
> >    data
> >
> >    page size:         4096
> >    Total pages on system:     925640
> >    Total size on system:      3791421440       Byte
> >
> ...
>
> > diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> > index 4c8acdfdc5a7..6161d77c5bfb 100644
> > --- a/arch/x86/kernel/machine_kexec_64.c
> > +++ b/arch/x86/kernel/machine_kexec_64.c
> > @@ -356,6 +356,9 @@ void arch_crash_save_vmcoreinfo(void)
> >       VMCOREINFO_SYMBOL(init_top_pgt);
> >       vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
> >                       pgtable_l5_enabled());
> > +#ifdef CONFIG_RANDOMIZE_BASE
>
> Finally, embracing it into CONFIG_RANDOMIZE_BASE ifdefery seems not
> right. The latest kernel is using page_offset_base to do the dynamic
> memory layout between level4 and level5 changing. This may not work in
> 5-level system with CONFIG_RANDOMIZE_BASE=n.

I think you missed the v2 change log and the build-bot error on v1
(see here: <https://patchwork.kernel.org/patch/10657933/#22291691>).
With .config files which have CONFIG_RANDOMIZE_BASE=n, we get the
following compilation error
without the #ifdef jugglery:

 arch/x86/kernel/machine_kexec_64.o: In function `arch_crash_save_vmcoreinfo':
 arch/x86/kernel/machine_kexec_64.c:359: undefined reference to
`page_offset_base'
 arch/x86/kernel/machine_kexec_64.c:359: undefined reference to
`page_offset_base'

Anyways, with Kazu's and Boris's comments on the v2, I understand that
adding 'page_offset_base' variable to vmcoreinfo is useful for x86
kernel.
I will now work on the v3 to take into account review comments and
also work with Lianbo to get the same added to the overall vmcoreinfo
documentation he is preparing for x86.

Thanks,
Bhupesh


> > +     VMCOREINFO_NUMBER(page_offset_base);
> > +#endif
> >
> >  #ifdef CONFIG_NUMA
> >       VMCOREINFO_SYMBOL(node_data);
> > --
> > 2.7.4
> >
