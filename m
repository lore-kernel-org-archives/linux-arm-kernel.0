From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Feb 2015 17:30:00 +0000
Subject: [PATCH v2] ARM: Don't use complete() during __cpu_die
In-Reply-To: <20150213172141.GF2529@leverpostej>
References: <20150205105035.GL8656@n2100.arm.linux.org.uk>
 <20150205142918.GA10634@linux.vnet.ibm.com>
 <20150205161100.GQ8656@n2100.arm.linux.org.uk>
 <54D95DB8.9010308@codeaurora.org>
 <20150210151416.GD9432@leverpostej>
 <54DA6E92.3090109@codeaurora.org> <54DA725E.6080305@codeaurora.org>
 <20150213155208.GG10496@leverpostej>
 <20150213162725.GC8656@n2100.arm.linux.org.uk>
 <20150213172141.GF2529@leverpostej>
Message-ID: <20150213173000.GD8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 13, 2015 at 05:21:41PM +0000, Mark Rutland wrote:
> On Fri, Feb 13, 2015 at 04:27:25PM +0000, Russell King - ARM Linux wrote:
> > If it happens after __cpu_disable(), then that's a problem: the system
> > will have gone through all the expensive preparation by that time to
> > shut the CPU down, and it will expect the CPU to go offline.  The only
> > way it can come back at that point is by going through a CPU plug-in
> > cycle... which means going back through secondary_start_kernel.
> 
> This would happen within __cpu_disable, as the current
> platform_cpu_disable() call does, before it's too late to abort the
> hotplug.

Okay, in which case it all sounds fine, but what it does mean is that
we can't merge Stephen's patch since we have no real idea which cores
can be hotplugged.

I'd rather not add additional complexity when we know that it's not
going to work very well...

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
