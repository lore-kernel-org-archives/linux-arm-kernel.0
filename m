From: omycle@gmail.com (Li Haifeng)
Date: Thu, 28 Mar 2013 22:00:14 +0800
Subject: [Crash-utility] Throw read error on vmcore produced by ARM soc.
In-Reply-To: <370942491.15862084.1364392897399.JavaMail.root@redhat.com>
References: <CAFNq8R5J1vLgk1s6OEhN_UzYi5dSzX_Pya7gqeM73GagjDbg0g@mail.gmail.com>
 <370942491.15862084.1364392897399.JavaMail.root@redhat.com>
Message-ID: <CAFNq8R7RdY8yiNonCca5Fjt8kzEkwA=T+UG76m-7cRoAMU0e8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/27 Dave Anderson <anderson@redhat.com>:
>
>
> ----- Original Message -----
>> 2013/3/26 Dave Anderson <anderson@redhat.com>:
>> >
>> >
>> > ----- Original Message -----
>> >> Hi, list.
>> >>
>> >> I use crash-utility to analyse crash dump core from ARM soc. When I
>> >> execute command below, I get the error "crash: read error: kernel
>> >> virtual address: c0c1e040  type: "first vmap_area va_start"". I also
>> >> test it by gdb. It works fine. The Linux kernel's version is
>> >> v3.0.8.
>> >>
>> >> hfli at pc1935:~/work/crash-utility$ ./crash vmlinux Vmcore
>> >>
>> >> crash 6.1.4
>> >> Copyright (C) 2002-2013  Red Hat, Inc.
>> >> Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
>> >> Copyright (C) 1999-2006  Hewlett-Packard Co
>> >> Copyright (C) 2005, 2006, 2011, 2012  Fujitsu Limited
>> >> Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
>> >> Copyright (C) 2005, 2011  NEC Corporation
>> >> Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
>> >> Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
>> >> This program is free software, covered by the GNU General Public License,
>> >> and you are welcome to change it and/or distribute copies of it under
>> >> certain conditions.  Enter "help copying" to see the conditions.
>> >> This program has absolutely no warranty.  Enter "help warranty" for
>> >> details.
>> >>
>> >> GNU gdb (GDB) 7.3.1
>> >> Copyright (C) 2011 Free Software Foundation, Inc.
>> >> License GPLv3+: GNU GPL version 3 or later
>> >> <http://gnu.org/licenses/gpl.html>
>> >> This is free software: you are free to change and redistribute it.
>> >> There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
>> >> and "show warranty" for details.
>> >> This GDB was configured as "--host=i686-pc-linux-gnu --target=arm-elf-linux"...
>> >>
>> >> crash: read error: kernel virtual address: c0c1e040  type: "first vmap_area va_start"
>> >>
>> >> Errors like the one above typically occur when the kernel and memory source
>> >> do not match.  These are the files being used:
>> >>
>> >>       KERNEL: vmlinux
>> >>     DUMPFILE: Vmcore
>> >
>> > You've answered your own question -- you should always see errors if the vmlinux
>> > kernel does not match the kernel crashed system.
>> >
>> > If you cannot find/access the original vmlinux file that was being run
>> > by the crashed kernel, then get the /boot/System.map file of the crashed
>> > kernel, and enter it on the command line:
>> Thanks for your reply.
>>
>> The vmlinux, include debug information, and crash kernel, is
>> cross-compile built and produced together. I couldn't understand why
>> crash throw this warning "kernel and source doesn't match".
>>
>> >
>> >  $ crash vmlinux Vmcore System.map
>> >
>> > The crash utility will replace all of the invalid symbol values from the
>> > "wrong" vmlinux file with their correct values from the System.map file.
>>
>>
>> A moment ago. I rebuilt the arm kernel source again. And took "echo c
>> > /proc/sysrq-trigger" command to trigger system panic. The status lists below.
>> hfli at pc1935:~/work/crash-utility$ ./crash vmlinux0327 Vmcore0327
>>
>> crash 6.1.4
>> Copyright (C) 2002-2013  Red Hat, Inc.
>> Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
>> Copyright (C) 1999-2006  Hewlett-Packard Co
>> Copyright (C) 2005, 2006, 2011, 2012  Fujitsu Limited
>> Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
>> Copyright (C) 2005, 2011  NEC Corporation
>> Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
>> Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
>> This program is free software, covered by the GNU General Public License,
>> and you are welcome to change it and/or distribute copies of it under
>> certain conditions.  Enter "help copying" to see the conditions.
>> This program has absolutely no warranty.  Enter "help warranty" for
>> details.
>>
>> GNU gdb (GDB) 7.3.1
>> Copyright (C) 2011 Free Software Foundation, Inc.
>> License GPLv3+: GNU GPL version 3 or later
>> <http://gnu.org/licenses/gpl.html>
>> This is free software: you are free to change and redistribute it.
>> There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
>> and "show warranty" for details.
>> This GDB was configured as "--host=i686-pc-linux-gnu --target=arm-elf-linux"...
>>
>> please wait... (gathering kmem slab cache data)
>> crash: read error: kernel virtual address: c0c91840  type: "kmem_cache buffer"
>>
>> crash: unable to initialize kmem slab cache subsystem
>>
>>
>> WARNING: invalid note (n_type != NT_PRSTATUS)
>>
>> WARNING: could not retrieve crash_notes
>> please wait... (gathering task table data)
>> crash: cannot read pid_hash upid
>>
>> crash: cannot read pid_hash upid
>> please wait... (determining panic task)
>> WARNING: cannot get stackframe for task
>>       KERNEL: vmlinux0327
>>     DUMPFILE: Vmcore0327
>>         CPUS: 1
>>         DATE: Thu Jan  1 08:00:00 1970
>>       UPTIME: 00:00:00
>> LOAD AVERAGE: 0.00, 0.00, 0.00
>>        TASKS: 1
>>     NODENAME: 10.38.50.241
>>      RELEASE: 3.0.8-00010-gb7f16a3-dirty
>>      VERSION: #339 Wed Mar 27 10:39:43 CST 2013
>>      MACHINE: armv7l  (unknown Mhz)
>>       MEMORY: 19 MB
>>        PANIC: ""
>>          PID: 0
>>      COMMAND: "swapper"
>>         TASK: c02e0620  [THREAD_INFO: c02dc000]
>>          CPU: 0
>>        STATE: TASK_RUNNING (ACTIVE)
>>      WARNING: panic task not found
>>
>> crash>
>>
>>
>> It also didn't works so fine. Then I appended system.map, the output
>> result is also the same.
>
> OK, so then it's not clear to me why you're seeing those errors.
>
> Was the dumpfile created using kdump?  It almost looks like the dump
> was taken while the system was still running?  Have you *ever* created
> a dumpfile that resulted in an error-free crash session?

