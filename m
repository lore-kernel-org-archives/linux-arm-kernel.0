From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Sep 2014 17:22:40 +0200
Subject: [PATCH] rtc: pcf8563: fix uninitialized use warning
In-Reply-To: <540D8CA8.5020104@cogentembedded.com>
References: <3640058.m4Rfp1dmTJ@wuerfel> <540D8CA8.5020104@cogentembedded.com>
Message-ID: <10094879.uvjB4Q3B81@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 September 2014 15:02:00 Sergei Shtylyov wrote:
> > diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
> > index 5a197d9dc7e7..3a6f994c4da8 100644
> > --- a/drivers/rtc/rtc-pcf8563.c
> > +++ b/drivers/rtc/rtc-pcf8563.c
> > @@ -167,7 +167,7 @@ static irqreturn_t pcf8563_irq(int irq, void *dev_id)
> >       char pending;
> >
> >       err = pcf8563_get_alarm_mode(pcf8563->client, NULL, &pending);
> > -     if (err < 0)
> > +     if (err)
> >               return err;
> 
>     Returning negative values from the IRQ handler doesn't seem valid.
> Arbitrary positive value aren't good either. Perhaps should return IRQ_NONE 
> instead?

Good point. This is unrelated to the problem I was trying to fix, but it
seems like a good idea to fix both.

	Arnd
