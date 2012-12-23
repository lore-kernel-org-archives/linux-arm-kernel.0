From: will.deacon@arm.com (Will Deacon)
Date: Sun, 23 Dec 2012 11:06:02 +0000
Subject: [PATCH] kexec: disable non-boot CPUs
In-Reply-To: <50D371E2.1030807@wwwdotorg.org>
References: <1355960681-32015-1-git-send-email-swarren@wwwdotorg.org>
 <20121220104945.GC16887@mudshark.cambridge.arm.com>
 <50D34934.9070106@wwwdotorg.org>
 <20121220173611.GC5387@mudshark.cambridge.arm.com>
 <50D35214.4090008@wwwdotorg.org> <50D371E2.1030807@wwwdotorg.org>
Message-ID: <20121223110602.GA16237@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 20, 2012 at 08:15:30PM +0000, Stephen Warren wrote:
> On 12/20/2012 10:59 AM, Stephen Warren wrote:
> > On 12/20/2012 10:36 AM, Will Deacon wrote:
> >> I think you're better off using what we currently have and hanging your code
> >> off platform_cpu_kill.
> > 
> > OK, I'll look into that. Joseph Lo just posted patches to implement
> > cpu_kill() on Tegra, which was needed to fix some issues in our hotplug
> > code anyway. Perhaps that will remove the need for any other changes...
> 
> Will,

Hi Stephen,

> I just remembered one other advantage of disable_nonboot_cpus(); it
> always makes the kexec happen on the boot CPU. Without this, I believe
> it's random whether CPU0 or CPU1 performs the kexec. I suspect it's most
> likely to work if we can always kexec on the boot CPU rather than a
> random CPU?

It will be the same CPU as the one which made the kexec system call. If you
need to invoke this from a specific CPU, you currently have to do this in
userspace using something like the `taskset' utility. Linux can actually
boot on any physical CPU for ARM now (thanks to the logical map) but most
platforms have restrictions related to secure firmware.

Will
