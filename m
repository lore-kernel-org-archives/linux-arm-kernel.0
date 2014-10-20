From: js07.lee@gmail.com (Jungseung Lee)
Date: Tue, 21 Oct 2014 00:54:44 +0900
Subject: [PATCH] arm: fix flush_pfn_alias
In-Reply-To: <2144086.KBLsLT82pe@wuerfel>
References: <1413809642-12931-1-git-send-email-js07.lee@gmail.com>
 <2144086.KBLsLT82pe@wuerfel>
Message-ID: <CAPP0e=MHg6Q8pt_Peb2zfqX4M3AQdSRTRa-pGmSQu55dv0NkWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> L1_CACHE_BYTES could be larger than real L1 cache line size.
> >> In that case, flush_pfn_alias function would omit to flush last bytes
> >> as much as L1_CACHE_BYTES - real cache line size.
> >
> >Can you list an example on what CPU this would happen in the
> >patch description? Isn't the L1 cache line size always 32 bytes on ARM?
>

It's 64bytes on A15 and 32bytes on A9.
However, L1_CACHE_BYTES is 64 on ARMv7.

>
> > So fix end address to "to + PAGE_SIZE - 1". The bottom bits of the address
> > is LINELEN. that is ignored by mcrr.
> >
> > Signed-off-by: Jungseung Lee <js07.lee@gmail.com>
>
> Is this needed in stable backports?

Maybe no.

As Russell and Will said, it always would be 32bytes for this codpath.
So that would not make any problem. In my CA9 kernel image, the
function is not included also.

But the code that using L1_CACHE_BYTES should be modified ,
since that is not real cache line size and cause misunderstanding.
