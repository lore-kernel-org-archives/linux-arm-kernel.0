From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Feb 2015 16:27:25 +0000
Subject: [PATCH v2] ARM: Don't use complete() during __cpu_die
In-Reply-To: <20150213155208.GG10496@leverpostej>
References: <1423131270-24047-1-git-send-email-k.kozlowski@samsung.com>
 <20150205105035.GL8656@n2100.arm.linux.org.uk>
 <20150205142918.GA10634@linux.vnet.ibm.com>
 <20150205161100.GQ8656@n2100.arm.linux.org.uk>
 <54D95DB8.9010308@codeaurora.org>
 <20150210151416.GD9432@leverpostej>
 <54DA6E92.3090109@codeaurora.org> <54DA725E.6080305@codeaurora.org>
 <20150213155208.GG10496@leverpostej>
Message-ID: <20150213162725.GC8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 13, 2015 at 03:52:08PM +0000, Mark Rutland wrote:
> > @@ -194,10 +195,6 @@ int __cpu_disable(void)
> >  	unsigned int cpu = smp_processor_id();
> >  	int ret;
> >  
> > -	ret = platform_cpu_disable(cpu);
> > -	if (ret)
> > -		return ret;
> 
> For PSCI 0.2+ I was hoping to hook the MIGRATE logic in here. The secure
> side may reject hotplugging of a CPU, but it's a dynamic property of the
> system and so can't be probed once at boot time.

You may have to think about how to deal with the static nature of the
sysfs CPU hotplug properties then - or, you may wish to have the existing
behaviour where we expose the sysfs hotplug properties on all CPUs and
rely on returning -EPERM.

One question does come up - if it's a dynamic property of the system,
what ensures that it can't change between the point when we test it
(in __cpu_disable()) and when we actually come to take the CPU offline?

How does the secure side signal its rejection of hotunplugging of a CPU?
If it happens after __cpu_disable(), then that's a problem: the system
will have gone through all the expensive preparation by that time to
shut the CPU down, and it will expect the CPU to go offline.  The only
way it can come back at that point is by going through a CPU plug-in
cycle... which means going back through secondary_start_kernel.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
