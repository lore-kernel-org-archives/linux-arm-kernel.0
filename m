From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 20 Nov 2014 12:34:00 +0100
Subject: [PATCH v4 1/2] ARM: keystone: pm: switch to use generic pm domains
In-Reply-To: <2900095.WIocOu7ue2@wuerfel>
References: <1415631557-22897-1-git-send-email-grygorii.strashko@ti.com>
 <1709760.E0jX3Myv0h@wuerfel> <546C7FDD.7030906@ti.com>
 <2900095.WIocOu7ue2@wuerfel>
Message-ID: <CAPDyKFqeZ3YU2OEN4tCOdcQ0pAho67Q8U_eCEOroG9aS0mp+-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 November 2014 14:47, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 19 November 2014 13:32:45 Grygorii Strashko wrote:
>> On 11/18/2014 09:32 PM, Arnd Bergmann wrote:
>> > On Tuesday 18 November 2014 20:54:36 Grygorii Strashko wrote:
>> >
>> > Have one pmdomain driver in the generic code that knows about clocks,
>> > possibly also regulators and pins and just turns them on when needed.
>> > You can have a "simple-pmdomain" or "generic-pmdomain" compatible
>> > string.
>> >
>> > I'm a bit surprised that your pmdomain code looks up the clocks from the
>> > respective device, rather than know about the clocks itself. There is
>> > probably a good reason for this, but I don't see it yet.
>>
>> The keystone 2 uses simple PM schema based on clocks only:
>> - clocks enabled -> dev is active
>> - clocks disabled -> dev is suspended
>>
>> To achieve explained above the Generic clock manipulation PM callbacks framework (pm_clk) is used.
>> - list of managed clocks is filled for each device (for non-DT case the con_id list
>>   is specified by platform code like:
>>       .con_ids = { "fck", "master", "slave", NULL },
>>         - or -
>>       .con_ids = { }, <-- in this case only first clock will be added to pm_clk
>>   )

According to earlier comments in this thread, device's clocks are
split into "functional" and "PM" clocks.

If I understand correctly, a typical platform driver will enable it's
"functional" clocks during ->probe() and you want the PM domain to
take care of the "PM" clocks, when the device changes runtime PM
status.

How will you describe these different set of device clocks in DT?

[...]

>
> Yes, it would definitely solve the problem that I see with the infrastructure
> code that the current version adds into the platform directory.
>
> The exact binding of course should be reviewed by the pmdomain and
> DT maintainers, to ensure that it is done the best possible way, because
> I assume we will end up using it a lot, and it would be a shame to get
> it slightly wrong.
>
> One possible variation I can think of would be to just use "simple-pmdomain"
> as the compatible string, and use properties in the node itself to decide
> what the domain should control, e.g.
>
>         clk_pmdomain: pmdomain {
>                 compatible = "simple-pmdomain";
>                 pmdomain-enable-clocks;
>                 #power-domain-cells = <0>;
>         };
>         clk_regulator_pmdomain: pmdomain {
>                 compatible = "simple-pmdomain";
>                 pmdomain-enable-clocks;
>                 pmdomain-enable-regulators;
>                 #power-domain-cells = <0>;
>         };
>
> and then have each device link to one of the nodes as the pmdomain.
>

That's seems like a good approach to me.

Kind regards
Uffe
