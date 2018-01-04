From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 4 Jan 2018 23:27:23 +0000
Subject: [PATCH v3 00/20] arm64: Unmap the kernel whilst running in
 userspace (KPTI)
In-Reply-To: <092a51ec-f856-2b51-5d47-8acbdc671031@gmail.com>
References: <1512563739-25239-1-git-send-email-will.deacon@arm.com>
 <20171211175901.vbw7fpeijpqbp263@armageddon.cambridge.arm.com>
 <6fa84768-7431-22d2-4930-35b0b65ae86f@gmail.com>
 <20180104065018.GA22792@kroah.com>
 <092a51ec-f856-2b51-5d47-8acbdc671031@gmail.com>
Message-ID: <20180104232722.GB17719@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 04, 2018 at 10:23:40AM -0800, Florian Fainelli wrote:
> Great, thanks! Bonus question, if someone is using any of the affected
> devices in AArch32, should we be expecting to see ARM/Linux changes as
> well, that is, is there a plan to come up with a kpti implementation for
> ARM?

Given what little information there is, I've been trying today to see
whether I can detect whether a userspace address is cached or uncached
- the results suggest that I have code that works with an error rate of
between 2 and 20 in 10000 in a 32-bit VM on Cortex A72.  Whether that
translates to Cortex A15, I don't know yet - I need a working Cortex
A15 platform for that.  Unfortunately, my only Cortex A15 platform does
not setup the architected timer, and so the kernel doesn't make it
available to userspace.  I will be raising this with those concerned on
Monday, in the hope of getting it resolved.

Based on this and the information on developer.arm.com, my gut feeling
is that 32-bit kernels running on a CPU with an architected timer _or_
with some other high resolution timer available to non-privileged
userspace are likely to be vulnerable in some way, as it seems to be
possible to measure whether a specific load results in data being
sourced from the cache or from memory.

That all said, what I read about Chrome OS is that google believes
that isn't exploitable - which seems to be a contradiction to the
information ARM have published.  I'm not sure what the reasoning is
there, maybe there's just no current working exploit yet.

So, the message to take away is that 32-bit kernels are rather behind
on this issue, there are no known patches in development, and it is
not really known whether there is an exploitable problem for 32-bit
kernels or not.

Not really where I'd like 32-bit kernels to be.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
