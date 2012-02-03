From: bill4carson@gmail.com (bill4carson)
Date: Fri, 03 Feb 2012 15:48:17 +0800
Subject: [PATCH] Skip unnecessary pte makeup when clearing it.
In-Reply-To: <4F2B903E.5070609@gmail.com>
References: <1327912567-18966-1-git-send-email-bill4carson@gmail.com>
 <1327912567-18966-2-git-send-email-bill4carson@gmail.com>
 <20120203065432.GG25594@pengutronix.de> <4F2B903E.5070609@gmail.com>
Message-ID: <4F2B9141.1040002@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2012?02?03? 15:43, bill4carson wrote:
>
>
> On 2012?02?03? 14:54, Uwe Kleine-K?nig wrote:
>> Hello,
>>
>> On Mon, Jan 30, 2012 at 04:36:07PM +0800, bill4carson at gmail.com wrote:
>>> From: Bill Carson<bill4carson@gmail.com>
>>>
>>> If we are only about to clear a hardware pte entry, then pte makeup 
>>> code is
>>> unnecessary for cpu_v7_set_pte_ext and armv6_set_pte_ext, so just 
>>> skip it.
>>>
>>> Signed-off-by: Bill Carson<bill4carson@gmail.com>
>> I havn't tested and I don't know if the patch brings any advantages like
>> increased speed. But AFAICT it doesn't change the behaviour of
>> armv6_set_pte_ext and cpu_v7_set_pte_ext.
>>
> Hi, Uwe
>
> I'm sorry I didn't state the purpose of this patch clearly.
> As a matter of fact, it does change the behavior of set_pte_ext :)
>
> Without this patch, the code path when:
> set a pte: line 147->173, 176->181
> clear a pte: line 147->174, 176->181
>
> Point is line 147->173 takes a lot of cpu cycles to figure out the 
> right r3,
> This is only used when set a pte, when clearing a pte, r3 *ALWAYS* has 
> zero
> value! which means line 147->173 doesn't need to be executed in such 
> case.
>
to be precisely 149->170

> 145ENTRY(cpu_v7_set_pte_ext)
> 146#ifdef CONFIG_MMU
> 147 str r1, [r0] @ linux version
> 148
> 149 bic r3, r1, #0x000003f0
> 150 bic r3, r3, #PTE_TYPE_MASK
> 151 orr r3, r3, r2
> 152 orr r3, r3, #PTE_EXT_AP0 | 2
> 153
> 154 tst r1, #1 << 4
> 155 orrne r3, r3, #PTE_EXT_TEX(1)
> 156
> 157 eor r1, r1, #L_PTE_DIRTY
> 158 tst r1, #L_PTE_RDONLY | L_PTE_DIRTY
> 159 orrne r3, r3, #PTE_EXT_APX
> 160
> 161 tst r1, #L_PTE_USER
> 162 orrne r3, r3, #PTE_EXT_AP1
> 163#ifdef CONFIG_CPU_USE_DOMAINS
> 164 @ allow kernel read/write access to read-only user pages
> 165 tstne r3, #PTE_EXT_APX
> 166 bicne r3, r3, #PTE_EXT_APX | PTE_EXT_AP0
> 167#endif
> 168
> 169 tst r1, #L_PTE_XN
> 170 orrne r3, r3, #PTE_EXT_XN
> 171
> 172 tst r1, #L_PTE_YOUNG
> 173 tstne r1, #L_PTE_PRESENT
> 174 moveq r3, #0
> 175
> 176 ARM( str r3, [r0, #2048]! )
> 177 THUMB( add r0, r0, #2048 )
> 178 THUMB( str r3, [r0] )
> 179 mcr p15, 0, r0, c7, c10, 1 @ flush_pte
> 180#endif
> 181 mov pc, lr
> 182ENDPROC(cpu_v7_set_pte_ext)
>
>
>
> With this patch, the code path when:
> set a pte: line 147->150, 153->181
> clear a pte: line 147->152, 176->181
>
> The code path when setting a pte does not change much at all.
> But code path of clearing a pte is significantly shorter than before,
> and performance enhancement is handy here.
>
> 145 ENTRY(cpu_v7_set_pte_ext)
> 146 #ifdef CONFIG_MMU
> 147 str r1, [r0] @ linux version
> 148
> 149 tst r1, #L_PTE_YOUNG
> 150 tstne r1, #L_PTE_PRESENT
> 151 moveq r3, #0
> 152 beq 1f
> 153 bic r3, r1, #0x000003f0
> 154 bic r3, r3, #PTE_TYPE_MASK
> 155 orr r3, r3, r2
> 156 orr r3, r3, #PTE_EXT_AP0 | 2
> 157
> 158 tst r1, #1 << 4
> 159 orrne r3, r3, #PTE_EXT_TEX(1)
> 160
> 161 eor r1, r1, #L_PTE_DIRTY
> 162 tst r1, #L_PTE_RDONLY | L_PTE_DIRTY
> 163 orrne r3, r3, #PTE_EXT_APX
> 164
> 165 tst r1, #L_PTE_USER
> 166 orrne r3, r3, #PTE_EXT_AP1
> 167 #ifdef CONFIG_CPU_USE_DOMAINS
> 168 @ allow kernel read/write access to read-only user pages
> 169 tstne r3, #PTE_EXT_APX
> 170 bicne r3, r3, #PTE_EXT_APX | PTE_EXT_AP0
> 171 #endif
> 172
> 173 tst r1, #L_PTE_XN
> 174 orrne r3, r3, #PTE_EXT_XN
> 175
> 176 1:
> 177 ARM( str r3, [r0, #2048]! )
> 178 THUMB( add r0, r0, #2048 )
> 179 THUMB( str r3, [r0] )
> 180 mcr p15, 0, r0, c7, c10, 1 @ flush_pte
> 181 #endif
> 182 mov pc, lr
> ENDPROC(cpu_v7_set_pte_ext)
>
>
> I hope the above explanation could justify this patch.
>
>
>
> Regards
> Bill
>
>
>
>> Best regards
>> Uwe
>>
>

-- 
I am a slow learner
but I will keep trying to fight for my dreams!

--bill
