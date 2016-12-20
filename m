From: joe@perches.com (Joe Perches)
Date: Tue, 20 Dec 2016 09:55:38 -0800
Subject: [PATCH] i2c: uniphier[-f]: fix bool logic calculation
In-Reply-To: <CAK7LNATrR9dSuuUZR98f=uOZqSGqUBnUNZmrUqUZgubHHE+X4A@mail.gmail.com>
References: <1476851911-21729-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNATrR9dSuuUZR98f=uOZqSGqUBnUNZmrUqUZgubHHE+X4A@mail.gmail.com>
Message-ID: <1482256538.1984.23.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-12-21 at 01:20 +0900, Masahiro Yamada wrote:
> Hi.
> 
> I have not got any comment, but does this seem
> a right thing to do?

> This code is working, but it should not depend on how "bool" is
> typedef'ed, or the bit position of I2C_M_RD.

<shrug>

I think bool can be guaranteed to be _Bool.

So a change not necessary as the original code
has a c90 guarantee of the same result.

6.3.1.2 Boolean type
1
When any scalar value is converted to _Bool, the result is 0 if the value compares equal
to 0; otherwise, the result is 1.


> 2016-10-19 13:38 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
[]
> > diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
[]
> > @@ -309,7 +309,7 @@ static int uniphier_fi2c_master_xfer_one(struct i2c_adapter *adap,
> >                                          struct i2c_msg *msg, bool stop)
> >  {
> >         struct uniphier_fi2c_priv *priv = i2c_get_adapdata(adap);
> > -       bool is_read = msg->flags & I2C_M_RD;
> > +       bool is_read = !!(msg->flags & I2C_M_RD);
> >         unsigned long time_left;
> > 
> >         dev_dbg(&adap->dev, "%s: addr=0x%02x, len=%d, stop=%d\n",
