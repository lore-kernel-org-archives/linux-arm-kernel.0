From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 6 Sep 2016 12:04:38 +0200
Subject: [PATCH v3 1/4] pwm: Add support for Meson PWM Controller
In-Reply-To: <a43f6e6e-05f6-cefe-451d-528588b85a8c@baylibre.com>
References: <1471880193-21879-1-git-send-email-narmstrong@baylibre.com>
 <1471880193-21879-2-git-send-email-narmstrong@baylibre.com>
 <20160905090052.GG3532@ulmo.ba.sec>
 <bd7ea1db-d8f9-f075-14ef-732d9bb65e77@baylibre.com>
 <20160906090749.GA15644@ulmo.ba.sec>
 <a43f6e6e-05f6-cefe-451d-528588b85a8c@baylibre.com>
Message-ID: <20160906100438.GE15644@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 11:14:45AM +0200, Neil Armstrong wrote:
> On 09/06/2016 11:07 AM, Thierry Reding wrote:
> > On Tue, Sep 06, 2016 at 10:36:49AM +0200, Neil Armstrong wrote:
> >> Hi Thierry,
> >>
> [...]
> > 
> >>
> >> The second bug is in probe(), I understand the point to allocate
> >> dynamically the channels and attach them to each pwm chip, but when
> >> calling meson_pwm_init_channels() we get an OOPS because
> >> meson->chip.pwms[i] are allocated in pwmchip_add(). Moving
> >> meson_pwm_init_channels() would fix this, but in case of a clk
> >> PROBE_DEFER, we would need to remove back the pwmchip, which is a
> >> quite a bad design decision....
> > 
> > Ah yes... that one again. I remember running into that a while ago with
> > some other driver. To be honest, I think that's a short-coming of the
> > PWM subsystem and the fix would be for PWM chip registration to be split
> > into two parts: pwm_chip_init() and pwm_chip_add(). That way, a chip
> > would be initialized using pwm_chip_init() where the pwms array would be
> > allocated, and pwm_chip_add() would register the chip with the system.
> > 
> > Currently a few drivers might be vulnerable to a race condition between
> > registration and implementation (i.e. PWM channels aren't fully set up
> > when they are exposed to users and sysfs).
> > 
> >> The smartest fix I found was to allocate channels in probe, init them
> >> them attach them after pwmchip_add():
> >>
> [...]
> 
> > 
> > That's the race I was talking about above. I suppose it's not too big an
> > issue since other drivers seem to manage, so I'm going to merge your
> > fixed driver.
> 
> ok thanks !

I've made a few tiny changes (reg -> offset, temporary variable to track
&channels[i], ...) and pushed it all out. Hopefully that now fixes any
of the remaining issues.

> > Unless you feel like taking a stab at the pwm_chip_init()/pwm_chip_add()
> > split, in which case your driver would be the first to be race-free. =)
> 
> Having he driver upstream is a priority, but having it completely
> race-free would be great! I'll be happy to collaborate to a race-free
> pwmchip probe somehow !

Fair enough. I'll do some prototyping and keep you in the loop if I come
up with something that I think will do.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160906/089d2a89/attachment.sig>
