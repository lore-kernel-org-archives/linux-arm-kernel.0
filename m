From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 14 Jul 2010 11:05:46 -0700
Subject: Meaning of clk_round_rate()?
Message-ID: <4C3DFC7A.8020002@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  What is the meaning of clk_round_rate() in the clk API 
(include/linux/clk.h)? The function documentation says "adjust a rate to 
the exact rate a clock can provide". That seems pretty vague. I'm lead 
to believe that it rounds the rate to the closest rate supported. Is 
that correct? Is there some sort of error margin where beyond that it's 
no longer possible to be rounded? 0.5%? 1%?

Assuming it's doing closest matching, I don't see how it's very useful 
in practice. Some users of clk_round_rate() are blindly searching up and 
down in the frequency space until they find a suitable rate (see 
sound/atmel/abdac.c and sound/spi/at73c213.c). These drivers might be 
better served by something like a clk_round_rate_up() and a 
clk_round_rate_down() which would round the rate to the nearest higher 
and lower frequency respectively without requiring complex loops around 
clk_round_rate().

In addition, an up/down rounding approach would make it simpler for 
drivers to find a min/max rate (for example display panels have a max 
frequency they can support).

A similar approach was suggested by David Brownell [1] but nothing came 
of it.

[1] http://article.gmane.org/gmane.linux.ports.arm.kernel/38076

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
