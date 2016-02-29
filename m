From: kernel@martin.sperl.org (Martin Sperl)
Date: Mon, 29 Feb 2016 18:10:53 +0100
Subject: [PATCH V2 3/8] dmaengine: bcm2835: use shared interrupt for
 channel 11 to 14.
In-Reply-To: <20160114040749.GJ11130@localhost>
References: <1452187987-2605-1-git-send-email-kernel@martin.sperl.org>
 <1452187987-2605-4-git-send-email-kernel@martin.sperl.org>
 <20160113122621.GA11130@localhost> <56965178.7070700@martin.sperl.org>
 <20160113134338.GH11130@localhost> <56965E3B.7060104@martin.sperl.org>
 <20160114040749.GJ11130@localhost>
Message-ID: <1181247D-8257-439A-943F-34F40604D5A5@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 14.01.2016, at 05:07, Vinod Koul <vinod.koul@intel.com> wrote:
> 
> On Wed, Jan 13, 2016 at 03:24:59PM +0100, Martin Sperl wrote:
>>>> But that would be frowned upon, so I had to come up with the approach
>>>> taken, which makes the following assumptions:
>>> 
>>> DT was designed to move this info and hardcoding from kernel into
>>> DT, so why cant we do that?
>> We still need to be backwards-compatible - at least that is what
>> everyone tells me, so I need to hard-code fallbacks for those values.
> 
> IMO hard code for falling back is okay as that supports old cases and new
> platforms use geric DT info and new devices can be supported generically,
> please check with DT folks..
> 
>>>> * the DT maps only the interrupts that are assigned to the HW block
>>>> * the driver knows about the number of DMA channels in HW
>> that could be a DT property, yes.
>>>> * the driver knows about the mapping of shared interrupts
>>>>  (11-14 share irq).
>> OK - how would you define that "mapping" in a "sane" manner in the DT
>> that allows us to have multiple such mappings in the future?
> 
> You are hard coding the flags for each channel, we can pass this for each
> channel in the interrupt configi, a flag share/none..? Please run this thru
> DT experts and I am not one of them..

So here a ?simple? approach with the following device tree addition (plus defaults):
	interrupts = <1 16>, /* dma 0 irq */
		     <1 17>, /* dma 1 irq */
	...
		     <1 26>, /* dma 10 irq */
		     <1 27>, /* dma 11-14 irq */
		     <1 28>; /* dma all irq */
	brcm,dma-channel-mask = <0x7f35>;
	/* new properties below - also the defaults */
	brcm,dma-channel-shared-mask = <0x7800>;
	brcm,dma-shared-irq-index = <11>;

Is this sufficient to move forward?

Thanks,
	Martin

P.s: this would also mean (for later patches):
	brcm,dma-lite-channel-mask = <0x7f00>;
