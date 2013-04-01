From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 01 Apr 2013 11:25:22 -0700
Subject: [PATCH RFC] clk: divider: Tolerate 0 divider for one based
 dividers
In-Reply-To: <c9f78c47-4926-4233-8cc3-51e0a4cc9c5e@AM1EHSMHS003.ehs.local>
References: <dbceb80f-0303-4ba0-acd8-336dd85444ae@DB8EHSMHS017.ehs.local>
 <20130322171141.834.32801@quantum>
 <c9f78c47-4926-4233-8cc3-51e0a4cc9c5e@AM1EHSMHS003.ehs.local>
Message-ID: <20130401182522.8177.96562@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting S?ren Brinkmann (2013-03-22 11:00:15)
> Since some of our dividers have a reset value of 0, I see this warning
> during boot up. My intention here is to get rid of the warning for clocks
> which deem 0 a valid divider value.
> I thought, reusing the ONE_BASED flag might be okay, since all such
> dividers have this redundant 0 state and might handle it similar.
> Otherwise a new flag might be required.
> 

Hi Soren,

A flag will be necessary.  I just checked some documentation for the
divider outputs for OMAP's PLLs and (which use the common clk_divider
type) and programming zero into those dividers is not allowed.  At reset
the divider registers are set to 1.

So it is unsafe to simply reuse the ONE_BASED flag.

Let's keep the current behavior as the default and introduce a new flag
to handle the special case of a zero divider.  Would you like to take a
crack at it?  It might also be nice to update the WARN message with a
hint to take a look at your new flag in case future platforms hit the
same issue as you.

Regards,
Mike

>         S?ren
