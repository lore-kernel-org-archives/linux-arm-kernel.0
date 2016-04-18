From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 18 Apr 2016 17:55:14 +0900
Subject: [PATCH] arm64: dts: uniphier: add /memreserve/ for spin-table
 release address
In-Reply-To: <20160418084508.GA21438@leverpostej>
References: <1460743138-17768-1-git-send-email-yamada.masahiro@socionext.com>
 <20160418084508.GA21438@leverpostej>
Message-ID: <CAK7LNATtWyZtVWrW3nOYjN=aRvCO1w8Rvr6_JWm3QfMMPhrSAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,


2016-04-18 17:45 GMT+09:00 Mark Rutland <mark.rutland@arm.com>:
> On Sat, Apr 16, 2016 at 02:58:58AM +0900, Masahiro Yamada wrote:
>> As Documentation/arm64/booting.txt says, the cpu-release-addr
>> location should be reserved.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
>> index 651c9d9..90909d2 100644
>> --- a/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
>> +++ b/arch/arm64/boot/dts/socionext/uniphier-ph1-ld20.dtsi
>> @@ -42,6 +42,8 @@
>>   *     OTHER DEALINGS IN THE SOFTWARE.
>>   */
>>
>> +/memreserve/ 0x80000100 0x00000008;
>> +
>
> Please add a comment above the memreserve to mention what it is
> protecting. That helps to avoid having this cargo-culted to cases where
> it is not needed.

OK, will do.


> I take it that the code for the spin-table is not in RAM, and does not
> need to be protected similarly?


I use U-Boot to boot Linux for this board.

The code for the spin-table is on SDRAM, and not protected.

I already recognize this problem.

The difficulty for U-Boot is that
U-Boot relocates itself to the top of the DRAM.
So, it is difficult to predict
where the code will be placed.

I will discuss this issue in the U-Boot ML.


So, My current solution is
pre-fetch the code for the spin-table onto I-cache.



-- 
Best Regards
Masahiro Yamada
