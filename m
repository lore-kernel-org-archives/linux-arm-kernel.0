From: saeed.bishara@gmail.com (saeed bishara)
Date: Wed, 6 Jul 2011 19:32:44 +0300
Subject: plat-orion multi purpose pins problem for mv78200
In-Reply-To: <20110706161823.GB22857@kw.sim.vm.gnt>
References: <4E0E1CA8.7090200@drewtech.com>
	<20110702122344.GJ31228@kw.sim.vm.gnt>
	<CAMAG_eexDoKrPsrd7+3bpsN3y0pptqwhFRP2NKqd_Nny+M+NGg@mail.gmail.com>
	<4E132FD5.1090409@drewtech.com>
	<20110706161823.GB22857@kw.sim.vm.gnt>
Message-ID: <CAMAG_ectyLJ8Ebt1DLncZhRxf=0TOgdfO1nSrzZ=4H1Sbks9Tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> >>It doesn't seems the code was behaving differently before 3.0-rc. I mean
>> >>before the MPP and GPIO consolidation work. It was ?
>> >that's right, this issue was before the consolidation work.
>> Agreed. I only meant to say that the MPP code is broken for mv78200
>> in 3.0-rc5, so the maintainers should consider a short-term fix of
>> disabling the checks in orion_gpio_is_valid().
>
> And break code relying on the orion_gpio_is_valid() correctness ?
> IMHO, this kind of workaround is just not acceptable.
agree
>
>> >I think the solution is to extend the MPP define to include the
>> >explicit gpio number, so it will look like:
>> >#define MPP(_num, _gpio _sel, _in, _out, _78100_A0)
>> That could work as long as a value is reserved to mean "not gpio" like:
>>
>> #define MPP0_GPIO ? ? ? ?MPP(0, 0, 0x0, 1, 1, 1)
>> #define MPP0_GE0_COL ? ? ? ?MPP(0, -1, 0x1, 1, 0, 1)
>
> Maybe we could add a function pointer to the parameter list for
> orion_mpp_conf(). Something like: int (*mpp_to_gpio) (unsigned int num).
>
> If given to orion_mpp_conf(), the function would be used to perform the
> MPP to GPIO conversion. And if NULL, a 1:1 GPIO to MPP mapping would be
> used (current code).
this is not enough, because for each mpp element of the mpp_list, we
have to know whether the mpp is selected for gpio mode or not.
saeed
