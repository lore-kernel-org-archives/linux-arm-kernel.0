From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 Jan 2017 16:36:02 +0100
Subject: [PATCH v2 0/7] rtc: sun6i: Fix the RTC accuracy
In-Reply-To: <20170124174935.att4s7mqfbyxkxqk@piout.net>
References: <cover.6bd4d4760c24d09845ad09c212fcd487d78da5ad.1485168100.git-series.maxime.ripard@free-electrons.com>
 <20170124174935.att4s7mqfbyxkxqk@piout.net>
Message-ID: <20170125153602.tcdh2rk3bs3cz5j6@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 06:49:35PM +0100, Alexandre Belloni wrote:
> Hi,
> 
> On 23/01/2017 at 11:41:45 +0100, Maxime Ripard wrote :
> > Hi,
> > 
> > The RTC used in the A31 and later SoC has an accuracy issue, which is
> > already significant even after a couple of hours.
> > 
> > This is due to the fact that the oscillator used by default is an internal
> > and very inaccurate one.
> > 
> > A first attempt at fixing that by switching to the external oscillator was
> > done in the patch "rtc: sun6i: Switch to the external oscillator". However,
> > it turned out to be problematic since it was tracked properly in the clock
> > framework, which might lead to some clocks being disabled, even though
> > their devices were not notified.
> > 
> > This is a second attempt, this time by making it part of the CCF. It
> > turned out to be a bit more complicated than one would expect since the mux
> > found inside the RTC also controls one of the input of the main clock unit.
> > Therefore, it needs to be probed before the main clock unit driver.
> > 
> > Let me know what you think,
> > Maxime
> > 
> > Changes from v1:
> >   - Force the muxing to the external oscillator even for old DT
> >   - Make the patches a bit more stable friendly
> >   - Change the bindings to have a cell of 1, to account for the external
> >     output of the oscillator
> >   - Split the driver remove() removal into a separate patch and switched to
> >     devm
> >   - Reordered the patches
> > 
> > Maxime Ripard (7):
> >   rtc: sun6i: Disable the build as a module
> >   rtc: sun6i: Add some locking
> >   rtc: sun6i: Switch to the external oscillator
> >   rtc: sun6i: Expose the 32kHz oscillator
> >   rtc: sun6i: Switch to devm_rtc_device_register
> >   ARM: sun8i: a23/a33: Enable the real LOSC and use it
> >   ARM: sun8i: a23/a33: Add the oscillators accuracy
> > 
> 
> I've applied 1/7 to 5/7. Thanks!

And I just applied patches 6 and 7. Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170125/54e8cc15/attachment.sig>