Yes, the dumpfile is created by kdump. The dump was taken by "echo c >
/proc/sysrq-trigger".

I will try another case by inserting a panic module tomorrow.
>
> Perhaps the ARM users on this list have seen this kind of thing?
>
> If you enter "crash -d8 ..." on the command line, you may get a better
> picture of what leads up to the errors shown above, and of most
> interest, the readmem() calls that generate the errors.  If you
> see a "crash: read error: ...", then that means that the dumpfile
> doesn't contain the physical page associated with the virtual
> address shown.  But it's not clear whether the address itself
> is legitimate, i.e., was it gathered from the wrong location.

Sounds reasonable.

>
>>
>> I try GDB to test it.
>> hfli at pc1935:~/work/crash-utility$ ./gdb-7.5/gdb/gdb vmlinux0327
>> Vmcore0327
>> GNU gdb (GDB) 7.5
>> Copyright (C) 2012 Free Software Foundation, Inc.
>> License GPLv3+: GNU GPL version 3 or later
>> <http://gnu.org/licenses/gpl.html>
>> This is free software: you are free to change and redistribute it.
>> There is NO WARRANTY, to the extent permitted by law.  Type "show
>> copying"
>> and "show warranty" for details.
>> This GDB was configured as "--host=x86 --target=arm-linux-gnueabi".
>> For bug reporting instructions, please see:
>> <http://www.gnu.org/software/gdb/bugs/>...
>> Reading symbols from
>> /home/hfli/work/crash-utility/vmlinux0327...done.
>>
>> warning: exec file is newer than core file.
>
> Again, this bothers me -- why is it "newer" than the core file?
> Are you sure that they are *exactly* the same?

I am sure they are *exactly* the same. :-)

I'm not clear the internals of how to judge exec file and core file.

