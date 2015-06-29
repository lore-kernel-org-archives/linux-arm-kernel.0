From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 29 Jun 2015 11:21:47 +0200
Subject: [PATCH v2 2/2] pwm: add MediaTek display PWM driver support
In-Reply-To: <1434622784.18278.39.camel@mtksdaap41>
References: <1432214964-40644-1-git-send-email-yh.huang@mediatek.com>
 <1432214964-40644-3-git-send-email-yh.huang@mediatek.com>
 <20150612102046.GF19400@ulmo.nvidia.com>
 <1434622784.18278.39.camel@mtksdaap41>
Message-ID: <20150629092145.GF5431@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 06:19:44PM +0800, YH Huang wrote:
> On Fri, 2015-06-12 at 12:20 +0200, Thierry Reding wrote:
> > On Thu, May 21, 2015 at 09:29:24PM +0800, YH Huang wrote:
[...]
> > > +#define DISP_PWM_CON_1		0x14
> > > +#define PWM_PERIOD_MASK		0xfff
> > > +#define PWM_PERIOD_MAX		0x00000fff
> > 
> > Same here. PWM_PERIOD_MAX isn't actually used anywhere, so perhaps just
> > drop it altogether. But see also below...
> > 
> > > +/* Shift log2(PWM_PERIOD_MAX + 1) as divisor */
> > > +#define PWM_PERIOD_BIT_SHIFT	12
> > 
> > I wasn't very clear about this in my earlier review, so let me try to
> > explain why I think this is confusing. You use this as a divisor, but
> > you encode it as a shift. It's also PWM_PERIOD_MAX + 1, so I think it
> > would make more sense to drop this, keep PWM_PERIOD_MAX as above and
> > then replace the
> > 
> > 	>> PWM_PERIOD_BIT_SHIFT
> > 	
> > below by
> > 
> > 	/ (PWM_PERIOD_MAX + 1)
> > 
> 
> Maybe I can change in this way:
> Remove this: #define PWM_PERIOD_MAX		0x00000fff
> Using ">> PWM_PERIOD_BIT_SHIFT" is faster than "/ (PWM_PERIOD_MAX + 1)"
> Is this right?

The compiler should be able to optimize the division to a shift, so both
will likely result in the same code. But I don't mind much either way as
long as we don't define two symbols for essentially the same value.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150629/bf3a6421/attachment.sig>
