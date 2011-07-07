From: joravec@drewtech.com (Joey Oravec)
Date: Thu, 07 Jul 2011 09:49:59 -0400
Subject: plat-orion multi purpose pins problem for mv78200
In-Reply-To: <CAMAG_eeO5EXML=nEfKkvbqz__UFQifUujjFrb4YKiOxZzdFhjA@mail.gmail.com>
References: <4E0E1CA8.7090200@drewtech.com>	<20110702122344.GJ31228@kw.sim.vm.gnt>	<CAMAG_eexDoKrPsrd7+3bpsN3y0pptqwhFRP2NKqd_Nny+M+NGg@mail.gmail.com>	<4E132FD5.1090409@drewtech.com>	<20110706161823.GB22857@kw.sim.vm.gnt>	<4E14AE51.5070003@drewtech.com>
	<CAMAG_eeO5EXML=nEfKkvbqz__UFQifUujjFrb4YKiOxZzdFhjA@mail.gmail.com>
Message-ID: <4E15B987.1060208@drewtech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/7/2011 2:40 AM, saeed bishara wrote:
>>>> Note that orion_gpio_set_valid() and orion_gpio_is_valid() would
>>>> both need rework. The functions need to handle that a GPIO can be
>>>> mux'ed onto any MPP pin. I described this problem in another email
>>>> on the thread.
>>> I don't understand what's wrong with the GPIO array.
>> I tried to describe the case in my reply:
>> http://lists.arm.linux.org.uk/lurker/message/20110701.215657.7efe0a42.en.html
>>
>> Assume that we've solved the mpp_to_gpio mapping. Then imagine you pass a
>> large array to mv78xx0_mpp_conf() that includes:
>>
>> MPP16_GPIO (this mpp corresponds to GPIO16)
>> MPP47_UNUSED (this mpp corresponds to GPIO16)
>>
>> The code today processes the array in-order. When it processes MPP16_GPIO it
>> will mark the GPIO16 valid. When it processes MPP47_UNUSED it would
>> currently mark GPIO16 invalid. This is a problem because it still assumes a
>> 1:1 relationship.
> I agree, this is why we need some method to make the orion_mpp_conf()
> know which mpps are gpios, when that done, then the gpio of MPP47 in
> your case will not be set as invalid.
> one option to do that is to assume that mpp with _in == out_ == 0 is
> not a gpio. so the orion_mpp_conf() will look like this:
> --- a/arch/arm/plat-orion/mpp.c
> +++ b/arch/arm/plat-orion/mpp.c
> @@ -41,6 +41,7 @@ void __init orion_mpp_conf(unsigned int *mpp_list,
> unsigned int variant_mask,
>          for ( ; *mpp_list; mpp_list++) {
>                  unsigned int num = MPP_NUM(*mpp_list);
>                  unsigned int sel = MPP_SEL(*mpp_list);
> +               unsigned int gpio_num = MPP_GPIO(*mpp_list);
>                  int shift, gpio_mode;
>
>                  if (num>  mpp_max) {
> @@ -64,9 +65,8 @@ void __init orion_mpp_conf(unsigned int *mpp_list,
> unsigned int variant_mask,
>                          gpio_mode |= GPIO_INPUT_OK;
>                  if (*mpp_list&  MPP_OUTPUT_MASK)
>                          gpio_mode |= GPIO_OUTPUT_OK;
> -               if (sel != 0)
> -                       gpio_mode = 0;
> -               orion_gpio_set_valid(num, gpio_mode);
> +               if (gpio_mode != 0)
> +                       orion_gpio_set_valid(gpio_num, gpio_mode);
>          }
>
>
> and of course this will require that any non gpio mpp will have to
> have the _in and _out set to 0.

Yes this proposal is better for mv78xx0 than the current code, but it 
may fail if you call orion_mpp_conf() multiple times. Imagine you setup 
the MPP16_GPIO as described, then a subsequent call wants to configure 
differently and sets:

MPP16_UNUSED (this mpp corresponds to GPIO16)

Note orion_gpio_set_valid() contains code to mark GPIOs as valid or 
invalid, but proposed change will only make a call to mark a GPIO as 
valid. This example would reconfigure the MPP but leave the GPIO marked 
valid.

Eventually, we would need to handle this example to implement the 
proposed pinmux API. Right?

-joey
