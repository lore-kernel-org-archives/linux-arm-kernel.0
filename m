From: olof@lixom.net (Olof Johansson)
Date: Fri, 31 Aug 2018 08:38:19 -0700
Subject: [PATCH] irqchip/gic-v3-its: cap lpi_id_bits to reduce memory
 footprint
In-Reply-To: <865zzuyijp.wl-marc.zyngier@arm.com>
References: <1535432006-2304-1-git-send-email-jia.he@hxt-semitech.com>
 <865zzuyijp.wl-marc.zyngier@arm.com>
Message-ID: <CAOesGMgsnE=fQwWMs3bkQFn_-9m3XLsnon+Q=NHB4i+o8b5hiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 1:58 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Tue, 28 Aug 2018 05:53:26 +0100,
> Jia He <hejianet@gmail.com> wrote:
>>
>> In commit fe8e93504ce8 ("irqchip/gic-v3-its: Use full range of LPIs"),
>> it removes the cap for lpi_id_bits. But it will cause more pointless
>> memory footprint.
>>
>> There is a WARN_ON when my QDF2400 server boots up (pagesize is 4k)
>> ============begin===============
>
> [trimming not-so-useful trace]
>
>> ============end============
>>
>> In its_alloc_lpi_tables, lpi_id_bits is 24 in QDF2400. Then
>> its_allocate_prop_table will try to allocate 16M(order 12 if
>> pagesize=4k). Thus it causes the WARN_ON.
>>
>> As said by Marc,
>> Capping lpi_id_bits at 16 (which is what we had before) is plenty,
>> will save a some memory, and gives some margin before we need to push
>> it up again.
>>
>> This patch re-caps the lpi_id_bits.
>>
>> Fixes: fe8e93504ce8 ("irqchip/gic-v3-its: Use full range of LPIs")
>> Signed-off-by: Jia He <jia.he@hxt-semitech.com>
>> Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
>
> Thanks for doing this. Small problem with this patch:
>
> The email comes from hejianet at gmail.com, while the sign off is by
> jia.he at hxt-semitech.com. Your email should start with a:
>
>         From: Jia He <jia.he@hxt-semitech.com>
>
> Other than that:
>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Tested-by: Olof Johansson <olof@lixom.net>

> Thomas, would you mind picking this up so that it gets into the next
> convenient -rc?

Yeah, it'd be great to see this go into -rc2 if possible. Thanks!


-Olof
