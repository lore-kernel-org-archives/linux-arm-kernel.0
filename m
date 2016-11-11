From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 11 Nov 2016 09:53:03 +0800
Subject: [PATCH v9 2/8] power: add power sequence library
In-Reply-To: <CAJZ5v0ioqMqoaJqK0CTXafWRKoohmZSiOWKRgVZ9DR3_8+-YDw@mail.gmail.com>
References: <1478573472-29516-1-git-send-email-peter.chen@nxp.com>
 <1478573472-29516-3-git-send-email-peter.chen@nxp.com>
 <CAJZ5v0ioqMqoaJqK0CTXafWRKoohmZSiOWKRgVZ9DR3_8+-YDw@mail.gmail.com>
Message-ID: <20161111015303.GA12742@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2016 at 02:05:01AM +0100, Rafael J. Wysocki wrote:
> On Tue, Nov 8, 2016 at 3:51 AM, Peter Chen <peter.chen@nxp.com> wrote:
> > We have an well-known problem that the device needs to do some power
> > sequence before it can be recognized by related host, the typical
> > example like hard-wired mmc devices and usb devices.
> >
> > This power sequence is hard to be described at device tree and handled by
> > related host driver, so we have created a common power sequence
> > library to cover this requirement. The core code has supplied
> > some common helpers for host driver, and individual power sequence
> > libraries handle kinds of power sequence for devices. The pwrseq
> > librares always need to allocate extra instance for compatible
> > string match.
> >
> > pwrseq_generic is intended for general purpose of power sequence, which
> > handles gpios and clocks currently, and can cover other controls in
> > future. The host driver just needs to call of_pwrseq_on/of_pwrseq_off
> > if only one power sequence is needed, else call of_pwrseq_on_list
> > /of_pwrseq_off_list instead (eg, USB hub driver).
> >
> > For new power sequence library, it can add its compatible string
> > to pwrseq_of_match_table, then the pwrseq core will match it with
> > DT's, and choose this library at runtime.
> 
> In the first place, please document this stuff better than you have so
> far.  To a minimum, add kerneldoc comments to all new non-trivial new
> functions to document what they are for and how they are expected to
> be used (especially the ones exported to drivers).
> 

Thanks for your comments.

I will add kerneldoc for main APIs.

> Also, is there any guidance available for people who may want to use it?

No doc now, only some guidance in this commit log.

> > +config PWRSEQ_GENERIC
> > +       bool "Generic power sequence control"
> > +       depends on OF
> > +       select POWER_SEQUENCE
> > +       help
> > +          It is used for drivers which needs to do power sequence
> > +          (eg, turn on clock, toggle reset gpio) before the related
> > +          devices can be found by hardware. This generic one can be
> > +          used for common power sequence control.
> 
> I wouldn't set it up this way.
> 
> There are two problems here.
> 
> First, say a distro is going to ship a multiplatform generic kernel.
> How they are going to figure out whether or not to set the new symbol
> in that kernel?
> 
> Second, how users are supposed to know whether or not they will need
> it even if they build the kernel by themselves?
> 
> It would be better IMO to set things up to select the new symbol from
> places making use of the code depending on it.
> 

Will change it like below:

#
# Power Sequence library
#

menuconfig POWER_SEQUENCE
	bool "Power sequence control"
	depends on OF
	help
	   It is used for drivers which needs to do power sequence
	   (eg, turn on clock, toggle reset gpio) before the related
	   devices can be found by hardware. 

if POWER_SEQUENCE

config PWRSEQ_GENERIC
	bool "Generic power sequence control"
	default y
	help
	   This is the generic power sequence control library, and is
	   supposed to support common power sequence usage.
endif

And the current user usb core will select POWER_SEQUENCE.
-- 

Best Regards,
Peter Chen