>
>> [New LWP 278]
>> #0  0xc0155f7c in sysrq_handle_crash (key=99) at
>> drivers/tty/sysrq.c:134
>> 134             *killer = 1;
>> (gdb) list
>> 129     {
>> 130             char *killer = NULL;
>> 131
>> 132             panic_on_oops = 1;      /* force panic */
>> 133             wmb();
>> 134             *killer = 1;
>> 135     }
>> 136     static struct sysrq_key_op sysrq_crash_op = {
>> 137             .handler        = sysrq_handle_crash,
>> 138             .help_msg       = "Crash",
>> (gdb)
>>
>> gdb also works fine.
>>
>
> It works fine for gdb in the very limited case above.  The crash utility
> is also "working fine" for a much more expansive access of the dumpfile.
> But if you tried to access the same locations in the dumpfile that the
> crash utility is doing during its initialization, then gdb would also
> fail.
>
> Let's take a simple example -- in your first email, you saw this error:
>
>  crash: read error: kernel virtual address: c0c1e040  type: "first vmap_area va_start"
>
> which came from here:
>
>         if (vt->flags & USE_VMAP_AREA) {
>                 get_symbol_data("vmap_area_list", sizeof(void *), &vmap_area);
>                 if (!vmap_area)
>                         return 0;
>                 if (!readmem(vmap_area - OFFSET(vmap_area_list) +
>                     OFFSET(vmap_area_va_start), KVADDR, &vmalloc_start,
>                     sizeof(void *), "first vmap_area va_start", RETURN_ON_ERROR))
>                         non_matching_kernel();
>
> If I look at a sample ARM dumpfile I have, I see this:
>
>  crash> p vmap_area_list
>  vmap_area_list = $8 = {
>    next = 0xc30d4d78,
>    prev = 0xc06702b8
>  }
>
> where the "next" pointer of 0xc30d4d78 above points to the "list" member
> of a vmap_area structure:
>
>  crash> struct vmap_area
>  struct vmap_area {
>      long unsigned int va_start;
>      long unsigned int va_end;
>      long unsigned int flags;
>      struct rb_node rb_node;
>      struct list_head list;         <== "next" points here
>      struct list_head purge_list;
>      void *private;
>      struct rcu_head rcu_head;
>  }
>  SIZE: 52
>  crash>
>
> And I can dump that vmap_area structure like this:
>
>  crash> struct -x vmap_area -l vmap_area.list 0xc30d4d78
>  struct vmap_area {
>    va_start = 0xbf000000,
>    va_end = 0xbf005000,
>    flags = 0x4,
>    rb_node = {
>      rb_parent_color = 0xc2ca076d,
>      rb_right = 0x0,
>      rb_left = 0x0
>    },
>    list = {
>      next = 0xc2ca0778,
>      prev = 0xc0411ed4
>    },
>    purge_list = {
>      next = 0x0,
>      prev = 0x0
>    },
>    private = 0xc3396860,
>    rcu_head = {
>      next = 0x0,
>      func = 0
>    }
>  }
>
> But your kernel found a "vmap_area_list.next" pointer of c0c1e040,
> but it was not accessible from the dumpfile.
>
> So either:
>
>  (1) the "vmap_area_list" symbol value was not correct, or
>  (2) the page containing the first vmap_area structure was
>      not included in the dumpfile.
>
> Problem (1) can happen if your crashed kernel doesn't match the
> vmlinux file, i.e., the symbol values don't match.  But if the
> "vmap_area_list" symbol was correct, then (2) mush have occurred,
> and that should never happen unless the dumpfile was corrupted or
> was created incorrectly.
>

Agree.

Thanks for your patience again.

For my case, the crashkernel cmdline of crash kernel is
crashkernel=20M at 10M. When the capture kernel launch, the
elfcorehdr=0x1d00000, and the initialization of /proc/vmcore will fail
with WARN_ON(pfn_valid(pfn)) throwing.

The routine is vmcore_init->parse_crash_elf_headers->read_from_oldmem->copy_oldmem_page->ioremap->__arm_ioremap->arch_ioremap_caller->__arm_ioremap_caller->__arm_ioremap_pfn_caller->WARN_ON(pfn_valid(pfn)).

My temporary solution is comment the WARN_ON() to make /proc/vmcore work.

May my comment method corrupt the vmcore?

Thanks.

> Dave
>
> --
> Crash-utility mailing list
> Crash-utility at redhat.com
> https://www.redhat.com/mailman/listinfo/crash-utility
