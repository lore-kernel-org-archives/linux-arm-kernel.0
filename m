From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Jan 2018 20:20:53 +0000
Subject: [PATCH] arm64: Stop printing the virtual memory layout
In-Reply-To: <94d6b5c8-07c4-32b5-9746-646b0021d2e9@gmail.com>
References: <20171219192810.22537-1-labbott@redhat.com>
 <94d6b5c8-07c4-32b5-9746-646b0021d2e9@gmail.com>
Message-ID: <20180118202053.GR17719@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 18, 2018 at 12:01:31PM -0800, Florian Fainelli wrote:
> On 12/19/2017 11:28 AM, Laura Abbott wrote:
> > Printing kernel addresses should be done in limited circumstances, mostly
> > for debugging purposes. Printing out the virtual memory layout at every
> > kernel bootup doesn't really fall into this category so delete the prints.
> > There are other ways to get the same information.
> 
> This really has some value when debugging systems, could we possibly
> just hide that behind an appropriate configuration option instead of
> completely removing this?

I've already ended up having to revert the vsprintf() change nobbling
%p for that very reason when debugging the BPF code.  It's easier to
do that while debugging than remember about the %px thing - and lets
face it, probably less error prone if it leaks out.

Otherwise we'll just end up with everyone spelling %p as %px in their
debug statements... or using %lx and casting to unsigned long.

So yes, I do think a Kconfig option (defaulting to obscuring kernel
addresses of course) would have been very sensible for this.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
