From: b.hutchman@gmail.com (Brian Hutchinson)
Date: Wed, 30 Sep 2009 22:17:23 -0400
Subject: Generic GPIO I2C bitbang kernel question
Message-ID: <3d1967ab0909301917g1acc4fd4ga49eb1906a8fccf5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm trying to get i2c-core gpio bitbang I2C adapter working on a picoChip
PC205 (ARM926EJS core)

I have soft i2c bit banging working in u-boot and am now trying to get it
working in Linux.

I have provided the required functions needed by my particular hardware to
control SDA & SCL (gpio set/get, input/output etc.).

It looks like i2c-core is using i2c-algo-bit.c and I'm having some problems
with it.  I'm monitoring the I2C bus with a logic analyzer and all I see is
START + slave address being sent out 3 times and then I get an error that
the address or device doesn't exist.

Using OpenOCD with a JTAG interface, I have narrowed down where I think the
problem is and I have some questions about the following code snipet of
i2c_outb function taken from i2c-algo-bit.c in the 2.6.28 kernel:

1    /* assert: scl is low */
2    for (i = 7; i >= 0; i--) {
3        sb = (c >> i) & 1;
4        setsda(adap, sb);
5        udelay((adap->udelay + 1) / 2);
6        if (sclhi(adap) < 0) { /* timed out */
7            bit_dbg(1, &i2c_adap->dev, "i2c_outb: 0x%02x, "
8                "timeout at bit #%d\n", (int)c, i);
9            return -ETIMEDOUT;
10        }
11        /* FIXME do arbitration here:
12         * if (sb && !getsda(adap)) -> ouch! Get out of here.
13         *
14         * Report a unique code, so higher level code can retry
15         * the whole (combined) message and *NOT* issue STOP.
16         */
17        scllo(adap);
18    }
19    sdahi(adap);
20    if (sclhi(adap) < 0) { /* timeout */
21        bit_dbg(1, &i2c_adap->dev, "i2c_outb: 0x%02x, "
22            "timeout at ack\n", (int)c);
23        return -ETIMEDOUT;
24    }

25    /* read ack: SDA should be pulled down by slave, or it may
26     * NAK (usually to report problems with the data we wrote).
27     */
28    ack = !getsda(adap);    /* ack: sda is pulled low -> success */
29    bit_dbg(2, &i2c_adap->dev, "i2c_outb: 0x%02x %s\n", (int)c,
30        ack ? "A" : "NA");

31    scllo(adap);
32    return ack;
33    /* assert: scl is low (sda undef) */

The call tree that gets me to i2c_outb starts with bit_xfer and the
try_adress function is what is calling i2c_outb just after the start
condition goes out.

Some more details ... I'm using a udelay of 5 (measured to be around
156KHz), sda and scl are set to open drain.  scl is set to output only.

When I trigger the logic analyzer on the start condition, sda goes low and
10us later scl goes low.  OK so far.

Then I get to try_address which calls i2c_outb above.  i2c_outb correctly
outputs the slave address I'm trying to talk to except for the 9th scl clock
period which looks strange ... more below.

First thing I noticed about the loop in line 2 above is it is writing out 8
bits, I guess since we are "writing" this is for the r/w bit but isn't made
explicit.

As mentioned before, looking at the wave form on the logic analyzer, the 9th
clock of scl shows sda high during that period where the ack should be.
upon further investigation, I think the high during that period is coming
from line 19 above "sdahi(adap);".  Not sure what is trying to be
accomplished with this line.  So, I think that might be part of my problem.

Next issue I think I'm having is line 28.  That getsda looks like it doesn't
set sda to being a input before it tries to read from it so it never sees
the ack so that is why it is retrying 3 times and dying.

Line 31 also looks like it is a extra low call, especially since when
i2c_outb returns try_address calls i2c_stop.

Now the part that gets me thinking ... the  __devinit i2c_gpio_probe
function looks like it is smart enough to call functions such as:
gpio_direction_output
gpio_direction_input

... to do the right thing with respect to sda, scl etc., but i2c-algo-bit
doesn't appear to know it needs to call these functions to make sda "switch
gears"

So I guess my questions are:
Do I put the direction input/output calls in my i2c_gpio_setsda_val and
i2c_gpio_getscl functions that I have to supply that are specific to my
hardware or do I need to copy off i2c-algo-bit.c to a board specific version
(kind of like i2c-at91.c) and have it call gpio_direction calls to make sda
do the right thing (switch to a input so the ack can be read)?

Hopefully someone familiar with getting the i2c-core bitbang driver working
can clue me in on what I'm seeing and the right way to go about addressing
it.  This is my first post.  Thought I would post to the list instead of
wearing out my welcome with the few developers I know that have worked on
generic gpio i2c bitbang kernel code.

Regards,

Brian
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090930/c1e30d55/attachment-0001.htm>
