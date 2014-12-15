From: uwe@kleine-koenig.org (=?windows-1252?Q?Uwe_Kleine-K=F6nig?=)
Date: Mon, 15 Dec 2014 20:36:34 +0100
Subject: RFC: new dt property "can-wakeup-machine" [Was: [PATCHv0 1/5] rtc:
 rtc-isl12057: add alarm support to Intersil ISL12057 RTC driver]
In-Reply-To: <c38e3f1a4254e0d8db409ad87ba824c3383d0998.1418519430.git.arno@natisbad.org>
References: <cover.1418519430.git.arno@natisbad.org>
 <c38e3f1a4254e0d8db409ad87ba824c3383d0998.1418519430.git.arno@natisbad.org>
Message-ID: <548F3842.1010605@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I adapted the subject line to make the critical element in this patch
more obvious.

As I wouldn't be surprised to get some discussion about your approach it
would be beneficial to split this patch into:

 - add (traditional) alarm support to rtc-isl12057
 - allow the driver to wakeup the machine without the irq being
   reported to the CPU.

The first patch should not be controversial and the patch to discuss
gets smaller.

On 12/14/2014 02:42 AM, Arnaud Ebalard wrote:
> +Example isl12057 node without IRQ#2 pin connected to the SoC but to a
> +PMIC, allowing the device to be started based on configured alarm:
> +
> +	isl12057: isl12057 at 68 {
> +		compatible = "isil,isl12057";
> +		reg = <0x68>;
> +		can-wakeup-machine;
> +	};
What if the IRC#1 pin wakes the machine?

And I wonder if there is a more sane approach for this setup that
wouldn't need specialized driver support.

Something like:

	isl12057: isl12057 at 68 {
		compatible = "isil,isl12057";
		reg = <0x68>;
		interrupt-parent = <&wakeupfoo>;
		interrupts = <???>
	};

	wakeupfoo: ... {
		/*
		 * This controller cannot report irqs to the cpu, but
		 * can wake it up.
		 */
		....
	}

Hmm, the bad thing here is that this "interrupt controller" isn't
suitable to support "normal" interrupts. But maybe it's good enough to
get into a discussion for a better idea?!

> diff --git a/drivers/rtc/rtc-isl12057.c b/drivers/rtc/rtc-isl12057.c
> index 6e1fcfb5d7e6..98adc2c1bdb0 100644
> --- a/drivers/rtc/rtc-isl12057.c
> +++ b/drivers/rtc/rtc-isl12057.c
> @@ -1,5 +1,5 @@
>  /*
> - * rtc-isl12057 - Driver for Intersil ISL12057 I2C Real Time Clock
> + * rtc-isl12057 - Driver for Intersil ISL12057 I2C Real Time Clock / Alarm
I wouldn't care here to add "Alarm" at various places. Actually having
an alarm is a quite usual feature of an rtc. *shrug*

Best regards
Uwe
