From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Mon, 29 Dec 2014 09:02:49 -0300
Subject: [PATCH v6] ARM: zImage: add support for ARMv7-M
In-Reply-To: <5495CA13.3010700@vanguardiasur.com.ar>
References: <1418806573-14897-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <cfd1c941b379d2e47b0a8d1469161179@agner.ch>
 <5495CA13.3010700@vanguardiasur.com.ar>
Message-ID: <54A142E9.60501@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/2014 04:12 PM, Ezequiel Garcia wrote:
> Stefan,
> 
> On 12/20/2014 10:33 AM, Stefan Agner wrote:
>> On 2014-12-17 09:56, Uwe Kleine-K?nig wrote:
>>> From: Joachim Eastwood <manabian@gmail.com>
>>> 
>>> This patch makes it possible to enter zImage in Thumb mode for
>>> ARMv7-M (Cortex-M) CPUs that do not support ARM mode. The kernel
>>> entry is also made in Thumb mode.
>>> 
>>> Signed-off-by: Joachim Eastwood <manabian@gmail.com> [ukl: fix
>>> spelling in commit log, return early in call_cache_fn] 
>>> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> 
>>> --- Hello,
>>> 
>>> I just picked up Joachim's patch and fixed the small concerns I
>>> had in the last round.
>>> 
>>> I thought about adding a wrapper for accessing the CPUID
>>> registers that are located in cp15 on v7-A/R and memory mapped on
>>> v7-M. The corresponding registers and their address are as
>>> follows:
>>> 
>>> name		cp15 reg [1] on -A/R	address on -M MIDR/CPUID  	CRm=c0,
>>> opc2=0  	0xe000ed00 PFR0   		CRm=c1, opc2=0  	0xe000ed40 PFR1
>>> CRm=c1, opc2=1  	0xe000ed44 DFR0   		CRm=c1, opc2=2  	0xe000ed48 
>>> AFR0   		CRm=c1, opc2=3  	0xe000ed4c MMFR0  		CRm=c1, opc2=4
>>> 0xe000ed50 MMFR1  		CRm=c1, opc2=5  	0xe000ed54 MMFR2  		CRm=c1,
>>> opc2=6  	0xe000ed58 MMFR3  		CRm=c1, opc2=7  	0xe000ed5c ISAR0
>>> CRm=c2, opc2=0  	0xe000ed60 ISAR1  		CRm=c2, opc2=1  	0xe000ed64 
>>> ISAR2  		CRm=c2, opc2=2  	0xe000ed68 ISAR3  		CRm=c2, opc2=3
>>> 0xe000ed6c ISAR4  		CRm=c2, opc2=4  	0xe000ed70 ISAR5  		CRm=c2,
>>> opc2=5  	0xe000ed74
>>> 
>>> But there is no nice translation and as cache handling is
>>> implementation defined on v7-M anyhow there is not much use and I
>>> decided to just return early in the cache function.
>>> 
>>> This patch is only compile tested as I don't have a machine with
>>> enough RAM to run a non-XIP kernel, so Tested-by tags are
>>> welcome.
>> 
>> Hi Uwe,
>> 
>> Tried the patch on Vybrid's M4 CPU. Since the M4 has full access to
>> the DDR3 RAM, it is even possible to use AUTO_ZRELADDR for both
>> CPU's: The Colibri VF61 has 256MB of RAM: A5 relocates to
>> 0x80008000, M4 to 0x88008000.
>> 
>> The uncompressing stage seems to work fine, however it seems I hit
>> a different bug which is triggered by using the zImage: Freeing the
>> memory location used by the compressed image seems to fail:
>> 
> 
> Does this happen systematically for you?
> 
> I tried this patch on a LPC4337 based board, and came across very 
> strange and random memory corruptions, ranging from hitting strange 
> WARN(), BUG(), to OOM, to unhandled exceptions.
> 
> Rebuilding the kernel caused the different results (perhaps due to
> link differences?).
> 
> The problem is this machine is not yet mainlined, so I'm not yet
> sure it's this patch the one to blame.
> 

OK, after fixing the SDRAM config on the LPC43xx board,
I managed to test this and it seems to work just fine.

Tested-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Thanks a lot Uwe!
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
