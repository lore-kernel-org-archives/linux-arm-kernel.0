From: kapilh@broadcom.com (Kapil Hali)
Date: Thu, 15 Oct 2015 21:20:57 +0530
Subject: [PATCH V2] ARM: BCM5301X: Implement SMP support
In-Reply-To: <561E9D7E.5050500@hauke-m.de>
References: <1424385148-15026-1-git-send-email-zajec5@gmail.com>
 <1427030415-31721-1-git-send-email-zajec5@gmail.com>
 <20150326120026.GF8656@n2100.arm.linux.org.uk> <561D85BF.30305@hauke-m.de>
 <561D8A56.5090401@broadcom.com> <561E5BB7.1080307@broadcom.com>
 <561E9D7E.5050500@hauke-m.de>
Message-ID: <561FCB61.6060101@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/14/2015 11:52 PM, Hauke Mehrtens wrote:
> On 10/14/2015 03:42 PM, Kapil Hali wrote:
>>
>>
>> On 10/14/2015 4:18 AM, Ray Jui wrote:
>>> + bcm-kernel-feedback-list.
>>>
>>> Kapil, you might want to take a look at this. Not sure how this is
>>> related to your SMP patches for NSP.
>>
>> Ray, I don't have complete/other patch sets for this change. It would
>> be good if I get those patch sets as well or complete e-mail thread. 
>> I think if we have a cleaner solutions for SMP, we can consolidate 
>> the change required for NS and NSP. I have few points to add, which 
>> are inline in this e-mail.
> 
> Hi Kapil,
> 
> the patch was posted on the arm mailing list:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/332690.html
> but you can also find it in OpenWrt here:
> https://dev.openwrt.org/browser/trunk/target/linux/bcm53xx/patches-4.1/131-ARM-BCM5301X-Implement-SMP-support.patch
> It looks very similar to your approach so I assume we can use the same
> SMP code for NS and NSP. I will look into your patches later on.

You are right, we can use the common SMP code for NS and NSP, however, I am
only concerned about the secondary_startup() function in case of NS as is 
being discussed in the e-mail chain.
As there are multiple versions of NS SoC, and AFAIK, some of those have 
anomalous BOOTROM. We should have a cleaner generic solution which can be 
used for both NS and NSP.

