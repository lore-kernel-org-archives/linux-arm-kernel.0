From: daniel@iogearbox.net (Daniel Borkmann)
Date: Wed, 04 Nov 2015 20:39:22 +0100
Subject: [PATCH] arm64: bpf: fix div-by-zero case
In-Reply-To: <563A5171.5070608@linaro.org>
References: <1446620204-4228-1-git-send-email-zlim.lnx@gmail.com>	<CAKU6vyZu5KNAipSVUMg8ASnRXztVwh57weKXxXOXkqAJ3erDBQ@mail.gmail.com>	<563A4C9A.7000002@linaro.org>
 <CABg9mcuAuoSBg4zWYHnaTzAGsH4BK5-VhD=HRDmsHJRCUrnJUw@mail.gmail.com>
 <563A5171.5070608@linaro.org>
Message-ID: <563A5EEA.6020007@iogearbox.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/2015 07:41 PM, Shi, Yang wrote:
...
>>> Agreed, and we may need add one more test cases in test_bpf module to cover
>>> MOD?
>>
>> Let me know if you have a test case ready :)
>
> Does the below change look like a valid test?
>
> +               "MOD default X",
> +               .u.insns = {
> +                       /*
> +                        * A = 0x42
> +                        * A = A mod X ; this halt the filter execution if X is 0
> +                        * ret 0x42
> +                        */
> +                       BPF_STMT(BPF_LD | BPF_IMM, 0x42),
> +                       BPF_STMT(BPF_ALU | BPF_MOD | BPF_X, 0),
> +                       BPF_STMT(BPF_RET | BPF_K, 0x42),
> +               },
> +               CLASSIC | FLAG_NO_DATA,
> +               {},
> +               { {0x1, 0x0 } },
> +       },
> +       {
> +               "MOD default A",
> +               .u.insns = {
> +                       /*
> +                        * A = A mod 1
> +                        * ret A
> +                        */
> +                       BPF_STMT(BPF_ALU | BPF_MOD | BPF_K, 0x1),
> +                       BPF_STMT(BPF_RET | BPF_A, 0x0),
> +               },
> +               CLASSIC | FLAG_NO_DATA,
> +               {},
> +               { {0x1, 0x0 } },
> +       },
>
> My test result with it:
> test_bpf: #284 MOD default X jited:1 ret 66 != 0 FAIL (1 times)
> test_bpf: #285 MOD default A jited:1 102 PASS
>
> If it looks right, I will post a patch to add the test cases.

Looks good to me.

Thanks,
Daniel
