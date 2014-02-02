From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 02 Feb 2014 19:41:03 +0100
Subject: [PATCH v5 00/23]
In-Reply-To: <20140202182349.GJ26684@n2100.arm.linux.org.uk>
References: <cover.1390986082.git.moinejf@free.fr>
 <20140202124358.GD26684@n2100.arm.linux.org.uk>
 <20140202190606.6fa193ce@armhf>
 <20140202182349.GJ26684@n2100.arm.linux.org.uk>
Message-ID: <52EE913F.1030209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/2014 07:23 PM, Russell King - ARM Linux wrote:
> On Sun, Feb 02, 2014 at 07:06:06PM +0100, Jean-Francois Moine wrote:
>> - on encoder_destroy(), the function drm_i2c_encoder_destroy()
>>    unregisters the i2c client, so, with a DT, a second encoder_init()
>>    would crash.
>
> I think this is one of the down-sides of trying to bolt DT into this:
> the drm encoder slave support is not designed to cope with an i2c client
> device pre-created.
>
> In fact, I can't see how this stuff comes anywhere close to working in
> a DT setup: in such a scenario, you declare that there's a tda998x
> device in DT.  I2C parses this, and creates an i2c_client itself for
> the tda998x.
>
> When the TDA998x driver initialises, it finds this i2c client and
> binds to it, calling tda998x_probe(), which does nothing.
>
> However, the only way to attach a slave encoder to a DRM device is via
> a call to drm_i2c_encoder_init(), which unconditionally calls
> i2c_new_device().  This creates a _new_ i2c_client structure, again
> unconditionally, for the tda998x.  This must be bound by the I2C
> subsystem to a driver - hopefully the tda998x driver, which then
> calls it's encoder_init function.
>
> None of this will happen if DT has already created an i2c_client at
> the appropriate address, because DRMs i2c_new_device() will fail.

drm_i2c_encoder_init() could look at .of_node of the i2c_board_info.
If it is there, do not try to i2c_new_device as it has already been
registered by DT i2c auto-probing.

Sebastian
