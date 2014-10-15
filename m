From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 15 Oct 2014 18:43:40 +0300
Subject: [PATCH 1/3] video: fbdev: omap2: omapfb: remove __exit annotation
In-Reply-To: <20141015144140.GD10888@saruman>
References: <1413311335-25083-1-git-send-email-balbi@ti.com>
 <543E64EE.4070104@ti.com> <20141015144140.GD10888@saruman>
Message-ID: <543E962C.2050505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/10/14 17:41, Felipe Balbi wrote:

>> Interesting. I don't know if I'm doing something funny, but without this
>> patch, I can unbind omapfb, kind of.
>>
>> "echo omapfb > unbind" goes ok, but remove is obviously not called.
> 
> remove isn't called because it won't exist if it's built-in. Look at the
> definition of __exit_p()

Yes, that's what I meant with "obviously".

>> Somehow omapfb device is still unbound from the driver, as I can then
>> bind it again, causing probe to be called. Which breaks everything.
>>
>> I would've thought that unbinding is not possible if remove is missing,
>> but that doesn't seem to be the case. I guess it just means that remove
>> is not called when the driver & device are unbound.
> 
> if no remove it provided on platform_driver structure, platform bus
> assumes you have nothing to do on your ->remove(), so you end up leaking
> all resources you allocated on ->probe() (unless you *really* don't need
> to do anything on ->remove).

Yep. That's quite odd, still. grep shows quite many uses of __exit_p(),
and all for remove callback. So, if you have something to release in
remove(), you should set it always, for both module and built-in. And if
you don't have anything to release, you would always just set .release
to NULL.

I mean, what's the use case for __exit_p()? With a quick glance, at
least some of the other users also use __exit_p() the same way omapdss
does (i.e. in the wrong way).

>> We have 18 __exit_p()s in omapdss and related drivers. I guess they are
>> all broken the same way.
> 
> yup, I should've grepped.
> 
>> Note that omapfb unbind & bind does not work even with this patch, but
>> results in a crash as some old state is left into omapdss. The same
>> happens also with unloading and loading omapfb module (but keeping
>> omapdss module loaded).
> 
> It worked fine for me. I unbound and bound omapfb multiple times.

Hmm, ok. Odd, the bug was quite clear and I think it should happen every
time. Well, I was using omap4. If you used AM4xx, that's basically omap3
DSS. Maybe there's a diff there.

>> So there seems to be more issues around this.
> 
> quite a few more, I'd say

Yep, I'll have a look at this.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141015/93a1841a/attachment.sig>
