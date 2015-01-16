From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 16 Jan 2015 16:55:53 +0100
Subject: [PATCHv3 0/2] Driver for TI tlc59116 16 Channel i2c LED driver
In-Reply-To: <54B9259C.3070403@ti.com>
References: <1421277308-3477-1-git-send-email-andrew@lunn.ch>
 <54B9259C.3070403@ti.com>
Message-ID: <20150116155553.GC17658@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 04:52:12PM +0200, Tomi Valkeinen wrote:
> Hi,
> 
> On 15/01/15 01:15, Andrew Lunn wrote:
> > This patchset is a driver for the TI tlc59116 16 Channel i2c LED
> > driver. This driver is used on the Belkin WRT1900AC access point and
> > the C code is derived from code Belkin contributed to OpenWRT.
> > However it has been extensively re-written, and a device tree binding
> > added to replace platform data.
> 
> We have a TLC59108 on one of our boards, and with a quick glance it
> looks about the same as TLC59116, except the amount of outputs. Vignesh
> wrote a driver for it and was about to send it for review.
> 
> However, Vignesh implemented it as a PWM driver. We use it for LCD
> backlight (via pwm-backlight).
> 
> I'm not very familiar with LED and PWM drivers, but doesn't implementing
> this as a LED driver prevent us from using it as a backlight? Whereas it
> looks like PWM can be used as a led via pwm-leds (I think).
> 
Hi Tomi

I've no idea about backlighting....

But the driver does fully implement brightness. So on my board:

echo 128 > /sys/class/leds/wrt1900ac\:white\:wan/brightness

will set that LED to 128/256 brightness. You have 255 steps of
brightness.

The reason i did not model it as a PWM, is that it cannot fulfil the
PWM interface. The configure interface is:

int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns);

However with this device, you have no control over the period. It is
fixed, from a 97-kHz clock. All you can change is the duty as a ratio
between 0 and 256. There is the group PWM, where you do have control
over the period. But as the name implies, this PWM is shared for all
outputs, which is not what the PWM interface expects, it wants to be
able to control them individually. Also, it only has a range of 24 Hz
to 10.73 s. Again, i have no idea about backlights, but i suspect if
it is driven at 24Hz, i'm going to get a headache. 

The LED interface can be fully implemented. So that is what i have
done.

So i think modeling this as an LED driver is correct, and maybe you
need to implemented an led_bl.c driver?

	Andrew
