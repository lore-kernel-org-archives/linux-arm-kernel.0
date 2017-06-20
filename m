From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Jun 2017 23:38:59 +0100
Subject: [PATCH 00/51] rtc: stop using rtc deprecated functions
In-Reply-To: <alpine.DEB.2.20.1706202343120.2157@nanos>
References: <20170620213507.urobmtg34vzubrdq@piout.net>
 <alpine.DEB.2.20.1706202343120.2157@nanos>
Message-ID: <20170620223859.GO4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 12:00:30AM +0200, Thomas Gleixner wrote:
> Yes, but there are still quite some issues to solve there:
> 
>      1) How do you tell the system that it should apply the offset in the
>      	first place, i.e at boot time before NTP or any other mechanism can
>      	correct it?
> 
>      2) Deal with creative vendors who have their own idea about the 'start
>      	of the epoch'
> 	
>      3) Add the information of wraparound time to the rtc device which
>      	needs to be filled in for each device. That way the rtc_***
>      	accessor functions can deal with them whether they wrap in 2038 or
>      	2100 or whatever.
> 
> #3 is the simplest problem of them :)	

Well, if there's additional non-volatile storage, you can store
additional information in there, but you still need the RTC
subsystem to be aware that the hardware is only 32-bit capable.

You'd also still need something along the lines I detailed
(redefining what dates the past 32-bit values indicate) to cope
with the RTC being set backwards after the machine thinks (possibly
incorrectly) that the date has jumped forwards.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
