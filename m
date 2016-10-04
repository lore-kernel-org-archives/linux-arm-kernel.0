From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 4 Oct 2016 11:56:58 +0900
Subject: [PATCH v26 0/7] arm64: add kdump support
In-Reply-To: <1ae717d6-b2aa-105b-4f47-d879882ca5d3@caviumnetworks.com>
References: <20160907042908.6232-1-takahiro.akashi@linaro.org>
 <8a57223d-000d-536e-6885-d427ee81508c@caviumnetworks.com>
 <20161003110424.GD14025@linaro.org>
 <1ae717d6-b2aa-105b-4f47-d879882ca5d3@caviumnetworks.com>
Message-ID: <20161004025657.GF14025@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2016 at 06:11:40PM +0530, Manish Jaggi wrote:
> 
> 
> On 10/03/2016 04:34 PM, AKASHI Takahiro wrote:
> > Manish,
> > 
> > On Mon, Oct 03, 2016 at 01:24:34PM +0530, Manish Jaggi wrote:
> >> Hi Akashi,
> >>
> >> On 09/07/2016 09:59 AM, AKASHI Takahiro wrote:
> >>>     v26-specific note: After a comment from Rob[0], an idea of adding
> >>>     "linux,usable-memory-range" was dropped. Instead, an existing
> >>>     "reserved-memory" node will be used to limit usable memory ranges
> >>>     on crash dump kernel.
> >>>     This works not only on UEFI/ACPI systems but also on DT-only systems,
> >>>     but if he really insists on using DT-specific "usable-memory" property,
> >>>     I will post additional patches for kexec-tools. Those would be
> >>>     redundant, though.
> >>>     Even in that case, the kernel will not have to be changed.
> >>>
> >>> This patch series adds kdump support on arm64.
> >>> There are some prerequisite patches [1],[2].
> >>>
> >>> To load a crash-dump kernel to the systems, a series of patches to
> >>> kexec-tools, which have not yet been merged upstream, are needed.
> >>> Please always use my latest kdump patches, v3 [3].
> >>>
> >>> To examine vmcore (/proc/vmcore) on a crash-dump kernel, you can use
> >>>   - crash utility (coming v7.1.6 or later) [4]
> >>>     (Necessary patches have already been queued in the master.)
> >>>
> >>>
> >>> [0] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/452582.html
> >>> [1] "arm64: mark reserved memblock regions explicitly in iomem"
> >>>     http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/450433.html
> >>> [2] "efi: arm64: treat regions with WT/WC set but WB cleared as memory"
> >>>     http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/451491.html
> >>> [3] T.B.D.
> >>> [4] https://github.com/crash-utility/crash.git
> >>>
> >>
> >> With the v26 kdump and v3 kexec-tools and top of tree crash.git, below are the tests done
> >> Attached is a patch in crash.git (symbols.c) to make crash utility work on my setup.
> >> Can you please have a look and provide your comments.
> >>
> >> To generate a panic, i have a kernel module which on init calls panic.
> >>
> >> Observations:
> >> 1.1. Dump capture kernel shows different memory map.
> >> ---------------------------------------------------
> >> In dump capture kernel /proc/meminfo and /proc/iomem differ
> >>
> >> root at arm64:/home/ubuntu/CODE/crash#
> >> MemTotal:       65882432 kB
> >> MemFree:        65507136 kB
> >> MemAvailable:   60373632 kB
> >> Buffers:           29248 kB
> >> Cached:            46720 kB
> >> SwapCached:            0 kB
> >> Active:            63872 kB
> >> Inactive:          19776 kB
> >> Active(anon):       8256 kB
> >> Inactive(anon):     7616 kB
> >>
> >> First kernel is booted with mem=2G crashkernel=1G command line option.
> >> While the system has 64G memory.
> >>
> >> root at arm64:/home/ubuntu/CODE/crash# cat /proc/iomem
> >> 41400000-fffeffff : System RAM
> >>   41480000-420cffff : Kernel code
> >>   42490000-4278ffff : Kernel data
> >> ffff0000-ffffffff : reserved
> >> 100000000-ffaa7ffff : System RAM
> >> ffaa80000-ffaabffff : reserved
> >> ffaac0000-fffa6ffff : System RAM
> >> fffa70000-fffacffff : reserved
> >> fffad0000-fffffffff : System RAM
> > 
> > Are you saying that "mem=..." doesn't have any effect?
> What I am saying it that If the first kernel is booted using mem= option and crashkernel= option
> the memory for second kernel has to be withing the crashkernel size.
> As per /proc/iomem System RAM the information is correct, but the /proc/meminfo is showing total memory
> much more than the first kernel had in first place.
> > What about if you don't specify "crashkernel=...?"
> > 
> In that case the second kernel will not boot as kexec tools will complain that memory not reserved.
> >> 1.2 Live crash dump fails with error
> >> --------------------------------------
> >> $crash vmlinux
> >>
> >> crash 7.1.5++
> >> Copyright (C) 2002-2016  Red Hat, Inc.
> >> Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
> >> Copyright (C) 1999-2006  Hewlett-Packard Co
> >> Copyright (C) 2005, 2006, 2011, 2012  Fujitsu Limited
> >> Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
> >> Copyright (C) 2005, 2011  NEC Corporation
> >> Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
> >> Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
> >> This program is free software, covered by the GNU General Public License,
> >> and you are welcome to change it and/or distribute copies of it under
> >> certain conditions.  Enter "help copying" to see the conditions.
> >> This program has absolutely no warranty.  Enter "help warranty" for details.
> >>
> >> GNU gdb (GDB) 7.6
> >> Copyright (C) 2013 Free Software Foundation, Inc.
> >> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
> >> This is free software: you are free to change and redistribute it.
> >> There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
> >> and "show warranty" for details.
> >> This GDB was configured as "aarch64-unknown-linux-gnu"...
> >>
> >> crash: read error: kernel virtual address: ffff800ffffffcc0  type: "pglist node_id"
> > 
> > I have no ideas here.
> If I run with debug logs phys address accessed is > 64G. (10413ffcc0)
> Could be that somehow 64 + 1G + (addr) = 10413ffcc0 and actually addr was required.
> addr = 413ffcc0 which seems in line with 424b0c50
> 
> 
> Logs:
> <read_dev_mem: addr: ffff0000090b3008 paddr: 424b3008 cnt: 8>
> node_online_map: [1] -> nodes online: 1
> <readmem: ffff0000090b0c50, KVADDR, ""node_data"", 8, (ROE), ffffc330eb00>
> <read_dev_mem: addr: ffff0000090b0c50 paddr: 424b0c50 cnt: 8>
> <readmem: ffff800ffffffcc0, KVADDR, ""pglist node_id"", 4, (FOE), ffffc330f1e4>
> <read_dev_mem: addr: ffff800ffffffcc0 paddr: 10413ffcc0 cnt: 4>
> /dev/mem: Bad address
> crash: read(/dev/mem, 10413ffcc0, 4): 4294967295 (ffffffff)
> crash: read error: kernel virtual address: ffff800ffffffcc0  type: ""pglist node_id""
> "
> > 
> >> Observation 2
> >> ------------
> >> If saved vmcore file is used
> >>
> >> $crash vmlinux vmcore_saved
> >> Got the below error.
> >>
> >> please wait... (gathering module symbol data)crash: malloc.c:2846: mremap_chunk: Assertion `((size + offset) & (_rtld_global_ro._dl_pagesize - 1)) == 0' failed.
> >> Aborted
> > 
> > I have no ideas here.
> > 
> >> Experiment 3
> >> ------------
> >> If crash.git is modified with a hack patch in symbols.c. Crash utility works fine log, bt commands work.
> > 
> > In which case, "crash vmlinux" or "crash vmlinux vmcore_saved?"
> > 
> vmcore_saved
> > I was able to reproduce this issue in the latter case
> > (but with a different error message).
> > It seems to be a crash util's bug.
> > Please report it to crash-util mailing list.
> > I will post a patch.
> The same patch as below ?

No.

> Can you please share your patch

I submitted a bug fix patch. See:
https://www.redhat.com/archives/crash-utility/2016-October/msg00000.html

-Takahiro AKASHI

> > Thanks,
> > -Takahiro AKASHI
> > 
> >> -------------------
> >> Patch: symbols.c
> >> git diff symbols.c
> >> diff --git a/symbols.c b/symbols.c
> >> index 13282f4..f7c6cac 100644
> >> --- a/symbols.c
> >> +++ b/symbols.c
> >> @@ -2160,6 +2160,7 @@ store_module_kallsyms_v2(struct load_module *lm, int start
> >>                  FREEBUF(module_buf);
> >>                  return 0;
> >>          }
> >> +       lm->mod_init_size = 0;
> >>
> >>         if (lm->mod_init_size > 0) {
> >>                 module_buf_init = GETBUF(lm->mod_init_size);
> >> ------------------
> >>
> >> $ crash vmlinux vmcore_saved
> >>     KERNEL: /home/ubuntu/CODE/linux/vmlinux
> >>     DUMPFILE: vm
> >>         CPUS: 48 [OFFLINE: 46]
> >>         DATE: Mon Oct  3 00:11:47 2016
> >>       UPTIME: 00:02:41
> >> LOAD AVERAGE: 0.36, 0.14, 0.05
> >>        TASKS: 171
> >>     NODENAME: arm64
> >>      RELEASE: 4.8.0-rc3-00044-g070a615-dirty
> >>      VERSION: #63 SMP Sat Oct 1 01:39:45 PDT 2016
> >>      MACHINE: aarch64  (unknown Mhz)
> >>       MEMORY: 2 GB
> >>        PANIC: "Kernel panic - not syncing: crash module starting"
> >>          PID: 958
> >>      COMMAND: "insmod"
> >>         TASK: ffff800007859300  [THREAD_INFO: ffff80000c940000]
> >>          CPU: 0
> >>        STATE: TASK_RUNNING (PANIC)
> >>
> >> crash> bt
> >> PID: 958    TASK: ffff800007859300  CPU: 0   COMMAND: "insmod"
> >>  #0 [ffff80000c943980] __crash_kexec at ffff000008144fe8
> >>  #1 [ffff80000c943ae0] panic at ffff0000081ae704
> >>  #2 [ffff80000c943ba0] init_module at ffff000000900014 [crash]
> >>  #3 [ffff80000c943bb0] do_one_initcall at ffff000008083bb4
> >>  #4 [ffff80000c943c40] do_init_module at ffff0000081af6f0
> >>  #5 [ffff80000c943c70] load_module at ffff000008140b7c
> >>  #6 [ffff80000c943e10] sys_finit_module at ffff000008141634
> >>  #7 [ffff80000c943ed0] el0_svc_naked at ffff0000080833ec
> >>      PC: 00000003  LR: ffffaca050a0  SP: ffffaca865a0  PSTATE: 00000111
> >>     X12: ffffac941a5c X11: 00000080 X10: 00000004  X9: 00000030
> >>      X8: ffffffff  X7: fefefefefefeff40  X6: 00000111  X5: 00000001
> >>      X4: 00000001  X3: 0002ed61  X2: 00000000  X1: 00000003
> >>      X0: 00000000
> >> crash>
> >>
> >>
> >> ---
> >> Thanks,
> >> manish
> >>
