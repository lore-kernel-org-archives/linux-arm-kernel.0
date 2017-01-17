From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Jan 2017 23:23:14 +0000
Subject: [PATCH] ARM: smp: Remove CPU: shutdown notice
In-Reply-To: <20170117230714.6799-1-f.fainelli@gmail.com>
References: <20170117230714.6799-1-f.fainelli@gmail.com>
Message-ID: <20170117232314.GI27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 03:07:12PM -0800, Florian Fainelli wrote:
> This message is not particularly informative, and is not paired with an
> identical message when a CPU is brought online. Finally, it slows the
> CPU hotplug path down, thus allowing less CPU hotplug operations per
> second. Just remove it.

CPU hotplug isn't a fast operation anyway - it's also fairly disruptive
in that it uses stop_machine() to halt activity everywhere while taking
the CPU offline.

If you're worried about a single printk slowing things down, it sounds
like you're doing something wrong here - maybe you should be using
cpuidle for power management rather than trying to make CPU hotplug do
that for you?

A rapidly changing CPU hotplug state has other side effects - such as
reading /proc/interrupts is meaningless, because as soon as you've read
it the CPUs could have changed.  It also makes a farce of spreading
interrupts over the available CPUs.

All in all, I don't think this is a good idea...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
