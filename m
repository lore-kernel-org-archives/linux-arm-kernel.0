From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 29 Jun 2015 11:27:27 +0200
Subject: [PATCH v2 2/2] pwm: add MediaTek display PWM driver support
In-Reply-To: <1434635939.22029.7.camel@mtksdaap41>
References: <1432214964-40644-1-git-send-email-yh.huang@mediatek.com>
 <1432214964-40644-3-git-send-email-yh.huang@mediatek.com>
 <20150612102046.GF19400@ulmo.nvidia.com>
 <1434622784.18278.39.camel@mtksdaap41>
 <1434635939.22029.7.camel@mtksdaap41>
Message-ID: <20150629092726.GG5431@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 09:58:59PM +0800, Yingjoe Chen wrote:
> On Thu, 2015-06-18 at 18:19 +0800, YH Huang wrote:
> > On Fri, 2015-06-12 at 12:20 +0200, Thierry Reding wrote:
> > > > +/* Shift log2(PWM_PERIOD_MAX + 1) as divisor */
> > > > +#define PWM_PERIOD_BIT_SHIFT	12
> > > 
> > > I wasn't very clear about this in my earlier review, so let me try to
> > > explain why I think this is confusing. You use this as a divisor, but
> > > you encode it as a shift. It's also PWM_PERIOD_MAX + 1, so I think it
> > > would make more sense to drop this, keep PWM_PERIOD_MAX as above and
> > > then replace the
> > > 
> > > 	>> PWM_PERIOD_BIT_SHIFT
> > > 	
> > > below by
> > > 
> > > 	/ (PWM_PERIOD_MAX + 1)
> > > 
> > 
> > Maybe I can change in this way:
> > Remove this: #define PWM_PERIOD_MAX		0x00000fff
> > Using ">> PWM_PERIOD_BIT_SHIFT" is faster than "/ (PWM_PERIOD_MAX + 1)"
> > Is this right?
> 
> 
> The place which use this shift is:
> 
> 	clk_div = div_u64(rate * period_ns, NSEC_PER_SEC) >> 
> 			  PWM_PERIOD_BIT_SHIFT;
> 
> div_u64 return u64. If we change >> to /, and somehow compiler didn't
> optimize that div into shift, it will cause build error.

Good point. I think every compiler should be able to optimize this, but
the shift isn't any worse than a divide and if we can proactively avoid
portability issues, let's go with the shift.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150629/62cd1c2a/attachment-0001.sig>
