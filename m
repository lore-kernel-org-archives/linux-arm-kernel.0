From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 9 Mar 2017 23:53:17 +0100
Subject: [PATCH 1/2] iio: adc: break out common code from SPMI VADC
In-Reply-To: <45774a73-2054-44d7-a72f-94279ec7920c@kernel.org>
References: <20170223133016.4650-1-linus.walleij@linaro.org>
 <45774a73-2054-44d7-a72f-94279ec7920c@kernel.org>
Message-ID: <CACRpkdYnrm+8Pc5zT2uVjyLQt8PcwxuGboPURUkFZzTd2xkPBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 25, 2017 at 6:37 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> This still has the same issue my suggestion did.
> If I were to hazard a guess, something stopped you building both
> modules in when testing.  I tweaked the mfd kconfig so I could.

I added a patch for this too, somehow I still fail to get the right
coverage, sorry. :(

> Otherwise, a testing build on a platform with the spmi driver
> doing allyes will having this issue (which is unlikely to be hit
> terribly soon in test builds ;)
>
> Anyhow, still get:
>
> drivers/iio/adc/qcom-pm8xxx-xoadc.o: In function `qcom_vadc_decimation_from_dt':
> (.text+0x192): multiple definition of `qcom_vadc_decimation_from_dt'
> drivers/iio/adc/qcom-spmi-vadc.o:(.text+0x192): first defined here
> drivers/iio/adc/qcom-pm8xxx-xoadc.o: In function `qcom_vadc_scale':
> (.text+0x4a): multiple definition of `qcom_vadc_scale'
> drivers/iio/adc/qcom-spmi-vadc.o:(.text+0x4a): first defined here
> make[3]: *** [scripts/Makefile.build:446: drivers/iio/adc/built-in.o] Error 1
> make[2]: *** [scripts/Makefile.build:551: drivers/iio/adc] Error 2
> make[1]: *** [scripts/Makefile.build:551: drivers/iio] Error 2
> make: *** [Makefile:988: drivers] Error 2
>
> Because in the both build in we build the same symbol in twice.

I discussed this with Arnd and it seems to be the case that I have
to provide EXPORTs for the symbols to get anywhere with this.
Fixing it up and also changing some stuff about the driver that I
discussed in person with Bj?rn.

> Note there are some static's missing this first patch that should be
> there as well so please clean those up in any new posting.

I'll go over it, also added an inclusion guard.

Yours,
Linus Walleij
