From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 15 Jul 2010 11:11:43 +0900
Subject: [PATCH] ARM: S5PV210: allow clk to use clksrc as parents
In-Reply-To: <00e501cb2242$eee8a100$ccb9e300$%kim@samsung.com>
References: <1278395553-9228-1-git-send-email-myungjoo.ham@samsung.com>
	<027d01cb1f51$99a74780$ccf5d680$%kim@samsung.com>
	<AANLkTimvA_gSxZsrkEWZMLRFl82MsW5tV9g4trFmaMIr@mail.gmail.com>
	<038201cb2169$c92ccbf0$5b8663d0$%kim@samsung.com>
	<AANLkTilbDABhIIIWCtiHLsvQtss8A99XYWyCy0MkihD3@mail.gmail.com>
	<039a01cb2180$d36679b0$7a336d10$%kim@samsung.com>
	<AANLkTikf5-KdGju_IcYg8t5ZV3iIzOhr4VdSa104ZZHH@mail.gmail.com>
	<00e501cb2242$eee8a100$ccb9e300$%kim@samsung.com>
Message-ID: <AANLkTinwXE8G_54Nmyv30fm_LIGbwDA1QE7dJwb4hQ3b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Jul 13, 2010 at 1:21 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> MyungJoo Ham wrote:
>>
>
> ?(snip)
>
>> >>
>> > Please refer to below diagram.
>> >
>> > ------------------------------------
>> > ? ? ? ? ? dsys bus
>> > ----------------+-------------------
>> > ? ? ? ? ? ? ? ?|
>> > ? ? ? ? ? ? ? ?|1.clk 'lcd'
>> > ? ? ? ? ? ? ? ?|
>> > ? ? ? ? ? ?+---+-----------+
>> > ? ? ? ? ? ?| ? | FIMD block|
>> > ? ? ? ? ? ?| +-+ ? ? ? ? ? |
>> > ? ? ? ? ? ?| | ? ? ? ? ? ? |
>> > ? ? ? ? ? ?| | |\ ? ? ? ? ?|
>> > ? ? ? ? ? ?| +-|m| ? ? ? ? |
>> > 2.SCLK_FIMD | ? |u|----+ ? ?|
>> > ------------+---|x| ? ?| ? ?|
>> > ? ? ? ? ? ?| ? |/ ? ? | ? ?|
>> > ? ? ? ? ? ?| ? ? ? ? ?| ? ?|
>> > ? ? ? ? ? ?+----------+----+
>> > ? ? ? ? ? ? ? ? ? ? ? |
>> > inside of SoC ? ? ? ? ?|
>> > -----------------------+--------------------------
>> > outside of SoC ? ? ? ? |
>> > ? ? ? ? ? ? ? ? ? ? ? | 3.clk?
>> > ? ? ? ? ? ? ? ? ? ? ? |
>> > ? ? ? ? ? ? ? +--------------+
>> > ? ? ? ? ? ? ? | LCD module ? |
>> > ? ? ? ? ? ? ? +--------------+
>> >
>> > In clock.c the clk 'lcd' means #1 in above diagram.
>> > So you mean clk 'lcd' is #3', maybe confused :-(
>> >
>>
>> Uh.. yes, I meant #3 by the clk LCD.
>>
>> This CLK_GATE_IP - FIMD gates both ACLK_FIMD and SCLK_FIMD at the same
>> time; thus, this should be over the MUX of SCLK_FIMD, I thought. (User
>> Manual: Clock Controler - Clock Gating Control Register
>> (CLK_GATE_IP1)) If we should have a struct clk that represents
>> ACLK_FIMD, the clock representing ACLK_FIMD should not directly
>> control CLK_GATE_IP1 as CLK_GATE_IP1 gates SCLK_FIMD as well if the
>> User Manual is correct.
>>
>> If we really need to represent ACLK_FIMD separately, why don't we
>> create "aclk_fimd" and let "fimd" or "lcd" become a struct clksrc_clk
>> that chooses between aclk_fimd and sclk_fimd? How about this? (and
>> other similar clocks)
>>
>> Anyway, with this feature, we may now think about calling
>> "clk_disable(parent)" when a clk is doing
>> "clk_set_parent(another_parent)" if the clk is "clk_enable"d. I'd be
>> happy to hear any suggestions and comments on this.
>
> Basically, each clock which is used in each device driver such as lcd
> module clock, camemra module clock should be controlled in its device
> driver.
>
> Let's say, in the case of camera module clock, FIMC IP has a specific
> divider which is used clock dividing for camera module clock. And the
> divider which is in FIMC IP has own rate for camera module at that time. So
> cannot/no need to define it in the common clock part such as clock.c.
>
> In other words, can't implement set_rate() or get_rate() for camera module
> clock in the common clock part, because FIMC IP block has own specific
> divider for it.
>

Ah... I've got it. Although "lcd" of CLK_GATE_IP contols SCLK_FIMD and
part of HCLK that goes to FIMD at the same time, as long as the MUX of
SCLK_FIMD and that part of HCLK is in VIDCON (VIDCON0:CLKSEL_F), you
don't want the control to be reside in arch/arm/mach side.

I also think let LCD(anyone who's got w/ VIDCON0) driver controls and
owns the MUX info about SCLK_FIMD/HCLK. What I thought once is that
CLK_GATE_IP:CLK_FIMD controls the lcd clock after the MUX as it
controls both ACLK_FIMD(from HCLK) and SCLK_FIMD at the same time.


Thank you.

>>
>> E.g.,
>>
>> struct clk *a = clk_get("A");
>> clk_set_parent(a, clk_A);
>> clk_enable(a);
>> some ops with a;
>> /* we need another clock speed with different source */
>> clk_set_parent(a, clk_B);
>> some ops with b;
>>
>> In this example, we, at least, need to enable clk_B when
>> clk_set_parent is called and we'd better clk_disable(clk_A) if
>> clk_enable(clk_A) is called at clk_enable(a);
>>
>>
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
> (snip)
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
MyungJoo Ham (???), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
