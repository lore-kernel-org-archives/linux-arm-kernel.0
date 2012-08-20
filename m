From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarh)
Date: Mon, 20 Aug 2012 16:43:00 +0200
Subject: [PATCH 02/11] pinctrl: mvebu: dove pinctrl driver
In-Reply-To: <CACRpkda9BL5+NiDOsMKG0kv2coBsw=Er=ZccXnNkgeftV9hPhQ@mail.gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>	<1344689809-6223-3-git-send-email-sebastian.hesselbarth@gmail.com>
 <CACRpkda9BL5+NiDOsMKG0kv2coBsw=Er=ZccXnNkgeftV9hPhQ@mail.gmail.com>
Message-ID: <50324CF4.7060304@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2012 03:43 PM, Linus Walleij wrote:
>>   config PINCTRL_MVEBU
>>          bool "Marvell SoC pin controller drivers"
>> -       depends on ARCH_MVEBU
>> +       depends on ARCH_MVEBU || ARCH_DOVE
>
> Hmmmm.
>
> Shouldn't this thing rather be:
> depends on PLAT_ORION
> else you end up lining up all Marvell machines here...
 > (...)
 >> +config PINCTRL_DOVE
 >> +       bool "Support for Marvell Dove SoCs"
 >> +       depends on PINCTRL_MVEBU
 >
 > Shouldn't this rather be:
 >
 > depends on ARCH_DOVE
 > select PINCTRL_MVEBU
 >
 > since you call down into the mvebu driver, it definatley needs
 > to select that.

Yes, this is a bit difficult but PLAT_ORION is basically all existing
Marvell SoCs of the Orion family. Armada 370/XP are two new SoCs
_and_ the approach to combine all into one mach-mvebu. The pinctrl
driver will only be made available to mach-mvebu as I am already close
to have at least mach-dove ported over.

After the review of Andrew, I already changed the Kconfig to have the 
structure you are proposing.

>> +#define  DOVE_AU0_AC97_SEL             (1<<  16)
>
> It is way cleaner to say:
> #include<linux/bitops.h>
> #define  DOVE_AU0_AC97_SEL             BIT(16)

Ok.

> Same comments about the magic numbers as in the review of the first
> patch.

I just agree with all of these comments and will work them in.

>> +       if (ctrl->pid == 24)
>> +               mask = DOVE_CAM_GPIO_SEL;
>> +       else if (ctrl->pid == 40)
>> +               mask = DOVE_SD0_GPIO_SEL;
>> +       else if (ctrl->pid == 46)
>> +               mask = DOVE_SD1_GPIO_SEL;
>> +       else if (ctrl->pid == 58)
>> +               mask = DOVE_SPI_GPIO_SEL;
>> +       else if (ctrl->pid == 62)
>> +               mask = DOVE_UART1_GPIO_SEL;
>> +       else
>> +               return -EINVAL;
>
> Magic numbers, atleast provide a comment on what is so special about
> these pins, and can you use a switch() statement instead?

Sure.

>> +static int dove_audio1_ctrl_gpio_req(struct mvebu_mpp_ctrl *ctrl, u8 pid)
>> +{
>> +       unsigned long config;
>> +
>> +       dove_audio1_ctrl_get(ctrl,&config);
>> +
>> +       switch (config) {
>> +       /* mode 0x00 i2s1/spdifo : no gpio */
>> +       /* mode 0x0c ssp/spdifo  : no gpio */
>> +       /* mode 0x0f ssp/twsi    : no gpio */
>> +       case 0x00:
>> +       case 0x0c:
>> +       case 0x0f:
>> +               return -ENOTSUPP;
>
> Nice with the comments (also before the function),
> now I understand what's happening, this is pretty OK,
> I would have put the comments on the same
> line as the magic number but whatever.
>
> However you could just delete these lines and let them
> fall through to -ENOTSUPP at the bottom.

Ok.

>> +/* mpp[52:57] has gpio pins capable of in and out */
>> +static int dove_audio1_ctrl_gpio_dir(struct mvebu_mpp_ctrl *ctrl, u8 pid,
>> +                               bool input)
>> +{
>> +       return 0;
>> +}
>
> So should this not return a -ENOTSUPP for
> pin<  52 || pin>  57?

Well, as pinctrl-mvebu and pinctrl core are already checking for pin
ranges, I think it's ok not to do it here again. But I don't have a
strong opinion about that.

>> +       /*
>> +        * General MPP Configuration Register is part of pdma registers.
>> +        * grab clk to make sure it is clocked.
>> +        */
>> +       pdma_clk = clk_get_sys("dove-pdma", NULL);
>
> First there is something really weird with the name of this
> clock. Atleast call the variable holding the clk something
> apropriate like just "clk".
>
> Second why are you fetching a sys clock instead of using the clkdev
> device binding in the clock tree so you could say:
>
> clk = clk_get(&pdev->dev, NULL);

pdma is the name of the clock gating control bit used in DS, IIRC it
stands for Peripheral DMA. Moreover, as I already mentioned it is now
using devm_clk_get. I think the time the pinctrl-dove driver patch was
posted there was no clock binding in 3.6.

>> +static int __devexit dove_pinctrl_remove(struct platform_device *pdev)
>> +{
>> +       int ret;
>> +
>> +       ret = mvebu_pinctrl_remove(pdev);
>> +       if (!IS_ERR(pdma_clk)) {
>> +               clk_disable_unprepare(pdma_clk);
>> +               clk_put(pdma_clk);
>> +       }
>
> You don't need this (!IS_ERR()) clause, look in yout probe function:
> you bail out if the clock is not found.

Agree.

Sebastian
