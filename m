From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 3 Mar 2016 14:42:16 +0000
Subject: ARM64: CPU Hotplug: can't enable more cpus than maxcpus value
 (kernel 4.5)
In-Reply-To: <20160303141752.GA12255@localhost.localdomain>
References: <20160303141752.GA12255@localhost.localdomain>
Message-ID: <20160303144215.GC19139@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2016 at 06:17:52AM -0800, Vadim Lomovtsev wrote:
> Hi all,
> 
> While working with system which has 48 CPUs per one socket it was
> found that it is not possible to enable (turn on) more CPUs than
> 'maxcpus' value. The kernel booted with maxcpus=4 argument:
> 
>     [root at localhost ~]# cat /proc/cmdline
>     BOOT_IMAGE=/boot/Image-4.5-rc5 root=UUID=9cece803-ce48-4b84-ae29-1091591c9edc ro crashkernel=2048M at 0M console=ttyAMA0,115200n8 LANG=en_US.UTF-8 earlycon=pl011,0x87e024000000 debug maxcpus=4
> 
> Check the overall number of CPUs and online CPUs:
> 
>     [root at localhost ~]# cat /sys/devices/system/cpu/possible
>     0-47
>     [root at localhost ~]# cat /sys/devices/system/cpu/online
>     0-3
> 
> Now trying to turn on cpu which is out of scope of initial maxcpus value:
>     [root at localhost ~]# echo 1 >  /sys/devices/system/cpu/cpu4/online
>     -bash: echo: write error: Invalid argument
> 
> Which happens because of cpu_present_mask is set to 0x3 and prevents running more than 'maxcpus' cpus.
>     [root at localhost ~]# cat /sys/devices/system/cpu/present
>         0-3
> 
> For cpu0-3 it works fine:
>     [root at localhost ~]# echo 0 >  /sys/devices/system/cpu/cpu3/online
>     [root at localhost ~]# echo 1 >  /sys/devices/system/cpu/cpu3/online
> 
> At the same time at the Documentation/cpu-hotplug.txt it is described that:
> 
> >    maxcpus=n    Restrict boot time cpus to n. Say if you have 4 cpus, using
> >                 maxcpus=2 will only boot 2. You can choose to bring the
> >                 other cpus later online, read FAQ's for more info.
> 
> and
> 
> >    cpu_present_mask: Bitmap of CPUs currently present in the system. Not all
> >    of them may be online. When physical hotplug is processed by the relevant
> >    subsystem (e.g ACPI) can change and new bit either be added or removed
> >    from the map depending on the event is hot-add/hot-remove. There are currently
> >    no locking rules as of now. Typical usage is to init topology during boot,
> >    at which time hotplug is disabled.
> 
> So after system start, according to docs, it should be possible to run
> more CPUs than 'maxcpus' value and cpu_present_mask should contain
> mask for all CPUs which currently present at the system.
>
> However for arm64 it is implemented that cpu_present_mask is
> explicetely set accordingly to 'maxcpus' value. Is it design intent ?

To some extent, yes.

Due to the possibility of a heterogeneous system, we must bring all CPUs
online at boot time, and cannot defer this.

This is necessary to detect the common subset of supported features, and
also to detect the full set of CPUs in the system to correctly apply
errata workarounds which require kernel text patching. Other things like
CPU-affine device probing (e.g. PMU) also require specific CPUs to be
online.

I don't think we can reliably support maxcpus for the above case.

Thanks,
Mark.