> 
> Hauke
> 
>>
>>>
>>> On 10/13/2015 3:29 PM, Hauke Mehrtens wrote:
>>>> Hi,
>>>>
>>>> I tested this patch on my device now.
>>>>
>>>> What does the loader do before Linux gets started on the second CPU and
>>>> what is ensured?
>>>>
>>>> On 03/26/2015 01:00 PM, Russell King - ARM Linux wrote:
>>>>> On Sun, Mar 22, 2015 at 02:20:15PM +0100, Rafa? Mi?ecki wrote:
>>>>>> +/*
>>>>>> + * BCM5301X specific entry point for secondary CPUs.
>>>>>> + */
>>>>>> +ENTRY(bcm5301x_secondary_startup)
>>>>>> +	mrc	p15, 0, r0, c0, c0, 5
>>>>>> +	and	r0, r0, #15
>>>>>> +	adr	r4, 1f
>>>>>> +	ldmia	r4, {r5, r6}
>>>>>> +	sub	r4, r4, r5
>>>>>> +	add	r6, r6, r4
>>>>>> +pen:	ldr	r7, [r6]
>>>>>> +	cmp	r7, r0
>>>>>> +	bne	pen
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * In case L1 cache has unpredictable contents at power-up
>>>>>> +	 * clean its contents without flushing.
>>>>>> +	 */
>>>>>> +	bl      v7_invalidate_l1
>>>>>> +
>>>>>> +	mov	r0, #0
>>>>>> +	mcr	p15, 0, r0, c7, c5, 0	/* Invalidate icache */
>>>>>> +	dsb
>>>>>> +	isb
>>>>>
>>>>> So if your I-cache contains unpredictable contents, how do you execute
>>>>> the code to this point?  Shouldn't the I-cache invalidate be the very
>>>>> first instruction you execute followed by the dsb and isb (oh, and iirc
>>>>> it ignores the value in the register).
>>>>>
>>>>> In the case where a CPU has unpredictable contents at power up, the
>>>>> ARM ARM requires that an implementation specific sequence is followed
>>>>> to initialise the caches.  I doubt that such a sequence includes testing
>>>>> a pen value.
>>
>> Are you sure this is an issue of unpredictable L1 cache contents at
>> power-up? AFAIK, 5301X had an issue with secondary core initialization. 
>> Secondary core which waits on WFE would let it out of the pen as soon as the 
>> first spin_*lock executes. This was because of a BOOTROM bug in NS, so the
>> work around was to reset the address for the secondary processor to go back 
>> and wait for the signal from the primary core. This vector fixup is required
>> so that the secondary core doesn't start executing kernel instructions until 
>> we've patched its jump address during wakeup_secondary().
>>
>> Also, v7 setup function should invalidate L1 cache and we should remove all
>> v7_invalidate_l1 calls in all headsmp.S in platform specific directories.
>>
>>>>
>>>> When I remove the test for the pen value the CPU does not come up any
>>>> more, I get this log output:
>>>>
>>>> [ 0.132292] CPU: Testing write buffer coherency: ok
>>>> [ 0.137635] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
>>>> [ 0.143675] Setting up static identity map for 0x82a0 - 0x82d4
>>>> [ 10.149786] CPU1: failed to boot: -38
>>>> [ 10.153651] Brought up 1 CPUs
>>>>
>>>>
>>>> This was caused just by removing the "cmp r7, r0" and "bne pen"
>>>> instructions.
>>>>
>>>> With these instructions are added it works and I get this:
>>>>
>>>> [    0.132329] CPU: Testing write buffer coherency: ok
>>>> [    0.137682] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
>>>> [    0.143708] Setting up static identity map for 0x82a0 - 0x82d4
>>>> [    0.189788] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
>>>> [    0.189892] Brought up 2 CPUs
>>>> [    0.198889] SMP: Total of 2 processors activated (3188.32 BogoMIPS).
>>>>
>>>> Currently this is 100% reproducible.
>>>>
>>>> Could it be that the second CPU needs some time till it is synchronised
>>>> correctly?
>>>>
>>>> I do not know if and why the cache clearing is needed, I do not have
>>>> access to the SoC documentation or the ASIC/firmware developer.
>>>>
>>>>>
>>>>>> +	sysram_base_addr = of_iomap(node, 0);
>>>>>> +	if (!sysram_base_addr) {
>>>>>> +		pr_warn("Failed to map sysram\n");
>>>>>> +		return;
>>>>>> +	}
>>>>>> +
>>>>>> +	writel(virt_to_phys(entry_point), sysram_base_addr + SOC_ROM_LUT_OFF);
>>>>>> +
>>>>>> +	dsb_sev();	/* Exit WFI */
>>>>>
>>>>> Which WFI?  This seems to imply that you have some kind of initial
>>>>> firmware.  If so, that should be taking care of the cache initialisation,
>>>>> not the kernel.
>>>>>
>>>>>> +	mb();		/* make sure write buffer is drained */
>>>>>
>>>>> writel() already ensures that.
>>>>>
>>>>>> +	/*
>>>>>> +	 * The secondary processor is waiting to be released from
>>>>>> +	 * the holding pen - release it, then wait for it to flag
>>>>>> +	 * that it has been released by resetting pen_release.
>>>>>> +	 *
>>>>>> +	 * Note that "pen_release" is the hardware CPU ID, whereas
>>>>>> +	 * "cpu" is Linux's internal ID.
>>>>>> +	 */
>>>>>> +	write_pen_release(cpu_logical_map(cpu));
>>>>>> +
>>>>>> +	 /* Send the secondary CPU SEV */
>>>>>> +	dsb_sev();
>>>>>
>>>>> If you even need any of the pen code, if you're having to send a SEV here,
>>>>> wouldn't having a WFE in the pen assembly loop above be a good idea?
>>>>>
>>>>
>>>>
>>>> I have to read more on how WFE and co works.
>>>>
>>>> Hauke
>>>>
>>
>> Thanks,
>> Kapil
>>
> 

Thanks,
Kapil
