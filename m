From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 Nov 2014 10:55:25 +0000
Subject: [RESEND PATCH] ARM: kexec: Fix validating CPU hotplug support
In-Reply-To: <1415094025-66180-1-git-send-email-hukeping@huawei.com>
References: <1415094025-66180-1-git-send-email-hukeping@huawei.com>
Message-ID: <20141104105525.GE4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 04, 2014 at 05:40:25PM +0800, HuKeping wrote:
> Commit 2103f6cba61a8b8bea3fc1b63661d830a2125e76 added a hotplug checking in
> machine_kexec_prepare(), but it will lead a failure when loading the
> crash-kernel in some cases.
> 
> Kexec utility can load the crash kernel by two ways:
> 1. kexec -l kernel-image
> 2. kexec -p kernel-image
> 
> In case #1, for rapid reboot, it's correct to do the hotplug checking things,
> for it will shut down cpus in _cpu_down() later when command "kexec -e" be
> sent, this routine needs the support of cpu hotplug.
> 
> In case #2, for use on panic, it's unnecessary to do the same thing, the whole
> routing has no business with cpu shutting down. Check for cpu hot plug will
> lead a failure to load the kernel.

So what happens to the other CPUs when you kexec into the new kernel,
possibly overwriting the instructions which those CPUs are executing?

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
