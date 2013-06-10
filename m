From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 Jun 2013 00:24:41 +0100
Subject: [PATCH] arm: versatile: don't mark pen as __INIT
In-Reply-To: <1370876844-6599-1-git-send-email-mark.rutland@arm.com>
References: <1370876844-6599-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20130610232441.GI18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 04:07:24PM +0100, Mark Rutland wrote:
> When booting fewer cores than are physically present on a versatile
> platform (e.g. when passing maxcpus=N on the command line), some
> secondary cores may remain in the holding pen, which is marked __INIT.
> Late in the boot process, the memory comprising the holding pen will be
> released to the kernel for more general use, and may be overwritten with
> arbitrary data, which can cause the held secondaries to start behaving
> unpredictably. This can lead to all manner of odd behaviour from the
> kernel.
> 
> Instead don't mark the section as __INIT. This means we can't reuse the
> pen memory, but we won't get secondaries corrupting the rest of the
> kernel.

__CPUINIT is appropriate here; __CPUINIT will be kept around if you have
hotplug CPU suport, but if you don't it will be discarded after all
secondary CPUs have booted.  And without hotplug CPU, you can't ask
for the offline CPUs to be onlined.
