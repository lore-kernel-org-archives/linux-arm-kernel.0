From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 30 Nov 2010 15:53:09 +0100
Subject: [PATCH RESEND v3] ARM: s3c2442: Setup gpio {set,
	get}_pull callbacks
In-Reply-To: <201011301633.05545.anarsoul@gmail.com>
References: <000201cb8fae$4d61fd20$e825f760$%kim@samsung.com>
	<201011301401.44973.anarsoul@gmail.com>
	<4CF4F845.7010207@metafoo.de>
	<201011301633.05545.anarsoul@gmail.com>
Message-ID: <4CF50FD5.1090705@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30/2010 03:33 PM, Vasily Khoruzhick wrote:
> On Tuesday 30 November 2010 15:12:37 Lars-Peter Clausen wrote:
> 
>> Hi
>>
>> While this might work for setting the pullup, what to you want to return in
>> get_pull?
> 
> Some custom value like S3C_GPIO_PULL_ENABLED?
Well, or we could use a custom setter and getter functions for configuring the
pull-ups/downs.
>  
>> The reason why s3c24xx_gpiocfg_default needs to have {get,set}_pull set at
>> compile time is that the board init code is called before the cpu init
>> code. Which is in my opinion a bit odd and should be fixed instead.
> 
> That's because cpu init code is arch_initcall. Kernel calls mdesc-
>> init_machine before any arch_initcall function, not sure if it can be fixed 
> without massive rework of existing code.

Both the cpu init code and the machine init code are run at arch_initcall.

> 
>> If it is not fixed for whatever reason we could fallback to using some sort
>> of "cpu_is_s3c2442() ? S3C_GPIO_PULL_UP : S3C_GPIO_PULL_DOWN"
> 
> AFAIK, Ben does not like runtime CPUtype checks
> 
I prefer it over broken code. And you would only need it until the cpu init functions
have been run.

You would add a wrapper like:
s3c24xx_set_pull(...)
{
	if (cpu_is_s3c2442())
		s3c_gpio_setpull_1down(...)
	else
		s3c_gpio_setpull_1up(...)
}

And then set s3c24xx_gpiocfg_default.{set,get}_pull to those at compile time. And
once the cpu init code runs replace them with either s3c_gpio_setpull_1down or
s3c_gpio_setpull_1up depending on the cpu.

- Lars
