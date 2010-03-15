From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 15 Mar 2010 21:32:06 +0100
Subject: [PATCH] ARM: SAMSUNG: Add suspend/resume support for S3C PWM
	driver
In-Reply-To: <201003152217.02781.anarsoul@gmail.com>
References: <1268663228-27515-1-git-send-email-anarsoul@gmail.com>
	<4B9E8C25.80904@metafoo.de> <201003152217.02781.anarsoul@gmail.com>
Message-ID: <4B9E9946.9030607@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Vasily Khoruzhick wrote:
> ? ????????? ?? 15 ????? 2010 21:36:05 ????? Lars-Peter Clausen
> ???????:
>
>> Hi
>>
>> There is still one big issue left regarding pwm suspend/resume.
>> If the invert bit is not set, the pwm will generate a HIGH signal
>> when being inactive, when the bit is set it will generate a HIGH
>> signal when active. As a result any pin to which the pwm signal
>> is routed will appear as active until the pwm resume handler is
>> called. This usually takes a few 100 ms seconds and so for a
>> short period of time we'll get the wrong signal on pwm pins. For
>> correct behavior the pwm driver would have to check all pins to
>> which it's signal might be routed and if it's actually is
>> configure the pin as LOW output. Upon resume the pin then has to
>> be reconfigured as a pwm pin, only after the invert bit has been
>> set.
>>
>> I know that it previously has been stated, that it is not desired
>> for the pwm driver to know about gpio pins. But in my opinion to
>> ensure correct behavior it is unavoidable.
>>
>> - Lars
>

> Hi, why not to leave this job for driver that use PWM? This driver
> should disable PWM before going to suspend and ensure that GPIO pin
> is in right state. (For example, I'm using pwm-bl callbacks to
> manage gpio pin state when PWM is disabled).
>
Hi

Because it would require to implement the same functionality over and
over again. Furthermore it would require each generic driver using the
pwm api to provide such callbacks.
And you - as a user of the api - will have to know about this oddity.
In my opinion it is a detail specific to the samsung platform and
should be hidden behind the common interface.

- - Lars
> Regards Vasily
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkuemUUACgkQBX4mSR26RiOU7ACggbRUJLjBOV9XVxlDofceBgcR
jIIAn3mRtLhi0RWwyUS7Q60IbeMAdLEP
=Se19
-----END PGP SIGNATURE-----
