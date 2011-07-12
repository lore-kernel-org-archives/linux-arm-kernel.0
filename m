From: joravec@drewtech.com (Joey Oravec)
Date: Tue, 12 Jul 2011 09:36:59 -0400
Subject: plat-orion multi purpose pins problem for mv78200
In-Reply-To: <CAMAG_efdj0cHkBZW37H=jcK2ZpXOQfg56HXXDLd=86HLcoNQzw@mail.gmail.com>
References: <4E0E1CA8.7090200@drewtech.com>	<20110702122344.GJ31228@kw.sim.vm.gnt>	<CAMAG_eexDoKrPsrd7+3bpsN3y0pptqwhFRP2NKqd_Nny+M+NGg@mail.gmail.com>	<4E132FD5.1090409@drewtech.com>	<20110706161823.GB22857@kw.sim.vm.gnt>	<4E14AE51.5070003@drewtech.com>	<CAMAG_eeO5EXML=nEfKkvbqz__UFQifUujjFrb4YKiOxZzdFhjA@mail.gmail.com>	<4E15B987.1060208@drewtech.com>
	<CAMAG_efdj0cHkBZW37H=jcK2ZpXOQfg56HXXDLd=86HLcoNQzw@mail.gmail.com>
Message-ID: <4E1C4DFB.2080906@drewtech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/10/2011 9:21 AM, saeed bishara wrote:
>>> I agree, this is why we need some method to make the orion_mpp_conf()
>>> know which mpps are gpios, when that done, then the gpio of MPP47 in
>>> your case will not be set as invalid.
>>> one option to do that is to assume that mpp with _in == out_ == 0 is
>>> not a gpio. so the orion_mpp_conf() will look like this:
>>> --- a/arch/arm/plat-orion/mpp.c
>>> +++ b/arch/arm/plat-orion/mpp.c
>>> @@ -41,6 +41,7 @@ void __init orion_mpp_conf(unsigned int *mpp_list,
>>> unsigned int variant_mask,
>>>          for ( ; *mpp_list; mpp_list++) {
>>>                  unsigned int num = MPP_NUM(*mpp_list);
>>>                  unsigned int sel = MPP_SEL(*mpp_list);
>>> +               unsigned int gpio_num = MPP_GPIO(*mpp_list);
>>>                  int shift, gpio_mode;
>>>
>>>                  if (num>    mpp_max) {
>>> @@ -64,9 +65,8 @@ void __init orion_mpp_conf(unsigned int *mpp_list,
>>> unsigned int variant_mask,
>>>                          gpio_mode |= GPIO_INPUT_OK;
>>>                  if (*mpp_list&    MPP_OUTPUT_MASK)
>>>                          gpio_mode |= GPIO_OUTPUT_OK;
>>> -               if (sel != 0)
>>> -                       gpio_mode = 0;
>>> -               orion_gpio_set_valid(num, gpio_mode);
>>> +               if (gpio_mode != 0)
>>> +                       orion_gpio_set_valid(gpio_num, gpio_mode);
>>>          }
>>>
>>>
>>> and of course this will require that any non gpio mpp will have to
>>> have the _in and _out set to 0.
>> Yes this proposal is better for mv78xx0 than the current code, but it may
>> fail if you call orion_mpp_conf() multiple times. Imagine you setup the
>> MPP16_GPIO as described, then a subsequent call wants to configure
>> differently and sets:
> the issue that you're describing is theoretical and doesn't happen at
> least in the boards that supported by the kernel.
> I don't think it deserve to complicate our code.

I agree no boards are currently doing this, especially since the 
functions are marked __init and the code is not capable of it today. But 
it's reasonable that a driver would want to switch MPPs between a 
peripheral and a high-impedance state, for example during suspend/resume.

>> MPP16_UNUSED (this mpp corresponds to GPIO16)
>>
>> Note orion_gpio_set_valid() contains code to mark GPIOs as valid or invalid,
>> but proposed change will only make a call to mark a GPIO as valid. This
>> example would reconfigure the MPP but leave the GPIO marked valid.
>>
>> Eventually, we would need to handle this example to implement the proposed
>> pinmux API. Right?
> it makes sense. have you tried it?

The latest proposal I could find is from June: 
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052955.html

I have not tried to implement that API yet. The proposal allows changing 
mux settings at any time, so it seems like the mv78xx0 should be 
prepared to do that at some point in the future.

-joey
