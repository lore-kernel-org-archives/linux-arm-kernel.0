From: gdavis@mvista.com (George G. Davis)
Date: Thu, 6 Oct 2011 15:41:45 -0400
Subject: [RFC/PATCH 6/7] ARM: ARM11 MPCore: DMA_CACHE_RWFO operations are
	not preempt safe
In-Reply-To: <20111006164034.GB21464@n2100.arm.linux.org.uk>
References: <05942148-7AFB-4755-A22F-355E0360B098@mvista.com>
	<1317877714-11355-1-git-send-email-gdavis@mvista.com>
	<1317877714-11355-7-git-send-email-gdavis@mvista.com>
	<20111006164034.GB21464@n2100.arm.linux.org.uk>
Message-ID: <F6741C67-B5C0-4309-84A9-11501720A54F@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Oct 6, 2011, at 12:40 PM, Russell King - ARM Linux wrote:

> On Thu, Oct 06, 2011 at 01:08:33AM -0400, gdavis at mvista.com wrote:
>> v6_dma_inv_range:
>> #ifdef CONFIG_DMA_CACHE_RWFO
>> +#ifdef CONFIG_PREEMPT
>> +	stmdb	sp!, {r4, r10, r11}
>> +	get_thread_info r10
>> +	ldr	r4, [r10, #TI_PREEMPT]		@ get preempt count
>> +	add	r11, r4, #1			@ increment it
>> +	str	r11, [r10, #TI_PREEMPT]		@ disable preempt
>> +#endif
> 
> r11 is the frame pointer.  On kernels built with the frame pointer
> enabled, this register must either be a valid frame pointer or zero.

Doh!

> There's no reason to use r4, r10 and r11 here - you could use r4, r5
> and ip (r12) - and then there's no need to save ip as that's allowed
> to be corrupted by called functions.

OK, I'll make these changes in the next round.

Thanks again!

--
Regards,
George
