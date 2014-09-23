From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Sep 2014 10:37:51 +0100
Subject: unalignment access to device / strongly ordered memory
In-Reply-To: <35FD53F367049845BC99AC72306C23D103D6DB491629@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D103D6DB491629@CNBJMBX05.corpusers.net>
Message-ID: <20140923093751.GP5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 23, 2014 at 01:25:17PM +0800, Wang, Yalin wrote:
> Hi 
> 
> I have a question about
> unalignment access to device / strongly ordered memory.
> The TRM said that :
> 
> Unaligned data accesson page A3-108identifies the instructions that can make an unaligned memory 
> access, and the required configuration setting. If such an access is to Device or Strongly-ordered memory 
> then:
> - if the implementation does not include the Virtualization Extensions, the effect is UNPREDICTABLE
> - if the implementation includes the Virtualization Extensions, the access generates an Alignment fault.
> 
> 
> But I see arch\arm\mm\alignment.c,
> It don't check if the fault address is a device / strongly ordered memory
> address.

Doing so is too expensive.

> Is it safe ?

Yes - if you use misaligned accesses to a device or strongly ordered
region, you will get unpredictable results.  If it triggers an alignment
fault, we will fix up the load by performing multiple accesses to the
address and combining their results.

If reading or writing to the region has side effects (maybe the device is
read sensitive) maybe it won't like the multiple reads - that's not the
problem of the OS to resolve.  That still comes under "unpredictable".

Hence, whether or not you have virtualisation extensions, the result of
performing an unaligned access will be UNPREDICTABLE.

> Do we need check it and then panic kernel or kill the user process

How would we do that when non-virtualised cases may not produce an
exception?

The bottom line on this is quite simply: never generate misaligned loads
and stores to devices.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
