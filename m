From: robherring2@gmail.com (Rob Herring)
Date: Mon, 18 Jun 2012 09:39:33 -0500
Subject: [PATCH] ARM:Orion5x: Fix panic at boot for PCI IO reservation
In-Reply-To: <20120618141901.GQ4799@lunn.ch>
References: <1340006794-18097-1-git-send-email-andrew@lunn.ch>
 <20120618141901.GQ4799@lunn.ch>
Message-ID: <4FDF3DA5.4030602@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2012 09:19 AM, Andrew Lunn wrote:
> On Mon, Jun 18, 2012 at 10:06:34AM +0200, Andrew Lunn wrote:
>> Orion5x, and all other orion based systems have a PCI(E) IO window
>> size of 1Mbyte. Recent changes to mach/io.h mean that by default the
>> kernel does not allow such large windows, it refuses to reserve that
>> much resource space, triggering a panic.
>>
>> Reduce the PCI(E) IO window size to the normal 64K.
> 
> It turns out this patch does not work...
> 
> There are two PCI devices on Orion5x. So the first one takes all the
> available 64K IO space and the second one fails it allocation.
> 
> We need to put back parts of mach/io.h to increase the available size to
> 128Kbytes.
> 
> It has been said in another email, the plan is to put the IO window at
> one fixed address. How will this work for devices with multiple PCI
> busses? Most Orion chips for have two separate PCI busses.

It supports up to 16 64K windows mapped into a 1MB area. So
IO_RESOURCE_LIMIT will be 1MB in that case.

If the h/w can support i/o at 0, then it would be good make __io(x) be
the form of ((x) + <host phys base>). Unfortunately, it seems the only
way to figure this out is change it and see if it breaks people which
isn't very nice.

Rob
