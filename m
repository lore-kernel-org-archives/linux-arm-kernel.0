From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 09 Jun 2010 15:59:52 +0200
Subject: [PATCH] pxa2xx/cpufreq: Fix DRI computation
In-Reply-To: <201006082136.30785.marek.vasut@gmail.com> (Marek Vasut's message
	of "Tue, 8 Jun 2010 21:36:30 +0200")
References: <1275698808-31166-1-git-send-email-marek.vasut@gmail.com>
	<87ljap7opx.fsf@free.fr> <201006082136.30785.marek.vasut@gmail.com>
Message-ID: <87typcwbl3.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Vasut <marek.vasut@gmail.com> writes:
>> > @@ -251,17 +251,42 @@ static void init_sdram_rows(void)
>> > 
>> >  	if (mdcnfg & (MDCNFG_DE0 | MDCNFG_DE1))
>> >  	
>> >  		drac0 = MDCNFG_DRAC0(mdcnfg);
>> > 
>> > -	sdram_rows = 1 << (11 + max(drac0, drac2));
>> > +	sdram_rows = 11 + max(drac0, drac2);
>> 
>> I don't think that's correct.
>> From DRACn, you learn that SDRAM row is selected from 11+DRACn bits. That
>> means that if drac == 2, then the SDRAM row is a number between 0 and
>> (11+drac0) - 1. That in turn means that the number of SDRAM rows is : 2 ^
>> (11 + drac0). Example:
>>  - drac0 = 2 : row encoded on 13 bits => 2^13 rows (ie. 1 << (11 + 2)).
>
> That I'm aware of, but are you sure the TRM means it that way ?
Not entirely sure, but quite. I'll check against values in WinCE on 2 different
platforms (mioa701 and hx4700) to be sure.

>> I don't agree here either. The "freq" variable is in kHz.
>
> That's concerning the TRM, not the freq value. In TRM, it's in MHz.
In mine, there is no unit, which means that frequency is in Hz, and refresh time
in seconds (equivalent to freq in kHz and refresh in ms).
Moreover, my TRM states :
 dri = (Number of CLK_MEM cycles ? 31) / 32
     = (Refresh time / rows x memory clock frequency ? 31) / 32.
This means :
  Number of CLK_MEM cycles = Refresh time / rows x memory clock frequency
You have to balance the physical units, so :
  number (no unit) = refresh_time(s) / rows (no unit) * mem_clock_freq(hz=1/s)
If you had refresh_time in ms and mem_clock_freq in MHz, the units would not be
balanced :
  no_unit = ms / no_unit * MHz
          = 1/1000s / no_unit * 1000000 * 1/s
          = 1000 / no_unit
  => 1 = 1000
  => can't be true, can it ?

>> And my understanding is that the legacy formula is incorrect, as you
>> discovered it. Yet it should be, IMO :
>>     if (cpu_is_pxa27x())
>> -       dri = ((freq * SDRAM_TREF) / (sdram_rows - 31)) / 32;
>> +       dri = ((freq * SDRAM_TREF) / sdram_rows - 31) / 32;
>> 
>> This is the only change to apply IMHO.
>
> Ok, but still, even though I fixed it your way, it doesn't fix the real problem, 
> I'll recheck though, I just need a few days too.
Okay, even if that settles the issue on my platform, there might be something
left. If your platform runs under another OS, could you post the values of
MDREFR and MDCNFG (ie. physical range from 0x48000000 to 0x48000008) ?

Cheers.

--
Robert
