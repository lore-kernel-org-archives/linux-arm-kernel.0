From: dianders@chromium.org (Doug Anderson)
Date: Mon, 14 Jan 2013 10:52:32 -0800
Subject: [REPOST PATCH 2/2] i2c: pxa: Use i2c-core to get bus number now
In-Reply-To: <50F08E44.3050500@gmail.com>
References: <1353522362-25519-2-git-send-email-dianders@chromium.org>
 <1357927027-4857-1-git-send-email-dianders@chromium.org>
 <1357927027-4857-3-git-send-email-dianders@chromium.org>
 <50F08E44.3050500@gmail.com>
Message-ID: <CAD=FV=WXx6mdj5HBmPcxKPvQ0TeHSwmmzFmwTvrOqZ2qAthvpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester,

Thanks for the review...

On Fri, Jan 11, 2013 at 2:12 PM, Sylwester Nawrocki
<sylvester.nawrocki@gmail.com> wrote:
>> -       ret = of_alias_get_id(np, "i2c");
>> -       if (ret<  0) {
>> -               dev_err(&pdev->dev, "failed to get alias id, errno %d\n",
>> ret);
>> -               return ret;
>> -       }
>> -       pdev->id = ret;
>> +       pdev->id = -1;
>
>
> I think assignments like this are illegal. At this point the device is
> already registered and modifying pdev->id can cause issues at the core
> code.

Good catch.  I think the old code is just as illegal since it was also
assigning to pdev->id, but I'm happy to spin the patch.

> It might be better to have the bus number stored in struct pxa_i2c,
> initialized with pdev->id value for non-dt and now with -1 for dt case.

I'll just init i2c->adap.nr before calling i2c_pxa_probe_dt().  Then
i2c_pxa_probe_dt() can adjust the number.  Hopefully this is OK.

> I realize it is not something your patch is intended to deal with,
> but since you're touching this code maybe it's worth to fix that issue
> as well ?

Sure, I've spun it.  While doing this I realized a few other issues
relating to the ID number.  Specifically:

* We were using the id (as %u) when creating 'i2c->adap.name'.  This
probably gave a very nonsensical ID.  I'm just going to remove the
device number from the adap.name.  That matches what i2c-s3c2410.c
does.  As far as I can tell the adap.name isn't actually used for
much.

* The name was being used in request_irq().  I've changed this to be
like i2c-s3c2410 and use dev_name().  On my current board that means
that the name comes from the table in of_platform_populate().  ...but
that table is supposed to be going away.  If I remove that i2c parts
of that table I get names like '12c60000.i2c', which should be fine
for passing to request_irq().


-Doug
