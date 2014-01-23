From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 23 Jan 2014 19:38:02 +0100
Subject: [PATCH V2 03/10] pinctrl: exynos: add exynos5260 SoC specific data
In-Reply-To: <3846194.a18yHpXxuP@wuerfel>
References: <1389099548-14649-1-git-send-email-rahul.sharma@samsung.com>
 <1389099548-14649-4-git-send-email-rahul.sharma@samsung.com>
 <3846194.a18yHpXxuP@wuerfel>
Message-ID: <52E1618A.2040704@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07.01.2014 14:31, Arnd Bergmann wrote:
> On Tuesday 07 January 2014 18:29:01 Rahul Sharma wrote:
>> From: Young-Gun Jang <yg1004.jang@samsung.com>
>>
>> Add Samsung Exynos5260 SoC specific data to enable pinctrl
>> support for all platforms based on EXYNOS5260.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> Signed-off-by: Young-Gun Jang <yg1004.jang@samsung.com>
>> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
>> Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
>
> On a similar note to the comment about the platform patch, I think
> it would be good to extend the DT binding in a way that allows
> you to describe the differences between the SoCs without having
> to change the driver every time a new model comes out.
>
> We still have to maintain backwards compatibility with the
> existing bindings I suppose, but I'd rather not see new ones
> added like this. I realize that there is a tradeoff between
> having too much information in DT when it is always fixed, and
> having too much hardcoded in the driver, and at some point there
> was a conscious decision to do it like this, but I fear the
> tradeoff has changed with the number of EXYNOS implementations
> that really only differ in their pin banks.

There isn't really too much data being added to the driver on per-SoC 
basis. Anyway, I remember that when I was trying to move all the data to 
DT long time ago when refactoring the driver, after a long discussion on 
the ML it was decided that it is not really a good idea and so we have 
the end result as we can see now.

Personally I'd prefer all the static data of struct samsung_pin_bank to 
be located in DT, with each bank having a compatible string that would 
translate to appropriate struct samsung_pin_bank_type, which is common 
across multiple SoCs (basically all >= S5PV210), and parameters such as 
pin-count, control-base, and geint-/weint-base (which would also imply 
interrupt type) - name (which is used only for human readable text) 
could be implied by node names. However that would mean quite 
significant effort (and churn), especially considering the fact that we 
need to maintain compatibility with existing bindings, due to "ABI 
stability" (which I'm slowly losing my faith in), so I don't think it's 
worth it.

So, from me:

Acked-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
