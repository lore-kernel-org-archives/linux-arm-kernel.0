From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 7 Feb 2012 08:04:00 +0100
Subject: [PATCH v2 02/10] pwm: Allow chips to support multiple PWMs.
In-Reply-To: <4F3044A9.8000202@metafoo.de>
References: <1328541585-24642-1-git-send-email-thierry.reding@avionic-design.de>
 <1328541585-24642-3-git-send-email-thierry.reding@avionic-design.de>
 <4F3044A9.8000202@metafoo.de>
Message-ID: <20120207070400.GA29238@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Lars-Peter Clausen wrote:
> On 02/06/2012 04:19 PM, Thierry Reding wrote:
> > This commit modifies the PWM core to support multiple PWMs per struct
> > pwm_chip.
> 
> I think you should mention what motivates this change.

Okay, I can add that.

> > It achieves this in a similar way to how gpiolib works, by
> > allowing PWM ranges to be requested dynamically (pwm_chip.base == -1) or
> > starting at a given offset (pwm_chip.base >= 0).
> 
> If we've learned one thing from gpiolib, I think it is that using a global
> index to identify a resource was a bad idea.

Yes, that concern has been raised several times already. The reason for it
being this way is that the current API requires it. So either we keep it as
is for now and change it over to indexing on a per-chip basis later (which
has the advantage of not breaking anything currently in-tree) or we make that
change now, in which case this patch series will probably double in size. I'm
also not sure if I can reasonably keep the series bisectible that way.

One of the major problems when converting to a non-global namespace is how to
represent the relationship in code. For device tree this should be easy to do
because it has all the infrastructure in place. For non-device-tree devices I
have no idea yet how this could be done. Perhaps by using something like the
clock API and using names for lookup?

> > A chip specifies how
> > many PWMs it controls using the npwm member. Each of the functions in
> > the pwm_ops structure gets an additional argument that specified the PWM
> > number (it can be converted to a per-chip index by subtracting the
> > chip's base).
> > 
> > The total maximum number of PWM devices is currently fixed to 64, but
> > can easily be made configurable via Kconfig.
> 
> The code says 1024.

Right, I missed that. Thanks.

> > The patch is incomplete in that it doesn't convert any existing drivers
> > that are now broken.

I just noticed that this isn't completely valid anymore either since I've
ported two of the drivers. However, The remaining drivers won't work properly
when built against a kernel with PWM framework support because of the
duplicate symbols.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120207/f0c17d08/attachment.sig>
