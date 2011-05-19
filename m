From: mingo@elte.hu (Ingo Molnar)
Date: Thu, 19 May 2011 11:33:18 +0200
Subject: [patch 7/7] x86: hpet: Cleanup the clockevents init and register
	code
In-Reply-To: <20110518210136.646482357@linutronix.de>
References: <20110518205713.947614271@linutronix.de>
	<20110518210136.646482357@linutronix.de>
Message-ID: <20110519093318.GC6251@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> @@ -884,6 +835,14 @@ int __init hpet_enable(void)
>  		goto out_nohpet;
>  
>  	/*
> +	 * The period is a femto seconds value. Convert it to a
> +	 * frequency.
> +	 */
> +	freq = FSEC_PER_SEC;
> +	do_div(freq, hpet_period);
> +	hpet_freq = freq;

Something i just noticed: with a typical hpet frequency of around 14 MHz we get 
a period of 71428571 femtoseconds.

Our HPET_MAX_PERIOD is 100000000 at the moment, so our limits look like this:

    100000
  71428571
 100000000

Note how close the max period (lowest frequency) is to our typical value!

So if there's a 10 MHz hpet somewhere, with just slightly below spec, we'd fail 
due to:

        if (hpet_period < HPET_MIN_PERIOD || hpet_period > HPET_MAX_PERIOD)
                goto out_nohpet;

unless i got my numbers wrong it might be worth upping the max period to 
1000000000, to allow down to 1 MHz hpet frequencies. Or at least up it enough 
to make 10 MHz possible modulo small noise.

Patch looks good:

Reviewed-by: Ingo Molnar <mingo@elte.hu>

Thanks,

	Ingo
