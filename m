From: dianders@chromium.org (Doug Anderson)
Date: Sun, 12 Oct 2014 14:24:06 -0700
Subject: [PATCH v4] i2c: rk3x: adjust the LOW divison based on
 characteristics of SCL
In-Reply-To: <5700320.9GSb6erCFz@typ>
References: <1412837235-4202-1-git-send-email-addy.ke@rock-chips.com>
 <5700320.9GSb6erCFz@typ>
Message-ID: <CAD=FV=XHOuQZPOrVRtoTGN2Yq6E7fuKSa+AM6U_MYKAoZ+nKBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Max,

On Sun, Oct 12, 2014 at 5:10 AM, Max Schwarz <max.schwarz@online.de> wrote:
>> +     /* Adjust to avoid overflow */
>> +     i2c_rate_khz = DIV_ROUND_UP(i2c_rate, 1000);
>> +     scl_rate_khz = DIV_ROUND_UP(scl_rate, 1000);
>
> I'm not really comfortable with using DIV_ROUND_UP on the last line, since
> this may violate the user's set SCL rate. Rounding up 1.1kHz SCL rate to 2kHz
> is not good.

Ah, good point.  So we round up for i2c_rate and down for scl_rate:

  i2c_rate_khz = DIV_ROUND_UP(i2c_rate, 1000);
  scl_rate_khz = scl_rate / 1000;


> I suggest using scl_rate / 1000 and placing a
>
> if(WARN_ON(scl_rate < 1000))
>   scl_rate = 1000;
>
> somewhere to prevent scl_rate_khz from becoming 0.

Ah, makes sense.  Yeah, that should be at the top.
