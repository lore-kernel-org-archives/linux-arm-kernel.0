From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 4 Sep 2014 23:02:48 -0700
Subject: [PATCH 1/2] clk: Make __clk_lookup() use a list instead of tree
 search
In-Reply-To: <1409880209-25094-1-git-send-email-sboyd@codeaurora.org>
References: <CAF6AEGtk=KhW+m-jc6VzH=pHGgnE1Uzq0tYiqqnX0sPHV1rbPQ@mail.gmail.com>
 <1409880209-25094-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140905060248.GA22593@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04, Stephen Boyd wrote:
> In the near future we're going to move the prepare lock to be a
> per-clock ww_mutex. __clk_lookup() is called very deep in the
> set-rate path and we would like to avoid having to take all the
> locks in the clock tree to search for a clock (basically
> defeating the purpose of introducing per-clock locks). Introduce
> a new list that contains all clocks registered in the system and
> walk this list until the clock is found.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Actually this won't work. We can't grab the list lock while the
prepare lock is held. So we need to do the debugfs stuff with a
different lock and do it outside of the prepare lock.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
