From: JBeulich@novell.com (Jan Beulich)
Date: Tue, 13 Oct 2009 08:40:01 +0100
Subject: [PATCH] serial/atmel_serial: Fix another fallout of the
	change to BUILD_BUG_ON
In-Reply-To: <20091013092644.72c78334@hskinnemoen-d830>
References: <1255417680-25609-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091013092644.72c78334@hskinnemoen-d830>
Message-ID: <4AD44AF10200007800019801@vpn.id2.novell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> Haavard Skinnemoen <haavard.skinnemoen@atmel.com> 13.10.09 09:26 >>>
>Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
>> Commit 8c87df457cb5 fixed BUILD_BUG_ON with the result that some
>> expressions (e.g. "not really constant" ones) result in a build failure.
>> 
>> Some of these were fixed in 8c87df457cb5, but not serial/atmel_serial.
>
>This patch fixes the same issue:
>
>http://lkml.org/lkml/2009/10/6/305 
>
>> -	BUILD_BUG_ON(!is_power_of_2(ATMEL_SERIAL_RINGSIZE));
>> +	MAYBE_BUILD_BUG_ON(!is_power_of_2(ATMEL_SERIAL_RINGSIZE));
>
>What's the difference between BUILD_BUG_ON() and MAYBE_BUILD_BUG_ON()?

The latter (at present) generally only serves as an annotation. It should
probably be renamed and converted to the (linking time) detecting
mechanism Rusty suggested (though I'm not sure that model would
allow all non-constant [at parsing time] uses to be detected - clearly
there would remain potential for build issues if the compiler isn't able
to reduce the expression to a constant during optimization).

Jan
