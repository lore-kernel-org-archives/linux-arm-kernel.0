From: wmb@firmworks.com (Mitch Bradley)
Date: Tue, 10 Jan 2012 12:35:50 -1000
Subject: [PATCH] ARM: vexpress: initial device tree support
In-Reply-To: <4F0CB485.9010106@freescale.com>
References: <1316596786-2539-1-git-send-email-dave.martin@linaro.org>
 <CAOZdJXXPJEaFO-ymvb_TsTJ6W2T7_aWXA=9RZprVmKBOn9cu8A@mail.gmail.com>
 <4F0B897A.20502@firmworks.com>
 <20120110122252.GA7180@jl-vm1.vm.bytemark.co.uk>
 <4F0CB485.9010106@freescale.com>
Message-ID: <4F0CBD46.2010909@firmworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/10/2012 11:58 AM, Timur Tabi wrote:
> Jamie Lokier wrote:
>
>> It still needs to know *which* I2C bus master is connected to the
>> display. Some graphics hardware has multiple, e.g. one to talk with
>> the DVI/HDMI transmitter, another connected by cable to the display.
>
> Yes, this is my problem.  I have multiple I2C busses on my system, and there's no way to guess which one is connected to the DVI port.  A phandle in the device tree is the only way I can figure out which I2C bus to use.  But there's another problem.  I can use of_find_i2c_device_by_node() to determine the i2c_client (and therefore, the i2c_adapter) to use for fb_ddc_read().  However, that function only works if the I2C device was probed.  That typically is done by the I2C driver for the device, but there is no "edid" device driver.  So my framebuffer driver is going to have to pretend to be one.

It seems to me that having the framebuffer driver handle the EDID 
"driver" function is exactly the right thing.  The framebuffer driver is 
the only thing that cares about EDID information.  Given a phandle 
reference to an I2C interface, the "driver" is just "call the I2C read 
routine" - plus, in your case, toggling the GPIO pin.

That GPIO pin thing is annoying, but not sufficiently complex or common 
that it warrants having a separate EDID driver.  You could define a 
platform-specific property to tell your framebuffer driver that it needs 
to do that GPIO thing.  It's a hack, but the GPIO thing is inherently a 
hack, so there will be some ugliness somewhere as a result.

>
> I wish there were some way to obtain the i2c_adapter struct more easily.
>
>> I have worked with devices that shared the same I2C for DDC and
>> talking with on-board devices. (That was a bad idea, as some monitors
>> clamp the lines high or low excessively even when switched off.) Point
>> here is sometimes there's a dedicated one for DDC; sometimes there isn't.
>
> I also have this problem.  I need to toggle a GPIO in order to get the I2C bus connected to the DVI port.  The same I2C bus is used for the audio codec and a bunch of other devices.  Our SOC has four I2C busses, so I don't understand why the board designed didn't dedicate one for the DDC.  But I can easily work around this issue.
>
>
