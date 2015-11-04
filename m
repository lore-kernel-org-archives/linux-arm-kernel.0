From: zlim.lnx@gmail.com (Z Lim)
Date: Wed, 4 Nov 2015 10:25:05 -0800
Subject: [PATCH] arm64: bpf: fix div-by-zero case
In-Reply-To: <563A4C9A.7000002@linaro.org>
References: <1446620204-4228-1-git-send-email-zlim.lnx@gmail.com>
 <CAKU6vyZu5KNAipSVUMg8ASnRXztVwh57weKXxXOXkqAJ3erDBQ@mail.gmail.com>
 <563A4C9A.7000002@linaro.org>
Message-ID: <CABg9mcuAuoSBg4zWYHnaTzAGsH4BK5-VhD=HRDmsHJRCUrnJUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 4, 2015 at 10:21 AM, Shi, Yang <yang.shi@linaro.org> wrote:
> On 11/3/2015 11:04 PM, Xi Wang wrote:
>>
>> On Tue, Nov 3, 2015 at 10:56 PM, Zi Shen Lim <zlim.lnx@gmail.com> wrote:
>>>
>>>          case BPF_ALU | BPF_DIV | BPF_X:
>>>          case BPF_ALU64 | BPF_DIV | BPF_X:
>>> +       {
>>> +               const u8 r0 = bpf2a64[BPF_REG_0];
>>> +
>>> +               /* if (src == 0) return 0 */
>>> +               jmp_offset = 3; /* skip ahead to else path */
>>> +               check_imm19(jmp_offset);
>>> +               emit(A64_CBNZ(is64, src, jmp_offset), ctx);
>>> +               emit(A64_MOVZ(1, r0, 0, 0), ctx);
>>> +               jmp_offset = epilogue_offset(ctx);
>>> +               check_imm26(jmp_offset);
>>> +               emit(A64_B(jmp_offset), ctx);
>>> +               /* else */
>>>                  emit(A64_UDIV(is64, dst, dst, src), ctx);
>>>                  break;
>>> +       }
>>>          case BPF_ALU | BPF_MOD | BPF_X:
>>>          case BPF_ALU64 | BPF_MOD | BPF_X:
>>
>>
>> BPF_MOD might need the same fix.

I'll post a fix for this case as well.

>
>
> Agreed, and we may need add one more test cases in test_bpf module to cover
> MOD?

Let me know if you have a test case ready :)

>
> Yang
>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
