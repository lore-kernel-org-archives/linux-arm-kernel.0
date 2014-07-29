From: tony@atomide.com (Tony Lindgren)
Date: Tue, 29 Jul 2014 01:49:31 -0700
Subject: OMAP baseline test results for v3.16-rc4
In-Reply-To: <alpine.DEB.2.02.1407290810160.22957@utopia.booyaka.com>
References: <alpine.DEB.2.02.1407062339420.15016@utopia.booyaka.com>
 <20140707080238.GF28884@atomide.com>
 <alpine.DEB.2.02.1407251857480.5875@utopia.booyaka.com>
 <20140729064243.GF29045@atomide.com>
 <alpine.DEB.2.02.1407290810160.22957@utopia.booyaka.com>
Message-ID: <20140729084930.GH29045@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [140729 01:27]:
> On Mon, 28 Jul 2014, Tony Lindgren wrote:
> 
> > Hmm I think the difference with the working v3.10 one is that you have
> > root=/dev/mmcblk0p2 instead of root=/dev/nfs. As the Ethernet on beagle
> > is on the USB EHCI, this is still blocking the deeper idle states AFAIK.
> 
> Hmm?  There's no Ethernet on the 3530 Beagle.
> 
> The hardware configuration on those two boards - the 37xxevm and 
> the 3530es3beagle - hasn't changed between the two test runs, AFAIK.

Oh it's the original beagle, sorry. In that case the uart wake interrupts
need to be enabled for the serial wake to work. I did not do that as
I don't have one. I guess that might explain why it fails? Or are you
using RTC wake for your test?

> Just to take the Beagle out of the equation, here's a test with the 
> 37xxevm on 3.11 where it passes the dynamic idle tests:
> 
> http://www.pwsan.com/omap/testlogs/test_v3.11/20130902150604/pm/37xxevm/37xxevm_log.txt
> 
> And here's one on the 37xxevm on 3.16-rc7 where it fails:
> 
> http://www.pwsan.com/omap/testlogs/test_v3.11/20130902150604/pm/37xxevm/37xxevm_log.txt

Wrong link here :) It should be:

http://www.pwsan.com/omap/testlogs/test_v3.16-rc7/20140727174803/pm/37xxevm/37xxevm_log.txt
 
> I should probably read back those writes to autosuspend_delay_ms, just to 
> make sure they are reaching the right destinations.  But you might want to 
> confirm that you can see the CORE RET count increasing during dynamic idle 
> on your 37xxevm.

Hmm seems to work on 37xxevm for me with my retention test script:

uarts=$(find /sys/class/tty/ttyO*/device/power/ -type d)
for uart in $uarts; do
        echo 3000 > $uart/autosuspend_delay_ms
done

uarts=$(find /sys/class/tty/ttyO*/power/ -type d)
for uart in $uarts; do
        echo enabled > $uart/wakeup
        echo auto > $uart/control
done

echo 0 > /sys/kernel/debug/pm_debug/enable_off_mode

Which produces:

core_pwrdm (ON),OFF:0,RET:7,INA:0,ON:8,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0

And then setting enable_off_mode:

core_pwrdm (ON),OFF:15,RET:100,INA:8,ON:124,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0

And I'm using UART3 like I mentioned earlier, but I doubt that
makes a difference.

Are you maybe missing "echo auto > $uart/control"?

Regards,

Tony
