From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 12 Nov 2018 16:52:37 -0800
Subject: [PATCH v4 6/6] arch: Move initrd= parsing into do_mounts_initrd.c
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075013A592A0B@us01wembx1.internal.synopsys.com>
References: <20181105225431.24485-1-f.fainelli@gmail.com>
 <20181105225431.24485-7-f.fainelli@gmail.com>
 <C2D7FE5348E1B147BCA15975FBA23075013A5929ED@us01wembx1.internal.synopsys.com>
 <05f56763-1530-933d-2ce3-3653ad4c685f@gmail.com>
 <C2D7FE5348E1B147BCA15975FBA23075013A592A0B@us01wembx1.internal.synopsys.com>
Message-ID: <04d6d0cb-8e60-88a0-061e-62c7c70024c5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/18 4:40 PM, Vineet Gupta wrote:
> On 11/12/18 4:38 PM, Florian Fainelli wrote:
>>>>  #ifdef CONFIG_BLK_DEV_INITRD
>>>> -	if (initrd_start)
>>>> -		memblock_reserve(__pa(initrd_start), initrd_end - initrd_start);
>>>> +	if (phys_initrd_size) {
>>>> +		memblock_reserve(phys_initrd_start, phys_initrd_size);
>>>> +		initrd_start = (unsigned long)__va(phys_initrd_start);
>>>> +		initrd_end = initrd_start + phys_initrd_size;
>>>> +	}
>>>>  #endif
>>> The common code now uses phys_initrd*, and you also use the same in ARC code, do
>>> we still need the initrd_* setting here ?
>>> ARC semantics was using them as PA anyways.
>> Yes, the generic initrd code expects initrd_start/end to be virtual
>> addresses, which we now directly derive from phys_initrd_start, that
>> should really be equivalent.
> 
> So we can skip this explicit setting above - ARC arch code doesn't access the virt
> initrd_start

OK, you are saying we could just have the generic initrd code do this
assignment instead of having each architecture do it, is that a correct
understanding? If so, I suppose it could be done, whether as of this
patch series or as a follow-up, either way is fine with me.

One possible caveat is if __va() and __phys_to_virt() behave differently
(e.g: because of CONFIG_DEBUG_VIRTUAL or other things).
-- 
Florian
