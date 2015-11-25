From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Nov 2015 12:00:13 +0000
Subject: [PATCH] arm64: restore bogomips information in /proc/cpuinfo
In-Reply-To: <56554AE9.5070901@jonmasters.org>
References: <1447870505-19319-1-git-send-email-yang.shi@linaro.org>
 <56554AE9.5070901@jonmasters.org>
Message-ID: <20151125120013.GJ8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 12:45:13AM -0500, Jon Masters wrote:
> On 11/18/15, 1:15 PM, Yang Shi wrote:
> 
> >As what Pavel Machek reported [1], some userspace applications depend on
> >bogomips showed by /proc/cpuinfo.
> >
> >Although there is much less legacy impact on aarch64 than arm, but it does
> >break libvirt.
> >
> >Basically, this patch reverts commit 326b16db9f69fd0d279be873c6c00f88c0a4aad5
> >("arm64: delay: don't bother reporting bogomips in /proc/cpuinfo"), but with
> >some tweak due to context change.
> 
> On a total tangent, it would be ideal to (eventually) have something
> reported in /proc/cpuinfo or dmesg during boot that does "accurately" map
> back to the underlying core frequency (as opposed to the generic timer
> frequency).

Absolutely not.  You need to read the discussion that we had with Linus
when someone reported that ARMs /proc/cpuinfo no longer reported it.

Linus says that Bogomips reports the calibration value for udelay(),
period.  Whether that's a software loop, or a hardware timer is neither
here nor there.  It's nothing to do with the CPU clock rate.

So, if your timer runs slowly, but your CPU is at the top end, a report
of 6 Bogomips is (as far as Linus is concerned) absolutely correct, and
we have no business at all as kernel developers coming up with some fake
or real value to make it report as the CPU clock rate.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
