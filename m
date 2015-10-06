From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 6 Oct 2015 09:53:47 +0200
Subject: [PATCH 01/17] ARM: pxa: cm-x300: Use PWM lookup table
In-Reply-To: <87fv1pawu6.fsf@belgarion.home>
References: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
 <1444034997-9805-2-git-send-email-thierry.reding@gmail.com>
 <87fv1pawu6.fsf@belgarion.home>
Message-ID: <20151006075347.GD18633@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 05, 2015 at 10:23:29PM +0200, Robert Jarzmik wrote:
> Thierry Reding <thierry.reding@gmail.com> writes:
> 
> > @@ -305,11 +306,14 @@ static inline void cm_x300_init_lcd(void) {}
> >  #endif
> >  
> >  #if defined(CONFIG_BACKLIGHT_PWM) || defined(CONFIG_BACKLIGHT_PWM_MODULE)
> > +static struct pwm_lookup cm_x300_pwm_lookup[] = {
> > +	PWM_LOOKUP("pxa27x-pwm.0", 1, "pwm-backlight.0", NULL, 10000,
> > +		   PWM_POLARITY_NORMAL),
> > +};
> That looks weird. It was pwm_id = 2, and I can't find the "2" in the statement
> above. I would gladly fix it myself, but I wonder where that "2" should go ...

pwm_id = 2 should be equivalent to the 1 in the second argument of the
PWM_LOOKUP macro (i.e. the PWM index). The rationale for that change is
given in an old commit by Paul Parsons:

	commit 8d6b00f5d639cfc28487ef412589e35b4e6ac7c7
	Author: Paul Parsons <lost.distance@yahoo.com>
	Date:   Fri Oct 19 13:15:30 2012 +0100
	
	    ARM: pxa: hx4700: Fix backlight PWM device number
	
	    Recent changes to PXA PWM support changed the PXA27X PWM device
	    numbering scheme.
	
	    The linux-3.5 PXA PWM driver followed the hardware numbering scheme for
	    the 4 PWMs, while the linux-3.6-rc1 PXA PWM driver has adopted a linear
	    numbering scheme:
	
	    Address             Hardware        3.5 pwm_id      3.6-rc1 pwm_id
	    0x40b00000  PWM0            0               0
	    0x40b00010  PWM2            2               1
	    0x40c00000  PWM1            1               2
	    0x40c00010  PWM3            3               3
	
	    The hx4700 backlight uses PWM1 at 0x40c00000. Consequently the pwm_id
	    must be changed from 1 to 2.
	
	    This patch fixes the backlight PWM device number and at the same time
	    moves from the legacy PWM API (pwm_id) to the new PWM API (pwm_lookup).
	
	    Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
	    Cc: Thierry Reding <thierry.reding@avionic-design.de>
	    Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>

With the lookup tables the situation is somewhat more complicated
because the indices are relative to the provider. The above would
therefore map to something like this:

	Address     Hardware  Device            Index
	0x40b00000  PWM0      pxa2{5,7}x-pwm.0  0
	0x40b00010  PWM2      pxa27x-pwm.0      1
	0x40c00000  PWM1      pxa2{5,7}x-pwm.1  0
	0x40c00010  PWM3      pxa27x-pwm.1      1

Does that clarify the situation?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151006/dfb67962/attachment.sig>
