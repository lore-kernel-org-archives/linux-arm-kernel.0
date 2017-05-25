From: angus@akkea.ca (Angus Ainslie)
Date: Thu, 25 May 2017 06:39:16 -0600
Subject: [PATCH] clk: sunxi-ng: sun5i: Fix ahb_bist_clk definition
In-Reply-To: <CAGb2v66tpj4y2TdF2kz7Cb9fM-M1pBhuq137a80o0rjenF2AJA@mail.gmail.com>
References: <1495643669-28221-1-git-send-email-boris.brezillon@free-electrons.com>
 <ad72ceff73364add5cfe25b6143a68ca@www.akkea.ca>
 <CAGb2v66tpj4y2TdF2kz7Cb9fM-M1pBhuq137a80o0rjenF2AJA@mail.gmail.com>
Message-ID: <174d7dbf70471f4b823d8fa295303ad7@www.akkea.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-05-25 01:47, Chen-Yu Tsai wrote:
> On Thu, May 25, 2017 at 2:51 AM, Angus Ainslie <angus@akkea.ca> wrote:
>> On 2017-05-24 10:34, Boris Brezillon wrote:
>>> 
>>> AHB BIST gate is actually controlled with bit 7.
>>> 
>>> This bug was detected while trying to use the NAND controller which 
>>> is
>>> using the DMA engine to transfer data to the NAND.
>>> Since the ahb_bist_clk gate bit conflicts with the ahb_dma_clk gate 
>>> bit,
>>> the core was disabling the DMA engine clock as part of its 'disable
>>> unused clks' procedure, which was causing all DMA transfers to fail 
>>> after
>>> this point.
>>> 
>>> Fixes: 5e73761786d6 ("clk: sunxi-ng: Add sun5i CCU driver")
>>> Cc: stable at vger.kernel.org
>>> Reported-by: Angus Ainslie <angus@akkea.ca>compatible =
>>> "nextthing,chip-pro", "nextthing,gr8";
>>> Signed-off-by: Boris Brezillon <boris.brezillon@frecompatible =
>>> "nextthing,chip-pro", "nextthing,gr8";e-electrons.com>
>>> ---
>>>  drivers/clk/sunxi-ng/ccu-sun5i.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>> 
>>> diff --git a/drivers/clk/sunxi-ng/ccu-sun5i.c
>>> b/drivers/clk/sunxi-ng/ccu-sun5i.c
>>> index 5c476f966a72..5372bf8be5e6 100644
>>> --- a/drivers/clk/sunxi-ng/ccu-sun5i.c
>>> +++ b/drivers/clk/sunxi-ng/ccu-sun5i.c
>>> @@ -243,7 +243,7 @@ static SUNXI_CCU_GATE(ahb_ss_clk,   "ahb-ss",
>>> "ahb",
>>>  static SUNXI_CCU_GATE(ahb_dma_clk,     "ahb-dma",      "ahb",
>>>                       0x060, BIT(6), 0);
>>>  static SUNXI_CCU_GATE(ahb_bist_clk,    "ahb-bist",     "ahb",
>>> -                     0x060, BIT(6), 0);
>>> +                     0x060, BIT(7), 0);
>>>  static SUNXI_CCU_GATE(ahb_mmc0_clk,    "ahb-mmc0",     "ahb",
>>>                       0x060, BIT(8), 0);
>>>  static SUNXI_CCU_GATE(ahb_mmc1_clk,    "ahb-mmc1",     "ahb",
>> 
>> 
>> 
>> The patch works perfectly. Using that I was able to remove the
>> clk_ignore_unsed and CLK_IS_CRITICAL.
>> 
> 
> Is that a Tested-by? :)
> 
> ChenYu

Yeah :)

Tested-by: Angus Ainslie <angus@akkea.ca>
