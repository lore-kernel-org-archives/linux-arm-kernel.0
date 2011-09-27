From: tim.bird@am.sony.com (Tim Bird)
Date: Tue, 27 Sep 2011 10:56:29 -0700
Subject: [RFC PATCH 0/3] Add accurate boot timing to a Linux system
In-Reply-To: <1316818998-30711-1-git-send-email-sjg@chromium.org>
References: <1316818998-30711-1-git-send-email-sjg@chromium.org>
Message-ID: <4E820E4D.5050205@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23/2011 04:03 PM, Simon Glass wrote:
> This experimental patch set adds boot timing to a Linux system. The
> timing starts with the boot loader and extends through the kernel into
> user space to the completion of the boot process. The timing starts when
> the system leaves reset, not later when the kernel starts.

I would be very interested in this.  This is something that
would be very helpful, I believe, to assist with optimizing
overall boot time.

> Finally, in user space there is no kernel-blessed way to record
> timestamps. One approach is to add lines to the init scripts like
> 'cat /proc/uptime >/tmp/login_starts'.
> This creates another place where
> the boot timing tool must look for information.

'cat /proc/uptime >/dev/kmsg' (with printk timestamps on) is much
better than the above, for this reason.

> This Patchset
> -------------
> This patchset aims to unify timing in one place: a simple driver which
> collects pre-kernel boot timestamps, adds its own as it boots, with
> calls to bootstage_mark(), then allows user space (init, etc.) to add
> more with 'echo "message" >>/sys/kernel/debug/bootstage/mask'.
>
> Finally it permits user space to access the full list of timestamps
> with 'cat /sys/kernel/debug/bootstage/report', which has two columns:
> the stage name and the timestamp:
>
> 	reset	0
> 	arch_cpu_init-AVP	258902
> 	arch_cpu_init-A9	263267
> 	arch_cpu_init-done	263312
> 	board_init_f-start	263314
> 	board_init_r-start	323671
> 	main_loop	573008
...

I would prefer the timestamp in the first column.  Also, for consistency
it would be good if it used the same format as printk timestamps:
"[%5lu.%06lu]" with seconds and micro-seconds in the respective fields.
Then, existing tools like scripts/show_delta and scripts/bootgraph.pl
could work on this data as well.

Full micro-second granularity is not required, but it's nice to keep
the format the same, whether the clock supports it or not.

Finally, is this work related at all to this:
http://lists.denx.de/pipermail/u-boot/2011-September/099996.html
Bootgraph.pl instrumentation support for UBoot
??

Just wondering.

Thanks - this looks like great stuff!
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Workgroup of the Linux Foundation
Senior Staff Engineer, Sony Network Entertainment
=============================
