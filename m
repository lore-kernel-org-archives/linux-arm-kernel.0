From: cov@codeaurora.org (Christopher Covington)
Date: Mon, 23 Nov 2015 09:14:39 -0500
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv
 library functions
In-Reply-To: <8472808.1HUuK2O5nn@wuerfel>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <4527012.vmieWOaE32@wuerfel>
 <alpine.LFD.2.20.1511222111020.22569@knanqh.ubzr>
 <8472808.1HUuK2O5nn@wuerfel>
Message-ID: <56531F4F.9010100@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23/2015 03:15 AM, Arnd Bergmann wrote:
> On Sunday 22 November 2015 21:36:45 Nicolas Pitre wrote:
>> On Sun, 22 Nov 2015, Arnd Bergmann wrote:
>>
>>> I've also found some /proc/cpuinfo output to cross-reference SoCs
>>> to their core names.
>>>
>>>               variant part    revision        name            features
>>> dove:         0       0x581   5               PJ4             idivt
>>
>> I just managed to boot my dusty Dove DB and ran a quick test programon 
>> it. Its cpuinfo corresponds to the above.
>>
>> $ cat m.c
>> #include <stdio.h>
>> int mydiv(int, int);
>> int main()
>> {
>>         printf("div test\n");
>>         printf("%d\n", mydiv(12345678, 37));
>>         return 0;
>> }
>> $ cat d.c
>> int mydiv(int x, int y)
>> {
>>         return x/y;
>> }
>> $ gcc -o test m.c d.c
>> $ ./test
>> div test
>> 333666
>> $ gcc -o test m.c d.c -march=armv7ve -mthumb
>> $ ./test
>> div test
>> 333666
>> $ gcc -o test m.c d.c -march=armv7ve -marm
>> $ ./test
>> div test
>> Illegal instruction (core dumped)
>> $
> 
> Ok, thanks a lot! So the reporting in /proc/cpuinfo clearly matches
> the actual features, and we can just treat this as no LPAE / no IDIV
> for kernel compilation, as nobody ever seems to use THUMB2_KERNEL
> in practice.
> 
> PJ4-MP is like Cortex-A15/A7/A12/A17 and supports both IDIV and LPAE,
> which leaves the question whether Scorpion or Krait do the same as
> well, or whether they are outliers and need a special configuration.

LPAE is only supported in the Krait 450.

http://www.anandtech.com/show/7537/qualcomms-snapdragon-805-25ghz-128bit-memory-interface-d3d11class-graphics-more

I'm pretty sure idiv support came earlier, but I don't have the
specifics on hand.

Regards,
Christopher Covington

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
