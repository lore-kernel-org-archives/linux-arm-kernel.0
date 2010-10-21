From: simon@sequanux.org (Simon Guinot)
Date: Thu, 21 Oct 2010 21:59:29 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: add generic GPIO fan driver
In-Reply-To: <20101021144346.GA26460@ericsson.com>
References: <1287592646-18109-1-git-send-email-sguinot@lacie.com>
	<1287592646-18109-2-git-send-email-sguinot@lacie.com>
	<20101021064145.GA25095@ericsson.com>
	<20101021140626.GQ29120@kw.sim.vm.gnt>
	<20101021144346.GA26460@ericsson.com>
Message-ID: <20101021215928.GS29120@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

On Thu, Oct 21, 2010 at 07:43:46AM -0700, Guenter Roeck wrote:
> > > 
> > > The combination of DIV_ROUND_UP() and DIV_ROUND_CLOSEST() causes inconsistency.
> > > 
> > > Assume num_speed = 8, pwm is set to 128.
> > > 
> > > set: 128 * (8 - 1) / 255 = 3.513 ==> 4
> > > get: 4 * 255 / (8 - 1) = 145.7 ==> 146
> > > set: 146 * (8 - 1) / 255 = 4.007 ==> 5
> > > get: 5 * 255 / (8 - 1) = 182.142 ==> 182
> > > set: 182 * (8 - 1) / 255 = 4.996 ==> 5
> > > 
> > > Unless there is a really good reason to use DIV_ROUND_UP(), you might
> > > want to use DIV_ROUND_CLOSEST() instead.
> > 
> > This choice is coherent with the rpm interface one and the reason is the
> > same: start the fan even with a low value. In your example, 36 is first
> > speed threshold.
> > 
> Yes, but here it causes an inconsistency between setting and reporting.
> I don't expect the speed to change if I set the same value that was read.
> Exactly this happens if one writes 146 in my example. That is much worse
> than a potential startup problem, or the observation that pwm values below X 
> don't start the fan.

Mmm. Convert a speed index into a low round pwm value (and not use
DIV_ROUND_CLOSEST() at all) fix the inconsistency too. If you agree,
I would prefer this option.

Thanks,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101021/6d57e75b/attachment.sig>
