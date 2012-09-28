From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 28 Sep 2012 22:29:23 +0800
Subject: [PATCH 6/6] pinctrl: sirf: enable the driver support new
 SiRFmarco SoC
In-Reply-To: <CACRpkdYT2TZX8cchPk+H4LkdVXw861BBTn1dbnSJO-ZQVT5sdw@mail.gmail.com>
References: <1348739790-21253-1-git-send-email-Barry.Song@csr.com>
 <CACRpkdYT2TZX8cchPk+H4LkdVXw861BBTn1dbnSJO-ZQVT5sdw@mail.gmail.com>
Message-ID: <CAGsJ_4wqaii9=8C8rXftzjYcPa95_Djf=uOfZZEKV-zz-ky0QQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi linus,
thanks very much!

2012/9/28 Linus Walleij <linus.walleij@linaro.org>:
> On Thu, Sep 27, 2012 at 11:56 AM, Barry Song <Barry.Song@csr.com> wrote:
>
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> The driver supports old up SiRFprimaII SoCs, this patch makes it support
>> the new SiRFmarco as well.
>> SiRFmarco, as a SMP SoC, adds new SIRFSOC_GPIO_PAD_EN_CLR registers, to
>> disable GPIO pad, we should write 1 to the corresponding bit in the new
>> CLEAR register instead of writing 0 to SIRFSOC_GPIO_PAD_EN.
>>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>
> This doesn't apply to my tree, you must have some other changes that
> are not included in the patch set...
>
> Can you pls try to generate and test the patch against the pinctrl tree?
>
> I might apply it as per the "new driver" rule if I can convince myself that it
> doesn't destabilize the current driver.

this one actually depends on:

http://git.kernel.org/?p=linux/kernel/git/arm/arm-soc.git;a=commitdiff;h=056876f6c73406c06d530d16d020177f5ec4a0bd
which was applied to arm soc tree.

the only conflict comes from:
 static const struct of_device_id pinmux_ids[] __devinitconst = {
        { .compatible = "sirf,prima2-pinctrl" },
+       { .compatible = "sirf,marco-pinctrl" },
        {}
 };

as commit 056876f6c73406c0 renamed the old
static const struct of_device_id pinmux_ids[] __devinitconst = {
        { .compatible = "sirf,prima2-gpio-pinmux" },
        {}
};
to
static const struct of_device_id pinmux_ids[] __devinitconst = {
        { .compatible = "sirf,sirf,prima2-pinctrl" },
        {}
};

so i think the best way is we hold on this patch for the moment, and
wait for 3.7-rc1.
all other 5 are critical fixes and have no merge conflict with arm-soc
tree as i have tried.

> Yours,
> Linus Walleij

Thanks
barry
