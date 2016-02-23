From: alexandre.torgue@gmail.com (Alexandre Torgue)
Date: Tue, 23 Feb 2016 10:59:15 +0100
Subject: [PATCH 1/4] net: ethernet: dwmac: add Ethernet glue logic for
 stm32 chip
In-Reply-To: <CAGhQ9VzPTgRqqLi4zjHkP-++v5smZ7s52drev1z-AvgXaLuC7Q@mail.gmail.com>
References: <1454511275-9791-1-git-send-email-alexandre.torgue@gmail.com>
 <1454511275-9791-2-git-send-email-alexandre.torgue@gmail.com>
 <CAGhQ9VypZ5J0pQmrf1Mk-mNsv=XTXu7fhoLt_r2LHJ_Lsyj0yA@mail.gmail.com>
 <CAJgp7zwOVEq=hnxfUt7eHZWSFUAwuK6MCVHdH591=xReRUsW8Q@mail.gmail.com>
 <CAGhQ9VzPTgRqqLi4zjHkP-++v5smZ7s52drev1z-AvgXaLuC7Q@mail.gmail.com>
Message-ID: <CAJgp7zxYhbQ4yQHBB3cu50TU9N9xvk3HxCp0NP5fxFbxrMsD_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-02-22 22:52 GMT+01:00 Joachim  Eastwood <manabian@gmail.com>:
> On 22 February 2016 at 15:50, Alexandre Torgue
> <alexandre.torgue@gmail.com> wrote:
>> 2016-02-13 14:48 GMT+01:00 Joachim  Eastwood <manabian@gmail.com>:
>>> On 3 February 2016 at 15:54, Alexandre TORGUE
>>> <alexandre.torgue@gmail.com> wrote:
>>>> +       plat_dat->bsp_priv = dwmac;
>>>> +       plat_dat->init = stm32_dwmac_init;
>>>> +       plat_dat->exit = stm32_dwmac_exit;
>>>
>>> Instead of using these callbacks could you rather implement the PM
>>> callbacks directly in this driver?
>>> I don't think it should add much code and it will make it look more
>>> like standard driver. This will also give you some more control and
>>> flexibility in your code.
>>
>> I prefer to keep the code as it is. Glue layer is directly linked to
>> stmmac driver and I don't want to brake the link between the glue and
>> the stmmac driver.
>
> What do you mean by break the link?
>

I thought that you wanted to split stmmac_pltfr_supend (glue part and
stmamc part), but I well understood it is not the case (sorry for
mistake).

> There has been numerous of patch sets to make the stmmac "glue"
> drivers into more standard platform drivers.
> http://marc.info/?l=linux-netdev&m=143159850631093&w=2
> http://marc.info/?l=linux-netdev&m=143708560009851&w=2
> http://marc.info/?l=linux-netdev&m=143812136600541&w=2
>
> Do you see any advantage by using the init and exit hooks in your
> driver instead of using the standard driver PM callbacks and remove
> function?
> The only "cost" I see is slightly more boilerplate code. But since you
> already have init/exit functions you could easily make them into PM
> resume/suspend so I doubt there would be much increase in code size.
>

If I well understood you want to continue the stmmac glue driver
rework by moving stmmac_pltfr_suspend/resume/remove in each glue
driver (stm32, sun, sti ....).
Each glue driver will call directly stmmac_suspend/resume/remove and
their own init/exit function.
If it is what you meant, I can do it.

> One other thing;
> Do you need to have the PHY mode setup code in the init function which
> is called each time on resume?

I can't guarantee that after a suspend the sysconfig register will
contain same data than before suspend.

Best regards.

Alex

> If you could move it to probe you could drop the interface priv data
> member and use plat_dat->interface as stmmac_probe_config_dt() has
> already done of_get_phy_mode().
>
>
> regards,
> Joachim Eastwood
