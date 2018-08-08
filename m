From: petrcvekcz@gmail.com (Petr Cvek)
Date: Wed, 8 Aug 2018 11:07:11 +0200
Subject: ASoC: pxa: possible regressions
In-Reply-To: <58f65d89-c342-026f-6e24-a67fcd625a26@zonque.org>
References: <5be00a36-d54b-e8ab-2d5f-4c1870f14aac@gmail.com>
 <58f65d89-c342-026f-6e24-a67fcd625a26@zonque.org>
Message-ID: <3ff3c732-b598-f2c3-9a0a-cc92f234326b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 8.8.2018 v 07:38 Daniel Mack napsal(a):
> 
>> My setup has only a few changes from
>> vanilla (change to using devm_snd_soc_register_card+devm_gpio_request).
> 
> Care to share these changes, or ideally rebase them on top of 4.18-next 
> for mainline inclusion? Also, I'm curious what mainline version you used 
> to be based on that worked for you.

I was planning to send patches before I've found regressions in the 
current -next.

I think I've had the first working version somewhere around 3.13, but I 
was updating versions only sporadically and fixing audio had low 
priority (higher priority got iwmmxt compiler, platform init source 
code, charger, USB, MMC and IrDA). Some versions until now worked, some 
didn't.

The last version I've used and where the sound worked was 
4.14.0-rc7-next from somewhere around 3rd November 2017. The patch for 
sound subsystem should be the same as the current one.

The current patch is based on vanilla 4.18.0-rc6-next-20180726.

> 
>> 2) wrong units (sample rate vs osc rate)
>>
>> Commit 05739375f1c0a1048 ("ASoC: pxa-ssp: remove .set_pll() and
>> .set_clkdiv() callbacks"). The function pxa_ssp_hw_params() get's called
>> with sample rate so:
>>
>> ????/* The values in the table are for 16 bits */
>> ????if (width == 32)
>> ??????? acds--;
>>
>> ????ret = pxa_ssp_set_pll(priv, bclk);
>> ????if (ret < 0)
>> ??????? return ret;
>>
>> ????ssacd = pxa_ssp_read_reg(ssp, SSACD);
>> ????ssacd &= ~(SSACD_ACDS(7) | SSACD_SCDB_1X);
>>
>> pxa_ssp_set_pll() will try to set something like 8000, 44100, ... and
>> not the speed of an oscilator. The line should be probably:
>>
>> ????ret = pxa_ssp_set_pll(priv, m->pll);
>>
>> and there is a previous call to pxa_ssp_set_pll():
> 
> Ah, yes. Does changing that fix it for you?
> 

Nope it just allows the code to proceed behind.

The fixing 3) (SSCR0_MOD check) has the same effect. It just postpones 
the closing of the device until a valid termination of aplay.

> 
>> 3) setup fails
>>
>> Recent changes in ASoC PXA DMA are causing a fail of a condition in
>> pxa_ssp_hw_params():
>>
>> ????if ((sscr0 & SSCR0_MOD) && !ttsa) {
> 
> What are the values of sscr0 and ttsa in your case? Can you cross-check 
> that with a kernel that doesn't have my recent changes?
> 

-> full values in the attached log (the flag is set in the switch case 
and ttsa is zeroed)

On 4.14 (not sure, if it is the correct SSP controller)

Idle:

SSCR0:
	# devmem 0x41000000 32
	0x4000003F <- 31 bit is SSCR0_MOD
SSCR1:
	# devmem 0x41000004 32
	0x00C01D80
SSTSA:
	# devmem 0x41000030 32
	0x00000000 <- is "ttsa" variable
SSRSA:
	# devmem 0x41000034 32
	0x00000000
SSTSS:
	# devmem 0x41000038 32
	0x00000000

Playing noise:

SSCR0:
	# devmem 0x41000000 32
	0x400000BF <- 31 bit is SSCR0_MOD
SSCR1:
	# devmem 0x41000004 32
	0x00E01D80
SSTSA:
	# devmem 0x41000030 32
	0x00000000 <- is "ttsa" variable
SSRSA:
	# devmem 0x41000034 32
	0x00000000
SSTSS:
	# devmem 0x41000038 32
	0x00000000

.. so the time slots are correctly disabled.

>> 4) names are not unique
>>
>> The initialization of magician_dai structure wants to have (at least in
>> the past versions) for the .name item:
>>
>> ????static struct snd_soc_dai_link magician_dai[] = {
>> ????{
>> ??????? .name = "uda1380",
>> ??????? .stream_name = "UDA1380 Playback",
>> ??????? .cpu_dai_name = "pxa-ssp-dai.0",
>> ??????? ...
>> ????{
>> ??????? .name = "uda1380",
>> ??????? .stream_name = "UDA1380 Capture",
>> ??????? .cpu_dai_name = "pxa2xx-i2s",
>>
>> my personal branch has them named as "uda1380_playback" and
>> "uda1380_capture".
> 
> Care to send a patch for that as well, please?

If this is a correct solution then yes.

> 
>> 5) Unbalanced references
>>
>> When trying to play a sound (with quick-and-dirty workarounds for
>> problems above):
>>
>> ??? # cat /dev/urandom | aplay -
>>
>> the system will crash when terminating aplay (stopping playback). The
>> backtrace:
> 
> So you did hear a sound?

No, nothing went through. Only clicking was probably caused by muting 
the speaker output.

> 
> That seems fine. The question is why there are are unbalanced calls to 
> snd_dmaengine_pcm_close_release_chan(). Could you dig a bit further 
> maybe and add some printk()?

Yes I did, patch with asserts and matching log attached. It gets really 
ugly but though. It is full dump of changes, so there is a conversion of 
magician-audio driver for module_platform_driver (wasn't able to load it 
from vanilla from around 3.13) and some bugfixes in uda codec 
(uda1380-hifi removed because it didn't work with split magician I2S/SSP 
channels and I didn't test it lately, and a bugfix for name/register 
settings).

Petr
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ASoC-pxa-magician-testing.patch
Type: text/x-patch
Size: 53389 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180808/e511863f/attachment-0002.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: magician_sound.log
Type: text/x-log
Size: 16299 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180808/e511863f/attachment-0003.bin>
