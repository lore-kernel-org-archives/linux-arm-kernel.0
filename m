From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 26 Jul 2012 15:43:36 +0100
Subject: [PATCH 20/21] ASoC: codecs: Enable AB8500 CODEC for Device Tree
In-Reply-To: <501150E5.6010503@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-21-git-send-email-lee.jones@linaro.org>
 <20120726115055.GD3099@opensource.wolfsonmicro.com>
 <501150E5.6010503@linaro.org>
Message-ID: <20120726144336.GL3099@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 03:15:01PM +0100, Lee Jones wrote:
> Sorry missed this:

> >Why are we doing this?  The MFD cells are a totally Linux specific
> >thing, there's no reason to represent them in the device tree unless
> >they're in some way reusable and the "ab8500-codec" name suggests that's
> >unlikely.  Just put the properties on the parent node and instantiate
> >the MFD cell as normal.

> We have all of the AB8500 devices into the Device Tree to accurately
> represent the hardware. We will also be passing configuration
> information into the AB8500 Codec from Device Tree. The only reason
> we're still registering them using the MFD API is to overcome
> addressing issues encountered earlier. Each 'device' still belongs
> in the 'device' tree.

The device here is the AB8500.  The fact that Linux chooses to represent
it as an MFD with a particular set of subdrivers is a Linux specific
decision and may well change over time.  For example it's likely that
we'll want to migrate the clocks out of the audio driver and into the
clock API when that becomes useful.  Similarly currently a lot of these
devices use ASoC level jack detection but that's going to move over to
extcon over time. 

There's no way you're going to be able to reuse this for anything that
isn't an AB8500, there's no abstraction of the SoC integration here.  If
you had clearly identifiable, repeatable IPs which you could reasonably
bind to a different bit of silicon then that'd be different but there's
nothing like that here.  We already know that the functionality covered
by the driver is going to be present simply by virtue of knowing that
there's an AB8500 and similarly there's no real way this driver could
ever be used without the core driver.  All the "device" in the device
tree is doing is serving as a container to place some of the DT
properties into, this needs to be separated out from the instantiation
of the Linux device driver.  There's nothing stopping the driver from
looking at the OF node of its parent here.

The goal here isn't just to copy the Linux device model and platform
data into device tree bindings, the device tree bindings need to think
about what the chip actually is so they can be reused by other OSs and
by future versions of Linux.

> If we were to take this Device Tree and use it on something
> non-Linux, that OS will still need to know about each of the AB8500
> devices and every associated configuration option. Only in Linux do
> we continue to register them though a different API, which doesn't
> affect any other OS.

Another OS might have a different idea about how it's going to split up
the chip which better fits with the models which that OS has for the
functions present on the device.  The reason this is a distinct device
in Linux is all to do with how Linux models the hardware.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120726/92995ced/attachment.sig>
