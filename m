From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 13 Apr 2016 12:36:19 +0200
Subject: [PATCH] clk: samsung: exynos7: Enable clocks for CMU_CCORE and
 CMU_FSYS0 blocks
In-Reply-To: <CA+Ln22G0b1O9HHyePg60Q2uZnGT_a3J1LMU0o3+CpPoLCTbksA@mail.gmail.com>
References: <1460459243-27120-1-git-send-email-alim.akhtar@samsung.com>
 <CA+Ln22G0b1O9HHyePg60Q2uZnGT_a3J1LMU0o3+CpPoLCTbksA@mail.gmail.com>
Message-ID: <570E2123.1000107@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/2016 08:26 AM, Tomasz Figa wrote:
>> > @@ -205,7 +206,11 @@ static struct samsung_cmu_info topc_cmu_info __initdata = {
>> >
>> >  static void __init exynos7_clk_topc_init(struct device_node *np)
>> >  {
>> > +       struct clk *clk;
>> > +
>> >         samsung_cmu_register_one(np, &topc_cmu_info);
>> > +       clk = __clk_lookup("aclk_ccore_133");
>> > +       clk_prepare_enable(clk);
>
> Shouldn't this be rather done before calling
> samsung_cmu_register_one()? I don't remember exactly, but wouldn't
> clock registration trigger reading back current (mux, div) values from
> registers?
> 
> Also, do we have any guarantees on order of initialization of
> particular CMUs? I believe this will happen in order of DT nodes and
> so would be not any kind of guarantee at all.

If these clocks need to be kept enabled perhaps it's better to just set
CLK_IS_CRITICAL flag for them? Patches adding this flag are already in
clk-next branch in the clk git tree. This way the clocks would get 
enabled within the clk_register() call.

The CMU registration order is enforced by listing input clocks to each
CMU in DT. However, I wouldn't be concerned much about it in context 
of this patch. We are enabling here clocks which belong to same CMU.
samsung_cmu_register_one() needs to be called first for subsequent 
__clk_lookup() calls to work.

Perhaps related bits need to be set manually in CMU registers before
registering a clock provider for the CMU, to fulfil the requirements.

Anyway, summary of the $subject patch seems not precise enough:

"This patch enables clocks for CMU_CCORE and CMU_FSYS0 blocks. This is
required before accessing registers of these blocks."

We need to enable selected clocks (i.e. access the CMU's registers)
before accessing this CMU's registers? 

--
Regards, 
Sylwester
