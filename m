From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 May 2013 11:23:45 +0100
Subject: [PATCH 0/6] ARM: tegra114: add CPU hotplug support
In-Reply-To: <1368698019.7403.10.camel@jlo-ubuntu-64.nvidia.com>
References: <1368613644-11863-1-git-send-email-josephl@nvidia.com>
 <51941C58.9060002@wwwdotorg.org>
 <1368698019.7403.10.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <20130517102345.GC18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 05:53:39PM +0800, Joseph Lo wrote:
> On Thu, 2013-05-16 at 07:38 +0800, Stephen Warren wrote:
> > This series mostly works OK, but I see one problem: I can't hotunplug
> > CPU0, which the commit descriptions and code changes imply I should be
> > able to do:
> > 
> > root at localhost:~# echo 0 > /sys/devices/system/cpu/cpu0/online
> > -bash: echo: write error: Operation not permitted
> 
> I want to provide this function originally. But I found the
> tegra_cpu_disable() was removed recently. It was replaced by the common
> cpu_disable() function that didn't allow CPU0 to be un-plugged.

It got removed for the simple reason that the implementation of that
function was exactly the same as the default path in cpu_disable().
If you have a need to do something else other than the default, then
provide the function (and *only* provide it if you need to do something
different.)

However, if the default suffices, do not provide extra code even if you
later intend to change the function.  Only add the function when you
need to do something else.

I see too much of this "I'll add this function just becase, and maybe
I'll change it later" crap getting into the kernel; this needs to stop.
Things like providing an empty function for every single method in a
struct even through the behaviour would be to do nothing had that
function not been provided.  So whenever I see this, I remove the
offending functions if I'm touching that code.
