From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 18 Jul 2013 17:37:27 +0200
Subject: Audio issue on Kirkwood t5325: no sound
In-Reply-To: <20130718142009.GX24642@n2100.arm.linux.org.uk>
References: <20130718134330.5aea00c5@skate>
 <20130718142009.GX24642@n2100.arm.linux.org.uk>
Message-ID: <20130718173727.2cfa38d3@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Thanks for your feedback!

On Thu, 18 Jul 2013 15:20:09 +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 18, 2013 at 01:43:30PM +0200, Thomas Petazzoni wrote:
> > As part of some work around audio support on Marvell platforms, I've
> > taken the Kirkwood-based HP t5325 thin client device that Martin
> > Michlmayr kindly gave me and tried to use the audio part of it, with
> > kernel 3.11-rc1. (My plan is to write the Device Tree binding for
> > this audio driver, and then use it for Armada 370 based platforms).
> 
> A couple of basic things to check:
> 
> 1. /proc/asound/card0/pcm0p/sub0/status
> 
> Does this indicate that the hw_ptr and appl_ptr are updating ?

Yes, it does:

# cat status 
state: RUNNING
owner_pid   : 720
trigger_time: 170.971641590
tstamp      : 172.468710470
delay       : 32224
avail       : 544
avail_max   : 28672
-----
hw_ptr      : 66080
appl_ptr    : 98304
# cat status 
state: RUNNING
owner_pid   : 720
trigger_time: 170.971641590
tstamp      : 173.042343190
delay       : 31520
avail       : 1248
avail_max   : 4096
-----
hw_ptr      : 91360
appl_ptr    : 122880

> 2. /proc/interrupts
> 
> Are you getting interrupts for kirkwood-i2s ?

Yes, I am:

# cat /proc/interrupts 
           CPU0       
 ...
 24:        109  orion_irq  kirkwood-i2s
 ...
# cat /proc/interrupts 
           CPU0       
 ...
 24:        116  orion_irq  kirkwood-i2s
 ...

> That will confirm whether the I2S unit is reading data from the ring
> buffer.  I suspect these will be a positive yes, given that aplay
> appears to work normally except being muted.

Your suspicion was indeed correct. Seems like the audio samples are
really being played.

> Another thing to check is the DAPM status, which you can find buried
> in /sys/kernel/debug/asoc - check all the DAPM status you can find
> below there, and check whether you think it's reasonable.

# for i in /sys/kernel/debug/asoc/t5325/dapm/* ; do echo $i ; cat "$i" ; done
/sys/kernel/debug/asoc/t5325/dapm/Headphone Jack
Headphone Jack: Off  in 2 out 1
 in  "static" "HPR"
 in  "static" "HPL"
/sys/kernel/debug/asoc/t5325/dapm/Mic Jack
Mic Jack: Off  in 1 out 0
 out "static" "MIC2"
 out "static" "MIC1"
/sys/kernel/debug/asoc/t5325/dapm/Speaker
Speaker: Off  in 2 out 1
 in  "static" "SPKOUTN"
 in  "static" "SPKOUT"
/sys/kernel/debug/asoc/t5325/dapm/bias_level
Off

I don't see anything that looks unreasonable in there, but I've never
played with DAPM and related things, so it is very possible that my
reasonable-guesser might be wrong on this.

Thoughts?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
