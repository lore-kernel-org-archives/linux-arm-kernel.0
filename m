From: caesar.upstream@gmail.com (Caesar Wang)
Date: Tue, 3 Nov 2015 17:04:16 +0800
Subject: [RESEND PATCH] ARM: errata: Workaround for Cortex-A12 erratum
 818325
In-Reply-To: <7094999.meGITi6gTu@wuerfel>
References: <1446538209-13490-1-git-send-email-wxt@rock-chips.com>
 <1446538209-13490-2-git-send-email-wxt@rock-chips.com>
 <7094999.meGITi6gTu@wuerfel>
Message-ID: <56387890.2090802@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2015?11?03? 16:45, Arnd Bergmann ??:
> On Tuesday 03 November 2015 16:10:09 Caesar Wang wrote:
>> +       /* Cortex-A12 Errata */
>> +       ldr     r10, =0x00000c0d                @ Cortex-A12 primary part number
>> +       teq     r0, r10
>> +       bne     5f

beq  __ca15_errata:
>> +#ifdef CONFIG_ARM_ERRATA_818325
>> +       teq     r6, #0x00                       @ present in r0p0
>> +       teqne   r6, #0x01                       @ present in r0p1-00lac0-rc11
>> +       mrceq   p15, 0, r10, c15, c0, 1         @ read diagnostic register
>> +       orreq   r10, r10, #1 << 12              @ set bit #12
>> +       mcreq   p15, 0, r10, c15, c0, 1         @ write diagnostic register
>> +       isb
>> +#endif
>>          /* Cortex-A15 Errata */
>>
> Does this still build? You seem to have lost the '5:' label.

No,  I didn't have build in next kernel.

Yup,  the patch need a bit change from the message.

commit 17e7bf86690eaad4906d2295f0bd171cc194633b
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Sat Apr 4 21:34:33 2015 +0100

     ARM: proc-v7: move CPU errata out of line



-----
Original patch:
https://patchwork.kernel.org/patch/4735341/

Applied and verified on kernel V3.14.



>
> 	Arnd
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Thanks,
Caesar
