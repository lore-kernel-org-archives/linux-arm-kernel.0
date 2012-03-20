From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 20 Mar 2012 16:08:36 +0000
Subject: [PATCH v4 10/10] pwm-backlight: Add rudimentary device tree
 support
In-Reply-To: <4F68A899.3030009@wwwdotorg.org>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-11-git-send-email-thierry.reding@avionic-design.de>
 <4F67F2AF.3020404@wwwdotorg.org>
 <20120320083943.GA20249@avionic-0098.adnet.avionic-design.de>
 <4F68A1C8.5080608@wwwdotorg.org>
 <20120320154330.GA8651@avionic-0098.mockup.avionic-design.de>
 <4F68A899.3030009@wwwdotorg.org>
Message-ID: <20120320160832.GL3445@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 20, 2012 at 09:56:09AM -0600, Stephen Warren wrote:
> On 03/20/2012 09:43 AM, Thierry Reding wrote:

> > What would be a good way to represent this in platform data?

> I think most get subsystems have a get API that works for both DT and
> non-DT, rather than using platform data:

Yes, please - having to have explict handling in drivers to select a
mechanism to look up stuff in the subsystem would be very sad.

> # works in DT right now IIRC:
> regulator_get(dev, supply_name)

Yes, that's totally transparent to the device.

> For board files, this would rely on some table which mapped from the get
> parameters to the returned object. IIRC, most of these tables are
> indexed by (dev_name(dev), name) and probably return the dev_name() of
> the providing device (or whatever internally makes sense to identify the
> device) plus some subsystem-specific data (e.g. PWM index).

That's how regulator and clk do it (I think pinctrl too, and IIO also
does this though it's in staging) - the consumer works with the struct
device and the name of the thing it's requesting and the things doing
the mapping (boards, SoCs, whatever) map this onto the actual device
with a lookup table which works in terms of dev_name() for the
requesting device.  We use dev_name() because many buses don't make a
struct device available until very late in system startup.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120320/ed4944f1/attachment.sig>
