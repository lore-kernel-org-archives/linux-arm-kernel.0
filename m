From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Mar 2016 10:05:18 +0100
Subject: [PATCH 1/6] rtc: generic: allow building on all architectures
In-Reply-To: <CAMuHMdW5+jZ1n9WnCwBrGSGjUa8ziNTTqf-H15EFTQC_iwnw+Q@mail.gmail.com>
References: <1456851608-3374907-1-git-send-email-arnd@arndb.de>
 <1456851608-3374907-2-git-send-email-arnd@arndb.de>
 <CAMuHMdW5+jZ1n9WnCwBrGSGjUa8ziNTTqf-H15EFTQC_iwnw+Q@mail.gmail.com>
Message-ID: <1620536.OtjnSSLgCT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 March 2016 09:57:27 Geert Uytterhoeven wrote:
> > @@ -33,13 +35,21 @@ static const struct rtc_class_ops generic_rtc_ops = {
> >         .read_time = generic_get_time,
> >         .set_time = generic_set_time,
> >  };
> > +#else
> > +#define generic_rtc_ops *(struct rtc_class_ops*)NULL
> > +#endif
> >
> >  static int __init generic_rtc_probe(struct platform_device *dev)
> >  {
> >         struct rtc_device *rtc;
> > +       const struct rtc_class_ops *ops;
> > +
> > +       ops = dev_get_platdata(&dev->dev);
> > +       if (!ops)
> > +               ops = &generic_rtc_ops;
> 
> I hope no compiler version treats "&*(struct rtc_class_ops*)NULL" as
> undefined behavior?

It's a bit odd, but I think it's syntactically correct C, and not
much too different from 

#define offsetof(TYPE, MEMBER)  ((size_t)&((TYPE *)0)->MEMBER)

is it? My last patch gets rid of it again.

	Arnd
