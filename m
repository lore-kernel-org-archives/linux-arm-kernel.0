From: yang.shi@linaro.org (Shi, Yang)
Date: Wed, 04 Nov 2015 10:41:53 -0800
Subject: [PATCH] arm64: bpf: fix div-by-zero case
In-Reply-To: <CABg9mcuAuoSBg4zWYHnaTzAGsH4BK5-VhD=HRDmsHJRCUrnJUw@mail.gmail.com>
References: <1446620204-4228-1-git-send-email-zlim.lnx@gmail.com>	<CAKU6vyZu5KNAipSVUMg8ASnRXztVwh57weKXxXOXkqAJ3erDBQ@mail.gmail.com>	<563A4C9A.7000002@linaro.org>
 <CABg9mcuAuoSBg4zWYHnaTzAGsH4BK5-VhD=HRDmsHJRCUrnJUw@mail.gmail.com>
Message-ID: <563A5171.5070608@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/4/2015 10:25 AM, Z Lim wrote:
> On Wed, Nov 4, 2015 at 10:21 AM, Shi, Yang <yang.shi@linaro.org> wrote:
>> On 11/3/2015 11:04 PM, Xi Wang wrote:
>>>
>>> On Tue, Nov 3, 2015 at 10:56 PM, Zi Shen Lim <zlim.lnx@gmail.com> wrote:
>>>>
>>>>           case BPF_ALU | BPF_DIV | BPF_X:
>>>>           case BPF_ALU64 | BPF_DIV | BPF_X:
>>>> +       {
>>>> +               const u8 r0 = bpf2a64[BPF_REG_0];
>>>> +
>>>> +               /* if (src == 0) return 0 */
>>>> +               jmp_offset = 3; /* skip ahead to else path */
>>>> +               check_imm19(jmp_offset);
>>>> +               emit(A64_CBNZ(is64, src, jmp_offset), ctx);
>>>> +               emit(A64_MOVZ(1, r0, 0, 0), ctx);
>>>> +               jmp_offset = epilogue_offset(ctx);
>>>> +               check_imm26(jmp_offset);
>>>> +               emit(A64_B(jmp_offset), ctx);
>>>> +               /* else */
>>>>                   emit(A64_UDIV(is64, dst, dst, src), ctx);
>>>>                   break;
>>>> +       }
>>>>           case BPF_ALU | BPF_MOD | BPF_X:
>>>>           case BPF_ALU64 | BPF_MOD | BPF_X:
>>>
>>>
>>> BPF_MOD might need the same fix.
>
> I'll post a fix for this case as well.
>
>>
>>
>> Agreed, and we may need add one more test cases in test_bpf module to cover
>> MOD?
>
> Let me know if you have a test case ready :)

Does the below change look like a valid test?

+               "MOD default X",
+               .u.insns = {
+                       /*
+                        * A = 0x42
+                        * A = A mod X ; this halt the filter execution 
if X is 0
+                        * ret 0x42
+                        */
+                       BPF_STMT(BPF_LD | BPF_IMM, 0x42),
+                       BPF_STMT(BPF_ALU | BPF_MOD | BPF_X, 0),
+                       BPF_STMT(BPF_RET | BPF_K, 0x42),
+               },
+               CLASSIC | FLAG_NO_DATA,
+               {},
+               { {0x1, 0x0 } },
+       },
+       {
+               "MOD default A",
+               .u.insns = {
+                       /*
+                        * A = A mod 1
+                        * ret A
+                        */
+                       BPF_STMT(BPF_ALU | BPF_MOD | BPF_K, 0x1),
+                       BPF_STMT(BPF_RET | BPF_A, 0x0),
+               },
+               CLASSIC | FLAG_NO_DATA,
+               {},
+               { {0x1, 0x0 } },
+       },

My test result with it:
test_bpf: #284 MOD default X jited:1 ret 66 != 0 FAIL (1 times)
test_bpf: #285 MOD default A jited:1 102 PASS

If it looks right, I will post a patch to add the test cases.

Thanks,
Yang

>
>>
>> Yang
>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>>
