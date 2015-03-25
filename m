From: jonas@microbit.se (Jonas Andersson)
Date: Wed, 25 Mar 2015 10:06:46 +0100
Subject: at91 clocks
In-Reply-To: <20150325013201.3f01fc22@bbrezillon>
References: <55117568.6090202@microbit.se> <20150325013201.3f01fc22@bbrezillon>
Message-ID: <55127AA6.5050902@microbit.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris and others,

On 2015-03-25 01:32, Boris Brezillon wrote:
> Hi Jonas,
>
> On Tue, 24 Mar 2015 15:32:08 +0100
> Jonas Andersson <jonas@microbit.se> wrote:
>
>> Hi all,
>>
>> I am working on a system with at91sam9260 soc. Trying to move from
>> kernel 3.17.4 to 3.19.2. I have problem with pck1 clock.
>>
>> In my old code i use clk_get() to get pck1 and pllb, set pllb as parent
>> for pck1, set rate for pck1, enable pck1.
> How do you do that (clk_set_parent + clk_set_rate) ?
> Could you paste your code somewhere ?

Yes, see http://pastie.org/10052161

>
>> Extract from
>> /sys/kernel/debug/at91_clk:
>> pllb       users= 1 on   96000000 Hz main
>> pck1       users= 1 on   12000000 Hz pllb
>>
> With the new implementation calling clk_set_rate(pck1, 120000000)
> should do the job: it should choose the best parent clk and divisor.

Ok thank you for that information. I tried that now (new code in link 
above), and i got a clock output but not exactly my wanted 12MHz. I 
measure 9.216MHz at pck1 output.

        mainck                             2            2 
18432000          0 0
           prog1                           1            1 
9216000          0 0
              pck1                         1            1 
9216000          0 0

pllbck is still unused.

I tried kernel 4.0-rc5 but it hangs in boot after ethernet init.

Best regards
  Jonas
