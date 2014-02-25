From: syin@broadcom.com (Sherman Yin)
Date: Mon, 24 Feb 2014 18:24:00 -0800
Subject: pinctrl: pinctrl-single vs custom driver
Message-ID: <530BFEC0.2070805@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

After upstreaming the bcm281xx (capri) pinctrl driver, I'm working on 
the driver for another SoC.  I'd like your input before I get too far 
with the driver.

Recall we had a discussion about whether to use pinctrl-single for the 
bcm281xx driver, and you mentioned a custom driver is better:

 >> Now I have written a driver that's pretty much ready-to-go, but on the
 >> other hand, pinctrl-single also does what my chip needs, so my driver
 >> is sort of duplicated other than the fact that it defines pins and
 >> functions.  I'm just trying to determine which driver is the more
 >> preferred way to go for upstreaming.
 >
 > Your driver defining pins and functions is better.

Like the bcm281xx, in this SoC, each pin is also controlled by 1 
register, so pinctrl-single should work.  The difference between this 
SoC and bcm281xx is that the pin registers in this SoC are only 
accessible via a messaging mechanism (send a command then wait for a 
reply), not a simple register read-write.  We have defined one message 
for reading the register and one for writing to it.

In a driver like pinctrl-bcm281xx, pinmux and pin configs are separately 
applied and on a per-pin basis.  A simple update of 1 pin will thus 
result in numerous messages:

  1. Send cmd to read register, block for reply
  2. Rcv reply with value
  3. Modify pinmux portion
  4. Send cmd to write register
  5. Send cmd to read register, block for reply
  6. Rcv reply with value
  7. Modify pin configs portion
  8. Send cmd to write register

With pinctrl-single, updating pins will be much simpler with just 1 
message to directly write the whole register.

Is this efficiency enough to warrant using pinctrl-single over a 
"normal" pinctrl driver in this case?

Appreciate your time.

Regards,
Sherman
