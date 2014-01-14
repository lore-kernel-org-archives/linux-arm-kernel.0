From: dailemon.gl@gmail.com (Lemon Dai)
Date: Tue, 14 Jan 2014 22:08:44 +0800
Subject: Add .determine_rate to composite clk
In-Reply-To: <CAJiWf8WJxf0S32bPiXGUu3Rwmh36xYdbd0VEpLTG-pwyvVnasg@mail.gmail.com>
References: <CAJiWf8W6rCnnF9Tv+cpcqqshEb4ALD+J_RnYeLkaNVG-Rcd+QA@mail.gmail.com>
 <20140111102843.GU2941@lukather>
 <CAJiWf8WJxf0S32bPiXGUu3Rwmh36xYdbd0VEpLTG-pwyvVnasg@mail.gmail.com>
Message-ID: <CAJiWf8Wvcu0pWBNd7xSm9ES7ApTNp27CXTHWBxbr4msfNd9xCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

The commit 107f3198 in Mike's clk-next branch shows that:
(about line 72 in drivers/clk/clk-composite.c)

        } else if (mux_hw && mux_ops && mux_ops->determine_rate) {
                mux_hw->clk = hw->clk;
                return mux_ops->determine_rate(rate_hw, rate, best_parent_rate,
                                               best_parent_p);


 It should be fixed as follows, at least for reason that  NULL rate_hw
may be used in the old code,

        } else if (mux_hw && mux_ops && mux_ops->determine_rate) {
                mux_hw->clk = hw->clk;
 -              return mux_ops->determine_rate(rate_hw, rate, best_parent_rate,
 +             return mux_ops->determine_rate(mux_hw, rate, best_parent_rate,
                                               best_parent_p);

--
Best regards,
Lemon Dai

On Sun, Jan 12, 2014 at 11:56 AM, Lemon Dai <dailemon.gl@gmail.com> wrote:
> Hi  Maxime,
>
> Thank you for your reply and suggestion.
>  I am sorry for sending  a mail with such a lot of style issues before
> reading Documentation/SubmittingPatches file.
>
> Best wishes,
> Lemon
>
> On Sat, Jan 11, 2014 at 6:28 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>> Hi Lemon,
>>
>> On Sat, Jan 11, 2014 at 05:15:58PM +0800, Lemon Dai wrote:
>>> Hi Mike,
>>>
>>> As .determine_rate was added to struct clk and clk_mux_ops, maybe we
>>> should also copy determine_rate operation from mux_ops to
>>> clk_composite_ops in clk_register_composite( ),
>>> to make composite clk implementation more generic.
>>
>> A similar patch is on its way to 3.14 already (commit 107f3198 in
>> Mike's clk-next branch).
>>
>> Also, for future contributions, I'd suggest to read the
>> Documentation/SubmittingPatches file. Your patch had several style
>> issues that are covered in this file.
>>
>> Thanks!
>> Maxime
>>
>> --
>> Maxime Ripard, Free Electrons
>> Embedded Linux, Kernel and Android engineering
>> http://free-electrons.com
