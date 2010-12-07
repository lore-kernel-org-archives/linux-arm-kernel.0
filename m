From: charu@ti.com (Varadarajan, Charulatha)
Date: Tue, 7 Dec 2010 12:38:08 +0530
Subject: [PATCH v8 10/11] OMAP: GPIO: Implement GPIO as a platform device
In-Reply-To: <AANLkTinBAJmtn7=Nm75kEWrUxBOKFSi4Mf08mqn0W9X8@mail.gmail.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com>
	<1290689318-10191-11-git-send-email-charu@ti.com>
	<AANLkTin1rehDSfvEvjZJB8VZP8RrXsVKA8wH-WEODLTN@mail.gmail.com>
	<AANLkTinBAJmtn7=Nm75kEWrUxBOKFSi4Mf08mqn0W9X8@mail.gmail.com>
Message-ID: <AANLkTikPey17e6wTHJ2zq8N=r_pNKXV4YjVbTK5e+tYt@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 7, 2010 at 11:05, Varadarajan, Charulatha <charu@ti.com> wrote:
> Cory,
>
> On Tue, Dec 7, 2010 at 10:49, Cory Maccarrone <darkstar6262@gmail.com> wrote:
>> On Thu, Nov 25, 2010 at 4:48 AM, Varadarajan, Charulatha <charu@ti.com> wrote:
>
> <<snip>>
>
>>> @@ -1642,6 +1502,13 @@ static int gpio_debounce(struct gpio_chip *chip, unsigned offset,
>>> ? ? ? ?unsigned long flags;
>>>
>>> ? ? ? ?bank = container_of(chip, struct gpio_bank, chip);
>>> +
>>> + ? ? ? if (!bank->dbck) {
>>> + ? ? ? ? ? ? ? bank->dbck = clk_get(bank->dev, "dbclk");
>>> + ? ? ? ? ? ? ? if (IS_ERR(bank->dbck))
>>> + ? ? ? ? ? ? ? ? ? ? ? dev_err(bank->dev, "Could not get gpio dbck\n");
>>> + ? ? ? }
>>> +
>>
>> I'm testing this on omap7xx, which doesn't have a dbclk. ?Even with
>> dbck_flag set to false, this code still runs, causing these messages
>> to show up:
>
> Thanks for testing this series on OMAP7xx.
>
>>
>> ? ?omap_gpio omap_gpio.5: Could not get gpio dbck
>> ? ?omap_gpio omap_gpio.6: Could not get gpio dbck
>>
>> I think that 'if' should be:
>>
>> ? ?if (bank->dbck_flag && !bank->dbck) {
>
> You are right. Will send a patch now.
>
>>
>> Also, see my comments in patch 4 - OMAP7xx: GPIO: Introduce support
>> for GPIO init, as there's dbck_flag entries there that are needed for
>> omap7xx. ?Otherwise, seems to work well.

I noticed that gpio_debounce() calls _set_gpio_debounce() which is
handling only OMAP2+.
Hence I guess this should not be called for OMAP7xx at all. Now sure
how it was working earlier.

Anyways I can send the patch to fix the above mentioned warning.
Handling debounce feature
for OMAP1 needs to be fixed. I do not have a OMAP1 board here to fix
and verify the same.

>
