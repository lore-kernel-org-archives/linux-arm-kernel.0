From: joravec@drewtech.com (Joey Oravec)
Date: Wed, 06 Jul 2011 14:49:53 -0400
Subject: plat-orion multi purpose pins problem for mv78200
In-Reply-To: <20110706161823.GB22857@kw.sim.vm.gnt>
References: <4E0E1CA8.7090200@drewtech.com>
	<20110702122344.GJ31228@kw.sim.vm.gnt>
	<CAMAG_eexDoKrPsrd7+3bpsN3y0pptqwhFRP2NKqd_Nny+M+NGg@mail.gmail.com>
	<4E132FD5.1090409@drewtech.com>
	<20110706161823.GB22857@kw.sim.vm.gnt>
Message-ID: <4E14AE51.5070003@drewtech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/6/2011 12:18 PM, Simon Guinot wrote:
>> Note that orion_gpio_set_valid() and orion_gpio_is_valid() would
>> both need rework. The functions need to handle that a GPIO can be
>> mux'ed onto any MPP pin. I described this problem in another email
>> on the thread.
> I don't understand what's wrong with the GPIO array.

I tried to describe the case in my reply: 
http://lists.arm.linux.org.uk/lurker/message/20110701.215657.7efe0a42.en.html

Assume that we've solved the mpp_to_gpio mapping. Then imagine you pass 
a large array to mv78xx0_mpp_conf() that includes:

MPP16_GPIO (this mpp corresponds to GPIO16)
MPP47_UNUSED (this mpp corresponds to GPIO16)

The code today processes the array in-order. When it processes 
MPP16_GPIO it will mark the GPIO16 valid. When it processes MPP47_UNUSED 
it would currently mark GPIO16 invalid. This is a problem because it 
still assumes a 1:1 relationship.

-joey
