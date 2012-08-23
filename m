From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 23 Aug 2012 21:04:02 +0200
Subject: [PATCH] pwm: Call pwm_enable() before pwm_config()
In-Reply-To: <50366628.5020007@metafoo.de>
References: <36966374.2768747.1345741025741.JavaMail.root@advansee.com>
 <50366464.4070801@metafoo.de> <50366628.5020007@metafoo.de>
Message-ID: <20120823190402.GA8127@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2012 at 07:19:36PM +0200, Lars-Peter Clausen wrote:
> On 08/23/2012 07:12 PM, Lars-Peter Clausen wrote:
> >[...]
> > Or maybe just use the runtime pm API for this. This probably makes even more
> > sense and grab a reference to the pm context when the enable() is called,
> > release it when disable() is called and also grab it before calling the
> > device's config callback and release it afterward.
> 
> Btw. this seems to be exactly what the pwm-tiecap and pwm-tiehrpwm drivers
> already do today. I'd just make that a core PWM framework feature.

Using runtime PM for this sounds indeed like the most generic approach.
I'm not very familiar with the API, but I thought it required explicit
architecture or bus support (or the driver itself can provide hooks via
pm_ops), so it might be difficult to implement for platforms that don't
have working runtime PM support. I'll have to look into this some more.

Anyway, if we add this kind of support to the PWM core we should take it
through next first. For drivers that are currently broken, they should
be, as you said, fixed by enabling the clock before reconfiguring and
disable it after (unless the PWM is enabled) like Tegra does.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120823/a1ac7c74/attachment.sig>
