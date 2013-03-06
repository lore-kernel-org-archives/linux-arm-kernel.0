From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 6 Mar 2013 13:34:26 +0100
Subject: [PATCH 00/23] RFC: exynos multiplatform support
In-Reply-To: <201303061050.42451.arnd@arndb.de>
References: <1362505353-8873-1-git-send-email-arnd@arndb.de>
 <201303051919.02638.arnd@arndb.de> <1781901.cQ9rKScpd8@flatron>
 <201303061050.42451.arnd@arndb.de>
Message-ID: <20130306123426.GB17079@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 10:50:42AM +0000, Arnd Bergmann wrote:
> On Tuesday 05 March 2013, Tomasz Figa wrote:
> > On Tuesday 05 of March 2013 19:19:02 Arnd Bergmann wrote:
> 
> > > If none of these are needed for DT-based systems, we should probably
> > > build that code conditionally based on the CONFIG_EXYNOS_ATAGS symbol
> > > I introduced.
> > 
> > Yes, none of them are needed for DT-based systems.
> 
> Ah, good. I'll try to make more code conditional then.
>  
> > > How are you planning to solve this? Do you want to have a combined
> > > driver that registers both a clocksource and a pwm?
> > 
> > Let's start with a quick introduction to the s3c-pwm hardware. Each 
> > channel has its own timer value, compare and reload value registers, so 
> > they don't need any extra locking. However there are additional shared 
> > configuration registers, containing things such as start and reload bits 
> > for all channels, prescaler and main divisor values, etc. Those registers 
> > needs synchronization.
> > 
> > Now there are several possible approaches:
> > 
> > 1) A brute force one - two separate drivers, based on the fact that the
> >    clocksource driver will be used only on uniprocessor systems, so
> >    a simple _irqsave when accessing a shared register in both will 
> >    guarantee correct synchronization.
> > 
> > 2) Two separate drivers with some synchronized shared code accessing 
> >    registers (_start, _stop, _set_reload, _set_prescaler, _set_divisor, 
> >    etc.; all using a shared spinlock).
> > 
> > 3) Single driver registering PWM channels, clocksource and clock event 
> >    device. This does not seem like a bad idea, since the whole code for 
> >    configuration of the PWM block would reside in one location and there 
> >    would be no redundancy. However there is a question where such driver 
> >    should be placed - drivers/clocksource, drivers/pwm, or maybe somewhere 
> >    else?
> > 
> > Personally I wanted to go with first option, which would require least 
> > amount of changes to existing code, at a cost of some code duplication 
> > (but some PWM code is duplicated already).
> 
> I would prefer option 3. That is also easier to implement with a straightforward
> DT binding that defines a single node with the clock registers. The location
> doesn't have an obvious answer, but I would probably put them into
> drivers/clocksource if the PWM maintainer agrees.
> 
> Option 2 would probably come down to having a trivial MFD driver exposing
> a regmap. You can probably reuse drivers/mfd/syscon.c for this and make
> the node compatible with "syscon" to designate the clock registers as
> a system-wide resource, making the other device nodes register-less.

I think option 2 is the standard method if one hardware block provides
several logical devices. I find it to be a pretty nice solution to this
problem. We also have precedent in the PWM subsystem. The TWL chips for
instance use it to create a platform device which is later driven by a
PWM driver.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130306/fdd76f07/attachment.sig>
