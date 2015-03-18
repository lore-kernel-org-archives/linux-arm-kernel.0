From: tony@atomide.com (Tony Lindgren)
Date: Wed, 18 Mar 2015 09:25:29 -0700
Subject: [PATCH 3/4] ARM: dts: Add cppi41 support for dm816x MUSB
In-Reply-To: <20150318144035.GB1116@saruman.tx.rr.com>
References: <1426637961-4197-1-git-send-email-tony@atomide.com>
 <1426637961-4197-4-git-send-email-tony@atomide.com>
 <20150318003121.GA12911@saruman.tx.rr.com>
 <20150318011836.GK31346@atomide.com>
 <20150318144035.GB1116@saruman.tx.rr.com>
Message-ID: <20150318162528.GO31346@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [150318 07:41]:
> On Tue, Mar 17, 2015 at 06:18:37PM -0700, Tony Lindgren wrote:
> > * Felipe Balbi <balbi@ti.com> [150317 17:32]:
> > > Hi,
> > > 
> > > On Tue, Mar 17, 2015 at 05:19:20PM -0700, Tony Lindgren wrote:
> > > > Looks like we have cppi41 on dm816x just like on am335x.
> > > > 
> > > > Cc: Bin Liu <binmlist@gmail.com>
> > > > Cc: Brian Hutchinson <b.hutchman@gmail.com>
> > > > Cc: Felipe Balbi <balbi@ti.com>
> > > > Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
> > > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > 
> > > Any logs available ? Any throughput improvements with DMA ?
> > 
> > So far I only logged with the debug option on. I can do some
> > test runs with your for-next branch to a USB mass storage device
> > if you prefer that, or got some other test in mind?
> 
> mass storage should be fine, just wanna know if you're getting
> acceptable throughput.

No luck with your current merge branch with DMA right now, it's
producing an error both on bbb and dm816x:

"musb-hdrc musb-hdrc.0.auto: Need DT for the DMA engine." 

So here are some test results against -rc4.

CONFIG_MUSB_PIO_ONLY

Copy a 10MB file to /dev/sda right after a reboot:

# time /bin/sh -c 'cp filler /mnt/ && sync'
real    0m2.480s
user    0m0.000s
sys     0m0.320s

Run hdparm a few times:

# hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:  34 MB in  3.16 seconds =  10.75 MB/sec


CONFIG_USB_TI_CPPI41_DMA

Copy a 10MB file to /dev/sda right after a reboot:

# time /bin/sh -c 'cp filler /mnt/ && sync'
real    0m2.095s
user    0m0.000s
sys     0m0.310s

Run hdparm a few times:

# hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:  52 MB in  3.07 seconds =  16.94 MB/sec

Regards,

Tony
