From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 17 Oct 2012 11:20:15 +0100
Subject: [RFC PATCH] ARM: kernel: update cpuinfo to print all online CPUs
 features
In-Reply-To: <20121016214752.GH21164@n2100.arm.linux.org.uk>
References: <1350404684-6883-1-git-send-email-lorenzo.pieralisi@arm.com>
 <507DA08B.502@ti.com>
 <20121016214752.GH21164@n2100.arm.linux.org.uk>
Message-ID: <20121017102015.GA13189@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2012 at 10:47:52PM +0100, Russell King - ARM Linux wrote:
> On Tue, Oct 16, 2012 at 11:29:39PM +0530, Santosh Shilimkar wrote:
> > Not exactly related to the $subject patch, but I remember doing a patch
> > to have cat /proc/cpuinfo spitting only online CPUs just like x86 using
> > for_each_online_cpu(i).
> > At that point Russell mentioned about a possibility of read() syscall
> > spreading over the hot-plug operation and hence the above may not
> > be safe.
> >
> > is that right Russell ?
> 
> That is correct, but you will notice that the code now uses the online
> cpus rather than the present, inspite of my objections.  I gave up
> fighting the case, so now people get to live with the consequences of
> this.
> 
> This will be fun with dynamic hotplugging with big.LITTLE when people
> come to read any of these files which change their output with the
> online CPUs.  Oh what fun we're in for there.

I had a look at how glibc currently detects cpus in __get_nprocs() and all
methods end up relying on online CPUs:

- /sys/devices/system/cpu/online
- /proc/stat
- /proc/cpuinfo

Given the thread:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/054081.html

I do not think there is room to change the current behaviour of /proc/cpuinfo
as far as the online vs. present argument goes, and I certainly did not try.

I posted this code just to understand if it makes sense to expose all CPU ids
in /proc/cpuinfo the way I did (the same way x86 does, even though the code is
slightly different).

> I guess the only way to convince people is to let them make their
> mistakes in the kernel.

That's what I wanted to prevent by posting this code, namely getting
feedback on the best way to improve /proc/cpuinfo for systems where CPU
ids are not homogeneous.

The "online vs. present" issue is already there as Russell pointed out.

Thank you very much for the review, any further feedback appreciated.

Lorenzo
