From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Fri, 03 Feb 2017 22:14:31 +0100
Subject: [PATCH 2/8] power: add power sequence library
In-Reply-To: <20170203081614.GA24614@b29397-desktop>
References: <1483425211-14473-1-git-send-email-peter.chen@nxp.com>
 <20170201080817.GD17968@kroah.com> <20170203081614.GA24614@b29397-desktop>
Message-ID: <16336642.sihi7izbLX@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, February 03, 2017 04:16:15 PM Peter Chen wrote:
> On Wed, Feb 01, 2017 at 09:08:17AM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Feb 01, 2017 at 12:10:17AM +0100, Rafael J. Wysocki wrote:
> > > On Tue, Jan 3, 2017 at 7:33 AM, Peter Chen <peter.chen@nxp.com> wrote:
> > > > We have an well-known problem that the device needs to do some power
> > > > sequence before it can be recognized by related host, the typical
> > > > example like hard-wired mmc devices and usb devices.
> > > >
> > > > This power sequence is hard to be described at device tree and handled by
> > > > related host driver, so we have created a common power sequence
> > > > library to cover this requirement. The core code has supplied
> > > > some common helpers for host driver, and individual power sequence
> > > > libraries handle kinds of power sequence for devices. The pwrseq
> > > > librares always need to allocate extra instance for compatible
> > > > string match.
> > > >
> > > > pwrseq_generic is intended for general purpose of power sequence, which
> > > > handles gpios and clocks currently, and can cover other controls in
> > > > future. The host driver just needs to call of_pwrseq_on/of_pwrseq_off
> > > > if only one power sequence is needed, else call of_pwrseq_on_list
> > > > /of_pwrseq_off_list instead (eg, USB hub driver).
> > > >
> > > > For new power sequence library, it can add its compatible string
> > > > to pwrseq_of_match_table, then the pwrseq core will match it with
> > > > DT's, and choose this library at runtime.
> > > >
> > > > Signed-off-by: Peter Chen <peter.chen@nxp.com>
> > > > Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> > > > Tested-by Joshua Clayton <stillcompiling@gmail.com>
> > > > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > > > Tested-by: Matthias Kaehlcke <mka@chromium.org>
> > > 
> > > Quite honestly, I have a really hard time with trying to follow this
> > > code and the total lack of documentation makes it even harder. 
> 
> Sorry about that, Is it ok I add the design doc at:
> Documentation/power/power-sequence/design.rst?

You can do that if you think it will address the request to explain the design.

> > > particular, the generic power sequence code is not even commented at
> > > all, 
> 
> The generic power sequence code just implements the APIs which are 
> called at power/pwrseq/core.c, and those API are commented at
> include/linux/power/pwrseq.h. Anyway, I will add more comments at it.

It actually seems to be doing more than that and I'm not sure why the code in
core.c is necessary at all.  The "generic" thing seems to be the only user of
it anyway and the callbacks seem to be tailored to its needs.

Thanks,
Rafael
