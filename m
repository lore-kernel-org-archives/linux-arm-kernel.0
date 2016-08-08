From: john.stultz@linaro.org (John Stultz)
Date: Mon, 8 Aug 2016 16:23:56 -0700
Subject: [RFC][PATCH 4/4] arm64: dts: hikey: Add pstore support for HiKey
In-Reply-To: <CAGXu5j+UHuTDT=_DXcKHdxM0CWAp7kkwYiDSenbqk7Ub7yXX6w@mail.gmail.com>
References: <1470697426-16426-1-git-send-email-john.stultz@linaro.org>
 <1470697426-16426-4-git-send-email-john.stultz@linaro.org>
 <CAGXu5j+UHuTDT=_DXcKHdxM0CWAp7kkwYiDSenbqk7Ub7yXX6w@mail.gmail.com>
Message-ID: <CALAqxLWEaVkhOveoCOy2u6sN1pPfFeM4oj3C4Yn-=ZeKvHT4fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 8, 2016 at 4:20 PM, Kees Cook <keescook@chromium.org> wrote:
> On Mon, Aug 8, 2016 at 4:03 PM, John Stultz <john.stultz@linaro.org> wrote:
>> This patch reserves some memory in the DTS and sets up a
>> pstore device tree node to enable pstore support on HiKey.
>>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Guodong Xu <guodong.xu@linaro.org>
>> Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
>> Cc: Wei Xu <xuwei5@hisilicon.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: devicetree at vger.kernel.org
>> Signed-off-by: John Stultz <john.stultz@linaro.org>
>> ---
>>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 17 ++++++++++++++++-
>>  1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
>> index b2683e4..9140306 100644
>> --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
>> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
>> @@ -32,6 +32,7 @@
>>          *  0x05f0,1000 - 0x05f0,1fff: Reboot reason
>>          *  0x06df,f000 - 0x06df,ffff: Mailbox message data
>>          *  0x0740,f000 - 0x0740,ffff: MCU firmware section
>> +        *  0x21f0,0000 - 0x21ff,ffff: pstore/ramoops buffer
>>          *  0x3e00,0000 - 0x3fff,ffff: OP-TEE
>>          */
>>         memory at 0 {
>> @@ -40,7 +41,21 @@
>>                       <0x00000000 0x05f00000 0x00000000 0x00001000>,
>>                       <0x00000000 0x05f02000 0x00000000 0x00efd000>,
>>                       <0x00000000 0x06e00000 0x00000000 0x0060f000>,
>> -                     <0x00000000 0x07410000 0x00000000 0x36bf0000>;
>> +                     <0x00000000 0x07410000 0x00000000 0x1aaf0000>,
>> +                     <0x00000000 0x22000000 0x00000000 0x1c000000>;
>> +       };
>> +
>> +       pstore: pstore at 0x21f00000 {
>> +               no-map;
>> +               reg = <0x0 0x21f00000 0x0 0x00100000>;  /* pstore buffer */
>> +       };
>> +
>> +       ramoops {
>> +               compatible = "ramoops";
>> +               memory-region = <&pstore>;
>> +               record-size     = <0x0 0x00020000>;
>> +               console-size    = <0x0 0x00020000>;
>> +               ftrace-size     = <0x0 0x00020000>;
>>         };
>>
>>         reboot-mode-syscon at 5f01000 {
>
> Heh, sorry, we changed the pstore DT format out from under you. :)
>
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=529182e204db083cb7bda832d1c5c6d9278ba1cb
>
> But otherwise, sure!

Ah! Right. Rob gave me a heads up on this last week, but I forgot
about it over the weekend.

thanks!
-john
