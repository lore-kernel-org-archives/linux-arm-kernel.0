From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 3 Nov 2010 15:14:47 +0100
Subject: [PATCH] ARM amba: optional PrimeCell core voltage switch
In-Reply-To: <AANLkTimPH7KHZrTtdGSSno7zz7tH56KCbYjoJibK=WwL@mail.gmail.com>
References: <1288778988-11041-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTimPH7KHZrTtdGSSno7zz7tH56KCbYjoJibK=WwL@mail.gmail.com>
Message-ID: <4CD16E57.5070708@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sundar wrote:
> On Wed, Nov 3, 2010 at 3:39 PM, Linus Walleij
> <linus.walleij@stericsson.com> wrote:
>> +static int amba_get_enable_vcore(struct amba_device *pcdev)
>> +{
>> +       struct regulator *vcore = regulator_get(&pcdev->dev, "vcore");
>> +       int ret;
>> +
>> +       pcdev->vcore = vcore;
>> +
>> +       if (IS_ERR(vcore)) {
>> +               /* It is OK not to supply a vcore regulator */
>> +               if (PTR_ERR(vcore) == -ENODEV)
>> +                       return 0;
>> +               return PTR_ERR(vcore);
>> +       }
> 
> If i am right, you corrupt the pcdev->vcore even in an error case.

Yeah that's the intention. It's modeled on the clock code that
does the same thing, then in the disable_put function and
helper macros in bus.h we account for the error case.

I would have set it to NULL instead, but I wanted it to be as
close to the clock code as possible.

Thanks!
Linus Walleij
