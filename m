From: kyungmin.park@samsung.com (Kyungmin Park)
Date: Fri, 2 Dec 2011 17:57:35 +0900
Subject: backlight/ld9040.c: regulator control in the lcd driver
In-Reply-To: <CACRpkdbRdtsw-3FXtevuJL7G=tcE+1s11iRw=zou1G25hufBSA@mail.gmail.com>
References: <000c01ccb0c6$697c2aa0$3c747fe0$%lee@samsung.com>
 <CACRpkdbRdtsw-3FXtevuJL7G=tcE+1s11iRw=zou1G25hufBSA@mail.gmail.com>
Message-ID: <CAH9JG2XdDn26ziceug6-Dc8g3+z3AUuzL34-oHRy10qL2RjF2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/2/11, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Dec 2, 2011 at 8:45 AM, leedonghwa <dh09.lee@samsung.com> wrote:
>
> [From your mail headers]
>> X-Mailer: Microsoft Office Outlook 12.0
>
> No please. That mailer does not work, all your whitespace is screwed up.
> Consult: Documentation/email-clients.txt
>
>> This patch supports regulator power control in the driver.
>
> Always CC the regulator maintainers on patches like this please.
>
>> +         lcd->reg_vdd3 = regulator_get(lcd->dev, "vdd");
>> +         if (IS_ERR(lcd->reg_vdd3)) {
>> +                   dev_info(lcd->dev, "no %s regulator found\n", "vdd");
>> +                   lcd->reg_vdd3 = NULL;
>> +         }
>> +
>> +         lcd->reg_vci = regulator_get(lcd->dev, "vci");
>> +         if (IS_ERR(lcd->reg_vci)) {
>> +                   dev_info(lcd->dev, "no %s regulator found\n", "vci");
>> +                   lcd->reg_vci = NULL;
>> +         }
>
> As explained in earlier discussion with Mark regarding the SMSC911x
> driver regulator, treat these as errors and do not fail
> "gracefully" like this.
>
> Reference:
> http://marc.info/?l=linux-netdev&m=131914562120725&w=2

As mentioned at commit message, the lcd regulator is optional part and
refer the mmc codes

        host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
        if (IS_ERR(host->vmmc)) {
                pr_info("%s: no vmmc regulator found\n", mmc_hostname(mmc));
                host->vmmc = NULL;
        } else {
                regulator_enable(host->vmmc);
        }

Previous time, these codes are located at board file, but more boards
are used, it has same codes for all boards. so move it to drivers.

In our case, it has the regulator but some boards don't.

Umm then how to handle the regulator gracefully?

Thank you,
Kyungmin Park

>
> Yours,
> Linus Walleij
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
