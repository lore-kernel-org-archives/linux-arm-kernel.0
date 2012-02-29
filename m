From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 29 Feb 2012 17:42:29 +0200
Subject: [PATCH v3 00/10] Add tegra30 support for secondary cores
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF178FACB954@HQMAIL01.nvidia.com>
References: <1328831277-21002-1-git-send-email-pdeschrijver@nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF178FACB954@HQMAIL01.nvidia.com>
Message-ID: <20120229154229.GL12917@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2012 at 10:27:43PM +0100, Stephen Warren wrote:
> Peter De Schrijver wrote at Thursday, February 09, 2012 4:48 PM:
> > This patchset introduces support for secondary cores on tegra30. It also
> > introduces some functions for the flowcontroller and adds basic support for
> > tegra30 powerdomains.
> 
> The code looks fine to me. I do notice the following when running
> "shutdown -h now":
> 
> [   27.762124] SMP: failed to stop secondary CPUs
> 
> So, this patch series makes the secondary cores boot OK, but not shut
> down it appears. Is that expected? It's probably something we can fix
> with a following on patch rather than re-spinning this series though?
> 

I spent some more time looking at this. It appears that nr_online_cpus isn't
always updated properly. I added an extra pr_warn() when the failure happens
and I got:

[   22.369815] Restarting system.
[   23.506792] SMP: failed to stop secondary CPUs
[   23.511535] running on CPU: 3, still online: 2, mask: 8

I also did some function tracing and all CPUs besides the one initiating the
halt reach platform_cpu_kill() about 50us after sending the IPIs to stop them.
The set_cpu_online() call in ipi_cpu_stop() should update nr_online_cpus, but
somehow this doesn't always happen. Any insight on what might be going on?

Instrumentation patch attached.

Cheers,

Peter.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-debugging-smp_send_stop.patch
Type: text/x-diff
Size: 1189 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120229/f2ca2d96/attachment.bin>
