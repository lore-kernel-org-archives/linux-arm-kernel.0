From: djkurtz@chromium.org (Daniel Kurtz)
Date: Tue, 22 Dec 2015 21:36:30 +0800
Subject: [PATCH] soc: mediatek: SCPSYS: use builtin_platform_driver
In-Reply-To: <CAGS+omA822+-srskZ08pa72xVTMFbWLkaZD0za=3MCBryS6PRg@mail.gmail.com>
References: <1450437573-32079-1-git-send-email-matthias.bgg@gmail.com>
 <CAGS+omA822+-srskZ08pa72xVTMFbWLkaZD0za=3MCBryS6PRg@mail.gmail.com>
Message-ID: <CAGS+omDrZO8PteeFZMes0QRjG2KLhMG=qacFrho+UFPVAG=YXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

One thing below is missing from this version of the patch...

> On Fri, Dec 18, 2015 at 7:19 PM, Matthias Brugger
> <matthias.bgg@gmail.com> wrote:
>> SCPSYS can't be built as module. Use builtin_platform_driver instead.
>> For this probe must not be __init and the data accessed can't be
>> __initconst. Remove this macros. To make the impact as small as possible,
>> fold scp_domain_data into scp_domain via a pointer.

[snip]

>> @@ -542,10 +533,11 @@ static const struct of_device_id of_scpsys_match_tbl[] = {
>>  };
>>
>>  static struct platform_driver scpsys_drv = {
>> +       .probe = scpsys_probe,
>>         .driver = {
>>                 .name = "mtk-scpsys",

This was in Sascha's version of the patch:

  .suppress_bind_attrs = true,

Do we still need it now that we use "builtin_platform_driver"?

>>                 .owner = THIS_MODULE,
>>                 .of_match_table = of_match_ptr(of_scpsys_match_tbl),
>>         },
>>  };
>> -builtin_platform_driver_probe(scpsys_drv, scpsys_probe);
>> +builtin_platform_driver(scpsys_drv);
>> --
>> 2.6.2
>>
