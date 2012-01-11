From: wmb@firmworks.com (Mitch Bradley)
Date: Tue, 10 Jan 2012 20:43:28 -1000
Subject: [PATCH] ARM: vexpress: initial device tree support
In-Reply-To: <4F0CD7BC.7080409@freescale.com>
References: <1316596786-2539-1-git-send-email-dave.martin@linaro.org>
 <CAOZdJXXPJEaFO-ymvb_TsTJ6W2T7_aWXA=9RZprVmKBOn9cu8A@mail.gmail.com>
 <4F0B897A.20502@firmworks.com>
 <20120110122252.GA7180@jl-vm1.vm.bytemark.co.uk>
 <4F0CB485.9010106@freescale.com> <4F0CBD46.2010909@firmworks.com>
 <4F0CD7BC.7080409@freescale.com>
Message-ID: <4F0D2F90.8020801@firmworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/10/2012 2:28 PM, Timur Tabi wrote:
> Mitch Bradley wrote:
>> It seems to me that having the framebuffer driver handle the EDID
>> "driver" function is exactly the right thing.  The framebuffer driver is
>> the only thing that cares about EDID information.  Given a phandle
>> reference to an I2C interface, the "driver" is just "call the I2C read
>> routine" - plus, in your case, toggling the GPIO pin.
>
> Do you think I should have the I2C probe function read the EDID data, and then store it in some global variable?

I think that would not be a good design.  Presence and location of EDID 
data is not something that a generic I2C driver should know.  It's the 
video controller that knows that EDID exists, where it is located 
(device ID 0x50 and addresses within that device), and what it means.

>  That won't work if I have multiple video controllers, since I won't know which EDID data goes with which video controller.  I tried adding a call to i2c_add_driver() in my framebuffer driver, but the I2C probe function was called *after* the framebuffer's probe function, so that doesn't help me.

Then there needs to be some sort of ordering or dependency to ensure 
that the I2C driver is activated before the framebuffer driver tries to 
use it.

>
>> That GPIO pin thing is annoying, but not sufficiently complex or common
>> that it warrants having a separate EDID driver.  You could define a
>> platform-specific property to tell your framebuffer driver that it needs
>> to do that GPIO thing.  It's a hack, but the GPIO thing is inherently a
>> hack, so there will be some ugliness somewhere as a result.
>
> I have two platform-specific functions, "enabled_edid" and "disable_edid", that I call before/after calling fb_ddc_read().  This seems to work well, and I already have a mechanism for calling platform-specific functions from the framebuffer driver.
>
> However, Stephen Warren said I should be using the I2C mux feature instead.
>

I2C mux is a plausible solution, as is your enable/disable thing.  At 
some level they are equivalent.  I2C mux is a formalization of your 
solution, in which the mux device's select method must be written to 
perform the function of your enable/disable edid functions.

Either way, you need platform-dependent functions to do the switching, 
and you need to select the appropriate channel.  Personally, I don't see 
the advantage of using the mux device in this case.  It's just adding 
complexity with no payback.  If there were several channels that needed 
to be accessed in an interspersed fashion, the mux device would  be much 
cleaner.  But in this case, there is a single "back channel" that only 
needs to be accessed once and can subsequently be ignored.  The video 
driver can grab a lock, call enable_edid(), read out the EDID data into 
an array, call disable_edid(), release the lock, and that is it.  The 
other users of that I2C bus can ignore the hidden EDID.

But, as I said, either way is okay.  They are pretty much equivalent at 
a fundamental level.  You must have the platform-dependent function to 
do the switching, and you must have a reference to an underlying I2C 
bus.  If you go the mux route, every other user of that I2C bus must 
also use the mux device, selecting the other channel.  That propagates 
the knowledge of this "hidden" EDID ROM farther than it would otherwise 
have to go.  It probably also means you would want a device node to 
represent the fact that the I2C bus is muxed, to instantiate the i2c_mux 
driver.  I think that doing a binding for i2c_mux is a can of worms, 
because of the need to represent the platform-dependent "how to select" 
functionality.
