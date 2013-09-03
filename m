From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 04 Sep 2013 00:36:50 +0200
Subject: [RFC Patch v2 0/3] add temporary parent migration support
In-Reply-To: <1378208072-10173-1-git-send-email-chander.kashyap@linaro.org>
References: <1378208072-10173-1-git-send-email-chander.kashyap@linaro.org>
Message-ID: <3927125.3UOplv4uU5@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chander,

On Tuesday 03 of September 2013 17:04:28 Chander Kashyap wrote:
> Some platform has provision to change cpu parent clock during
> cpu frequency scaling. This patch series provides a mechanism to
> implement the same using CCF.
> 
> Patch1 provides mechanism to migrate to new parent temporarily.
> 
> Patch2 updates the user of clk_register_mux and DEFINE_CLK_MUX which are
> modified to add support for clk migration.
> 
> Patch3 adds support to Exynos5250 to use the clock parent migration
> feature implemented in CCF.

I don't really like this approach. A need to change mux setting 
temporarily is heavily platform-specific and I don't think it should be 
handled by generic code. First of all there are many factor that you would 
have to account for to make this solution generic, such as:
 - board specific alternative parents,
 - exact moment of parent change,
 - some other platform specific conditions, like CPU voltage that must be 
changed when mux is changed, because it changes CPU frequency,
 - and probably a lot of more factors that only people working with all 
the platforms supported (and unsupported yet) by Linux.

I can see at least two solutions for this problem that don't require 
changing core code of common clock framework:

1) Implementing a special clock type using normal mux ops, but also 
registering a notifier for its PRE_RATE_CHANGE and POST_RATE_CHANGE events 
to perform parent switching.

2) Using normal mux clock, but registering such notifiers in clock 
controller or cpufreq driver.

Best regards,
Tomasz
