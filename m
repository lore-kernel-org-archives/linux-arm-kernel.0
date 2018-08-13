From: daniel@zonque.org (Daniel Mack)
Date: Mon, 13 Aug 2018 07:54:41 +0200
Subject: ASoC: pxa: possible regressions
In-Reply-To: <3ff3c732-b598-f2c3-9a0a-cc92f234326b@gmail.com>
References: <5be00a36-d54b-e8ab-2d5f-4c1870f14aac@gmail.com>
 <58f65d89-c342-026f-6e24-a67fcd625a26@zonque.org>
 <3ff3c732-b598-f2c3-9a0a-cc92f234326b@gmail.com>
Message-ID: <d803b938-3212-6485-8786-43dff6e46e6a@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Petr,

On Wednesday, August 08, 2018 11:07 AM, Petr Cvek wrote:
> Dne 8.8.2018 v 07:38 Daniel Mack napsal(a):

> I was planning to send patches before I've found regressions in the
> current -next.
> 
> I think I've had the first working version somewhere around 3.13, but I
> was updating versions only sporadically and fixing audio had low
> priority (higher priority got iwmmxt compiler, platform init source
> code, charger, USB, MMC and IrDA). Some versions until now worked, some
> didn't.
> 
> The last version I've used and where the sound worked was
> 4.14.0-rc7-next from somewhere around 3rd November 2017. The patch for
> sound subsystem should be the same as the current one.

That's strange, because as I said, the SSP rework went in in 4.0, so 
without my regression fix (737e370a57e4e8 "ASoC: pxa-ssp: allow more 
flexible setup order"), I doubt SSP had worked for you.

>>> 3) setup fails
>>>
>>> Recent changes in ASoC PXA DMA are causing a fail of a condition in
>>> pxa_ssp_hw_params():
>>>
>>>  ????if ((sscr0 & SSCR0_MOD) && !ttsa) {
>>
>> What are the values of sscr0 and ttsa in your case? Can you cross-check
>> that with a kernel that doesn't have my recent changes?
>>
> 
> -> full values in the attached log (the flag is set in the switch case
> and ttsa is zeroed)
> 
> On 4.14 (not sure, if it is the correct SSP controller)

Hmm, why shouldn't it be the correct one? And do you hear sound with 
that 4.14 setup?

> 
> Idle:
> 
> SSCR0:
> 	# devmem 0x41000000 32
> 	0x4000003F <- 31 bit is SSCR0_MOD
> SSCR1:
> 	# devmem 0x41000004 32
> 	0x00C01D80
> SSTSA:
> 	# devmem 0x41000030 32
> 	0x00000000 <- is "ttsa" variable
> SSRSA:
> 	# devmem 0x41000034 32
> 	0x00000000
> SSTSS:
> 	# devmem 0x41000038 32
> 	0x00000000
> 
> Playing noise:
> 
> SSCR0:
> 	# devmem 0x41000000 32
> 	0x400000BF <- 31 bit is SSCR0_MOD
> SSCR1:
> 	# devmem 0x41000004 32
> 	0x00E01D80
> SSTSA:
> 	# devmem 0x41000030 32
> 	0x00000000 <- is "ttsa" variable
> SSRSA:
> 	# devmem 0x41000034 32
> 	0x00000000
> SSTSS:
> 	# devmem 0x41000038 32
> 	0x00000000
> 
> .. so the time slots are correctly disabled.

The idea was to compare a working against a non-working setup to spot 
the differences in the register settings.

If recent mainline versions have worked for you (modulo some minor 
modifications), I think one good way forward could be to bisect the 
problems and make the platform work for 4.18 again. Then, see if any of 
the recent ASoC/DMA related PXA patches break it again.

Sorry for the trouble, but without hardware, these things are hard to 
reproduce on my side.


Let me know if I can help further, but not that my resources are a bit 
limited in the next weeks.


Thanks,
Daniel
