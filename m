From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 18 May 2018 09:21:09 +0200
Subject: [PATCH 4/4] omap4-droid4: Use software debounce for gpio-keys
In-Reply-To: <20180517233542.30629-5-tony@atomide.com>
References: <20180517233542.30629-1-tony@atomide.com>
 <20180517233542.30629-5-tony@atomide.com>
Message-ID: <20180518072109.GA31304@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> The default value of 5ms will use GPIO hardware based debounce clocks
> that will keep L4PER from idling consuming about extra 30mW.
> 
> Use a value of 10ms that is above the hardware debounce maximum of
> 7.95ms forcing software based debouncing.
> 
> This allows droid4 to enter PER retention during idle as long as UARTs
> are idled and USB modules unloaded or unbound.
> 
> Note that there seems to be a pending issue with having droid 4 enter core
> retention during idle where GPIO bank 1 needs to be reset late after init
> for some reason to not block core retention. In addition to that, we are
> also missing GPIO related PM runtime calls for omap4 that will be posted
> separately.

Thanks, will take a look.

BTW, did you notice that debouncing is wrong on most of the keyboard?
If you double click a key (most will do, for example "J") it will fail
to recognize second release and instead of expected "jj", you get
autorepeat ("jjjjjjjjjjjjjjjjjjjjjj...").

Ok, I guess main keyboard is not on GPIO...

Best regards,

								Pavel

> @@ -128,6 +128,7 @@
>  			gpios = <&gpio5 26 GPIO_ACTIVE_LOW>; /* gpio154 */
>  			linux,code = <KEY_VOLUMEDOWN>;
>  			linux,can-disable;
> +			debounce-interval = <10>;

I'd say this subtlety is worth a comment.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180518/a68804eb/attachment.sig>
