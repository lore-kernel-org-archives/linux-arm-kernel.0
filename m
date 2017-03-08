From: bishah@cisco.com (Bijal Shah (bishah))
Date: Wed, 8 Mar 2017 18:33:48 +0000
Subject: L2 cache management question
In-Reply-To: <20170308180745.GY21222@n2100.armlinux.org.uk>
References: <bdcc07da22ae43589768d6d4aebbf788@XCH-RTP-013.cisco.com>
 <20170308180745.GY21222@n2100.armlinux.org.uk>
Message-ID: <6008d9f6f08d46458e106a4ae794ca0b@XCH-RTP-013.cisco.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks. We're working on measurements and will report back when we have data that can be interpreted more widely. At the moment, we're seeing a headline loss of between 2 and 5% of CPU due to the flushes in the application we have, which seems like a lot.

Your explanation makes sense, and we wouldn't want to bork the general case for this application. My observation boils down to the choice on flushing the entire cache is based on the range size rather than whether the anything in the range has been cached which surprised me a bit. I guess that check would be time consuming in itself though.

-----Original Message-----
From: linux-arm-kernel [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of Russell King - ARM Linux
Sent: 08 March 2017 18:08
To: Bijal Shah (bishah) <bishah@cisco.com>
Cc: linux-arm-kernel at lists.infradead.org
Subject: Re: L2 cache management question

On Wed, Mar 08, 2017 at 11:44:12AM +0000, Bijal Shah (bishah) wrote:
> Looking at l2x0_cache.c file in the arch/arm/mm directory, I see a 
> common pattern for an address range flush where if the address range 
> is larger than the cache size, a flush_all is called almost without 
> question. Is there any specific reason for this? Asking for the 
> project I'm working on, as the address ranges may contain very few if 
> any dirty lines, and a flush_all is expensive and locks out other CPUs 
> while it is going on.

Flushing by cache line for large address ranges is also very expensive.
As with everything like this, the threshold is a balance between the relative expenses of the alternatives.

We're not going to change the threshold without a fully justified reason to change it - which implies that performance measurements are needed to back up any case.

As it'll be workload specific, so picking one particular workload that justifies a spefific case won't be all that persuasive - we optimise for the general case and _maybe_ if there's good reason provide a tuning knob to allow the threshold to be adjusted.

--
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up according to speedtest.net.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
