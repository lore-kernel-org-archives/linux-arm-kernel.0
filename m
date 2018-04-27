From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Apr 2018 21:08:53 +0200
Subject: [PATCH RFC PoC 0/2] platform: different approach to early
 platform drivers
In-Reply-To: <CAMpxmJUovyhsiHByA3MZX5H6AcU4k9shX45Z60NpDkOFTxg_eQ@mail.gmail.com>
References: <20180426152920.21569-1-brgl@bgdev.pl>
 <20180426173151.GJ3094@brightrain.aerifal.cx>
 <6d1f9114-f1d1-961f-4f36-74adff059dc3@lechnology.com>
 <CAK8P3a0oCH7zyBs8nQd4p+xLrFwDQiJsaKKCF1m04nyXsZxk=g@mail.gmail.com>
 <CAMpxmJUR+31axmAe2TNq00aUg40bnC=5k=2cVX019Vncr7cRkw@mail.gmail.com>
 <CAK8P3a2xtTLx-VHVWok-b19=o1z5FbTNcaWq7Y_HSdaH6pWnZg@mail.gmail.com>
 <CAMRc=MdomjLCq-bJyktaToH00kNQAuTLgkSFRrY9Jmre8McT3A@mail.gmail.com>
 <CAK8P3a0tMp2QURp-9WuHehqE0b6-BO1wJ38siTdxhxgwCb-ERw@mail.gmail.com>
 <CAMpxmJVkRDLkpcgzhMb41z=Tp6zvszLd0vqfdTtZBNGT6Trtqw@mail.gmail.com>
 <CAK8P3a22DKpqMGdjYoBzKfNHc2GvAbvaZowZpz=SFeQHVSWjsg@mail.gmail.com>
 <CAMpxmJUovyhsiHByA3MZX5H6AcU4k9shX45Z60NpDkOFTxg_eQ@mail.gmail.com>
Message-ID: <CAK8P3a17xU5m+_X-qWQK+LZq-bt3NnuVCgwzg+C2yYsVrdFhWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 6:05 PM, Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
> 2018-04-27 16:48 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
>> On Fri, Apr 27, 2018 at 4:05 PM, Bartosz Golaszewski
>
> So speaking in pseudo-C we basically have two ways for an imaginary
> future timer driver:
>
> int foo_probe(struct platform_device *pdev)
> {
>     struct clk *clk;
>
>     if (probing_early(pdev)) {
>         clk = devm_clk_get(dev, "earlyclock");
>
>        /* Do early stuff. */
>         return 0;
>     }
>
>     /* Do late stuff. */
>
>     return 0;
> }
>
>     --- vs ---
>
> int foo_probe(struct platform_device *pdev)
> {
>     /* Do late stuff. */
>
>     return 0;
> }
>
> static int foo_init(struct device_node *np)
> {
>     struct clk *clk;
>     struct device *dev = device_from_device_node(np);
>
>     /* Do early stuff. */
>     clk = devm_clk_get(dev, "earlyclock");
>
>     return 0;
> }
>
> TIMER_OF_DECLARE(foo, "bar,foo", foo_init);
>
> I still believe the first approach is easier to implement and has the
> added benefit of supporting board files.

Right. I still like the second approach better, since it avoids
multiplexing two very different code paths into a single
function, and because it's closer to what everyone is used
to at the moment.

Prototyping both is probably helpful to get a better idea
of the actual complexity this introduces.

> I'll give it a thought and will be back at it next week.

Ok. I'll be on vacation for three weeks so I wont' be able
to reply on the new patches.

       Arnd
