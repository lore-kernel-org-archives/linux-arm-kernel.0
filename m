From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 22 Oct 2009 04:20:34 +0800
Subject: spitz backlight: fix brightness limiting
In-Reply-To: <20091019213751.GC1482@ucw.cz>
References: <20091019213751.GC1482@ucw.cz>
Message-ID: <f17812d70910211320s29d3aaa5tad3206df1e99e03b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's a little bit weird it's called 'limit_mask' when I first converted it
to a spi driver. There must be some reasons, Richard, you've got
any ideas?

On Tue, Oct 20, 2009 at 5:37 AM, Pavel Machek <pavel@ucw.cz> wrote:
>
> On spitz (& similar) machines, if battery is running low, backlight
> needs to be limited to lower step. Unfortunately, current code uses &=
> for limiting, turning backlight off completely for some backlight
> settings. Fix that.
>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>
> --- linux-rc/drivers/video/backlight/corgi_lcd.c ? ? ? ?2009-10-18 18:11:36.000000000 +0200
> +++ linux-rc/drivers/video/backlight/corgi_lcd.c ? ? ? ?2009-10-16 02:10:13.000000000 +0200
> @@ -433,8 +434,9 @@
>
> ? ? ? ?if (corgibl_flags & CORGIBL_SUSPENDED)
> ? ? ? ? ? ? ? ?intensity = 0;
> - ? ? ? if (corgibl_flags & CORGIBL_BATTLOW)
> - ? ? ? ? ? ? ? intensity &= lcd->limit_mask;
> +
> + ? ? ? if ((corgibl_flags & CORGIBL_BATTLOW) && intensity > lcd->limit_mask)
> + ? ? ? ? ? ? ? intensity = lcd->limit_mask;
>
> ? ? ? ?return corgi_bl_set_intensity(lcd, intensity);
> ?}
>
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>
