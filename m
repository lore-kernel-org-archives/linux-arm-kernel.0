From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 20 Jan 2015 11:53:14 +0200
Subject: [PATCHv3 0/2] Driver for TI tlc59116 16 Channel i2c LED driver
In-Reply-To: <20150116191734.GB31577@lunn.ch>
References: <1421277308-3477-1-git-send-email-andrew@lunn.ch>
 <54B9259C.3070403@ti.com> <20150116191734.GB31577@lunn.ch>
Message-ID: <54BE258A.10808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/01/15 21:17, Andrew Lunn wrote:
> On Fri, Jan 16, 2015 at 04:52:12PM +0200, Tomi Valkeinen wrote:
>> Hi,
>>
>> On 15/01/15 01:15, Andrew Lunn wrote:
>>> This patchset is a driver for the TI tlc59116 16 Channel i2c LED
>>> driver. This driver is used on the Belkin WRT1900AC access point and
>>> the C code is derived from code Belkin contributed to OpenWRT.
>>> However it has been extensively re-written, and a device tree binding
>>> added to replace platform data.
>>
>> We have a TLC59108 on one of our boards, and with a quick glance it
>> looks about the same as TLC59116, except the amount of outputs.
> 
> Hi Tomi
> 
> I took a look at the TLC59108. The hardware designs have not made it
> easy, but it does look similar enough that my driver can be extended
> to cover both. These extensions It will not change the DT binding, it
> will just gain a new compatibility string. So i would prefer my driver
> is first fully reviewed and accepted, and then i will take a stab at
> extending it for the TLC59108. I will need help testing it, but i hope
> you can help there.

Ok.

I'm not familiar with the LED/PWM frameworks, so I want to summarize our
use case and how I guess this should be done:

We use the TLC59108 to provide backlight to a LCD, but in addition to
that, it is used as a GPIO expander (or GPO, as it cannot do input). In
your earlier patch versions there were some 'gpio' leftovers. Does your
board have such GPIO use also?

So my current thinking is that TLC591xx should be a LED driver (as it
sounded to me that PWM is not quite suitable for it). On top of that, we
need generic 'led-backlight' and 'led-gpio' drivers, each of which uses
the given LED driver to do the hardware manipulation, and they expose a
backlight device and gpio device, respectively.

Another option would be an mfd device, but that doesn't sound good as I
think the backlight and gpio functionality here is not related to
TLC591xx as such, but to a LED device in general.

Does this sound sane?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150120/b78d1571/attachment.sig>
