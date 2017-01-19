From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Thu, 19 Jan 2017 16:34:31 +0100
Subject: [PATCH v2 2/3] spi: pxa2xx: Prepare for edge-triggered interrupts
In-Reply-To: <20170118124645.6ugjwbfeq5vsh2to@sirena.org.uk>
References: <cover.1484592296.git.jan.kiszka@siemens.com>
 <cover.1484592296.git.jan.kiszka@siemens.com>
 <7b15a0910a3ad861fd32161c72559bafa7b71e29.1484592296.git.jan.kiszka@siemens.com>
 <87ziiqdstr.fsf@belgarion.home>
 <4d97e416-4d32-3b9f-0695-de116a4b26bd@siemens.com>
 <87r340eq28.fsf@belgarion.home>
 <b3e0d393-b841-1556-ddd2-5634f12b6f2c@siemens.com>
 <20170118124645.6ugjwbfeq5vsh2to@sirena.org.uk>
Message-ID: <7e5fb21d-35bd-6ac3-9e6f-cffed656997f@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-01-18 13:46, Mark Brown wrote:
> On Wed, Jan 18, 2017 at 10:33:07AM +0100, Jan Kiszka wrote:
>> On 2017-01-18 09:21, Robert Jarzmik wrote:
> 
>>>>>> +	while (1) {
> 
>>>>> This bit worries me a bit, as this can be either :
>>>>>  - hogging the SoC's CPU, endlessly running
>>>>>  - or even worse, blocking the CPU for ever
> 
>>>>> The question behind is, should this be done in a top-half, or moved to a irq
>>>>> thread ?
> 
>>>> Every device with a broken interrupt source can hog CPUs, nothing
>>>> special with this one. If you don't close the loop in the handler
>>>> itself, you close it over the hardware retriggering the interrupt over
>>>> and over again.
> 
>>> I'm not speaking of a broken interrupt source, I'm speaking of a broken code,
>>> such as in the handler, or broken status readback, or lack of understanding on
>>> the status register which may imply the while(1) to loop forever.
> 
>>>> So, I don't see a point in offloading to a thread. The normal case is
>>>> some TX done (FIFO available) event followed by an RX event, then the
>>>> transfer is complete, isn't it?
> 
>>> The point is if you stay forever in the while(1) loop, you can at least have a
>>> print a backtrace (LOCKUP_DETECTOR).
> 
>> I won't consider "debugability" as a good reason to move interrupt
>> handlers into threads. There should be real workload that requires
>> offloading or specific prioritization.
> 
> It's failure mitigation - you're translating a hard lockup into
> something that will potentially allow the system to soldier on which is
> likely to be less severe for the user as well as making things easier to
> figure out.  If we're doing something like this I'd at least have a
> limit on how long we allow the interrupt to scream.
> 

OK, OK, if that is the biggest worry, I can change the pattern from
loop-based to SCCR1-based, i.e. mask all interrupt sources once per
interrupt so that we enforce a falling edge. Fine.

But now I'm looking at the driver, wondering who all is fiddling under
which conditions with SCCR1. There are a lot of RMW patterns, but I do
not see the locking pattern behind that. Are all RMW accesses run only
in the interrupt handler context? Unlikely, at least with the dmaengine
in the loop.

Closing my eyes regarding this potential issue for now, the patch could
become as simple as

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 0d10090..f9c2329 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -785,6 +785,9 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 	if (!(status & mask))
 		return IRQ_NONE;
 
+	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg & ~drv_data->int_cr1);
+	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg);
+
 	if (!drv_data->master->cur_msg) {
 		handle_bad_msg(drv_data);
 		/* Never fail */

Not efficient /wrt register accesses, but that's apparently not yet
a design goal anyway (I stumbled over the SSCR1 locking while
considering to introduce a cache for that reg).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170119/85442b92/attachment.sig>
