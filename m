From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 May 2013 11:27:00 +0100
Subject: [PATCH 0/6] ARM: tegra114: add CPU hotplug support
In-Reply-To: <51952344.1090003@wwwdotorg.org>
References: <1368613644-11863-1-git-send-email-josephl@nvidia.com>
 <51941C58.9060002@wwwdotorg.org>
 <1368698019.7403.10.camel@jlo-ubuntu-64.nvidia.com>
 <51952344.1090003@wwwdotorg.org>
Message-ID: <20130517102700.GD18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 12:19:48PM -0600, Stephen Warren wrote:
> Is there a specific reason for that; is there some problem in the core
> ARM code that implies CPU0 should never be disabled?

No.  This is the code I removed:

-int tegra_cpu_disable(unsigned int cpu)
-{
-       /*
-        * we don't allow CPU 0 to be shutdown (it is still too special
-        * e.g. clock tick interrupts)
-        */
-       return cpu == 0 ? -EPERM : 0;
-}

This gets called from here:

static int platform_cpu_disable(unsigned int cpu)
{
        if (smp_ops.cpu_disable)
                return smp_ops.cpu_disable(cpu);

        /*
         * By default, allow disabling all CPUs except the first one,
         * since this is special on a lot of platforms, e.g. because
         * of clock tick interrupts.
         */
        return cpu == 0 ? -EPERM : 0;
}

Notice the useless utterly nature of tegra_cpu_disable() given that it's
doing _precisely_ the same thing as the common code.  It might as well
not even exist - and it doesn't for that very reason.  Never provide
implementations for methods which are copies of the default action if
no method is provided.
