From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Oct 2014 18:16:58 +0100
Subject: ARM: issue with memory reservation from DT
In-Reply-To: <544691A3.9060901@ti.com>
References: <543EAC5A.6050209@ti.com>
 <20141015175025.GJ27405@n2100.arm.linux.org.uk>
 <54400123.7040806@ti.com> <5440FF54.5080905@gmail.com>
 <544691A3.9060901@ti.com>
Message-ID: <20141021171658.GA27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 21, 2014 at 08:02:27PM +0300, Grygorii Strashko wrote:
> Oh. Yes you are right in general - I've just not expected from kernel
> to crash silently, so my intention was to report issue first of all.

The problem here is that each time someone finds a new way to break it,
the code gets more complicated, which means there's yet more ways to
break it.

As an example, try reading through sanity_check_meminfo() and working
out exactly what each variable in there does - it'll take some
considerable time to work it out.  It /used/ to be pretty obvious.

It's pretty scary too that it's walking a list of memblock regions,
while modifying that list, potentially removing the entry that it's
currently at.  I suspect that would cause it to skip a region given
how the for() loop works.

Either way, I think we need to get some of this stuff back to being
coded in a simple and obvious-to-understand manner.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
