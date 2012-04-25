From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 25 Apr 2012 11:35:42 -0700
Subject: [PATCH v5 1/3] USB: Add driver for NXP ISP1301 USB transceiver
In-Reply-To: <4F97B395.9020501@antcom.de>
References: <1335002264-22225-1-git-send-email-stigge@antcom.de>
 <20120424232044.GA2657@kroah.com> <4F97B395.9020501@antcom.de>
Message-ID: <20120425183542.GA27617@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2012 at 10:19:33AM +0200, Roland Stigge wrote:
> Hi Greg,
> 
> thanks for reviewing! I integrated all of your suggestions into the
> patch update, except ...
> 
> On 04/25/2012 01:20 AM, Greg KH wrote:
> > On Sat, Apr 21, 2012 at 11:57:42AM +0200, Roland Stigge wrote:
> >> This very-lowlevel driver registers the NXP ISP1301 chip via the I2C subsystem.
> >> The chip is the USB transceiver shared by ohci-nxp, lpc32xx_udc (gadget) and
> >> isp1301_omap.
> >>
> >> Following patches let the respective USB host and gadget drivers use this
> >> driver, instead of duplicating ISP1301 handling.
> >>
> >> Signed-off-by: Roland Stigge <stigge@antcom.de>
> >> Acked-by: Arnd Bergmann <arnd@arndb.de>
> >>
> >>  include/linux/usb/isp1301.h                       |   84 ++++++++++++++++++++++
> > 
> > Why this file?  You have a lot of register stuff in here that should be
> > in the .c file, right?  Only put what other files need in this .h file,
> > which shouldn't be much at all from what I can tell.
> 
> Right. At first sight, it doesn't look very elegant that the driver
> exposes the ISP1301 register set to the drivers using it. I discussed
> this design previously with Arnd on the mailing list and we agreed on
> the following: ISP1301 is a very low level driver that primarily
> separates out the I2C client registration of the ISP1301 chip (including
> instantiation via DT), used by other drivers, but it's still just a kind
> of helper driver for some OHCI and USB device drivers. Consider the
> ISP1301 driver as a register set extension of ohci-nxp, lpc32xx-udc and
> isp1301_omap, which in turn know best what to do with the low level
> functionality (individual ISP1301 registers and timing, see the
> different initialization strategies in those drivers). Those drivers
> previously internally duplicated ISP1301 register definitions which is
> solved by the new isp1301 driver.
> 
> Initially, I actually had register get/set functions defined in
> isp1301.h but it turned out that those trivial wrappers around standard
> i2c_smbus_*() better had been removed.
> 
> So what do you think?

Ok, that makes more sense, thanks for explaining it.  Perhaps you should
put that in the patch changelog entry itself, so others don't also have
that same question?

thanks,

greg k-h
