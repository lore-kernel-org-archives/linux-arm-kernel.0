From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 25 Mar 2014 16:01:26 +0800
Subject: [RFC PATCH] ASoC: wm8904: add CCF support
In-Reply-To: <20140324110616.GG2269@sirena.org.uk>
References: <1395370262-23305-1-git-send-email-voice.shen@atmel.com>
 <20140321103747.GK23372@e106331-lin.cambridge.arm.com>
 <20140321115511.GM11706@sirena.org.uk> <532F9557.2000402@atmel.com>
 <20140324110616.GG2269@sirena.org.uk>
Message-ID: <533137D6.9010006@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 03/24/2014 07:06 PM, Mark Brown wrote:
> On Mon, Mar 24, 2014 at 10:15:51AM +0800, Bo Shen wrote:
>> On 03/21/2014 07:55 PM, Mark Brown wrote:
>>> On Fri, Mar 21, 2014 at 10:37:47AM +0000, Mark Rutland wrote:
>>>> On Fri, Mar 21, 2014 at 02:51:02AM +0000, Bo Shen wrote:
>
>>>>> +  - wlf,sysclk-from-mclk: set the sys clock is driven from mclk,
>
>>>> Why can the kernel not decide this?
>
>>> It can.
>
>> I really don't know how it decided by kernel (hardcode in machine driver ?),
>> can you point me directly? Thanks.
>
> It can just look to see if there is a suitable system clock present,
> this shouldn't be hard.  If there's a clock connected at a suitable
> rate it should use that, otherwise if there's a clock at an unsuitable
> rate it should either change the rate of the clock or use the FLL.

I try to implement this, I think we can write the wm8904 dt as simple as 
following, can it be acceptable?

Case 1: using SoC provided clock
wm8904:wm8904 at 1a {
	compatible = "wlf,wm8904";
	reg = <0x1a>;
	clocks = <&pck0>;
	clock-name = "mclk";
}

Case 2: using external crystal (For this case, I have no idea to put to 
CCF, so need "wlf,xtal-clk-freq" property).
wm8904:wm8904 at 1a {
	compatible = "wlf,wm8904";
	reg = <0x1a>;
	wlf,xtal-clk-freq = <12000000>;
}

Then we use these clocks to configure FLL.

Btw, I see the "wm2000.c" retrieve the clock, however not see the usage 
cases for it.

Best Regards,
Bo Shen
