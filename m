From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 May 2015 09:33:39 +0100
Subject: [PATCH] ARM: socfpga: add smp_ops.cpu_kill to make kexec/kdump
 available
In-Reply-To: <20150529053844.31162.43927.stgit@arietta>
References: <20150529053844.31162.43927.stgit@arietta>
Message-ID: <20150529083339.GG2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 29, 2015 at 02:38:44PM +0900, Hiraku Toyooka wrote:
> Kexec_load syscall in ARM checks that machine-specific code
> has the smp_ops.cpu_kill() before loading kernel image.
> This patch adds the cpu_kill(), as a result, kexec reboot and
> kernel crash dump become available in mach-socfpga.

Please look at the kexec'd kernel's boot messages.  You will probably
notice that the kexec'd kernel is unable to start the secondary CPUs,
and probably causes them to crash.

As socfpga does not appear to be able to do anything with the secondary
CPUs other than park them in a WFI loop in the _existing_ kernel, when
that existing kernel gets overwritten by the kexec kernel and an interrupt
sent to the CPU, that secondary CPU could very well start executing code
it's not meant to.

So no, this is a bad idea.

Unless secondary CPUs can actually be taken offline, features like kexec
can't be supported on the platform.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
