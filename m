From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Mon, 30 Jul 2018 19:03:42 +0300
Subject: [PATCH v3 1/2] clk: Add of_clk_get_by_name_optional() function
In-Reply-To: <1532957509-14541-2-git-send-email-phil.edworthy@renesas.com>
References: <1532957509-14541-1-git-send-email-phil.edworthy@renesas.com>
 <1532957509-14541-2-git-send-email-phil.edworthy@renesas.com>
Message-ID: <884376f1fd82a99e5d47eeba1fd1aaa3b19bc604.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-07-30 at 14:31 +0100, Phil Edworthy wrote:
> Quite a few drivers get an optional clock, e.g. a clock required
> to access peripheral's registers that is always enabled on some
> devices.
> 
> This function behaves the same as of_clk_get_by_name() except that
> it will return NULL instead of -EINVAL.

I'm puzzled a bit.

__of_clk_get() may return few error codes, and to me ENOENT sounds
correct when clock is not found. Other error codes should be passed to
the caller even for optional clocks.

If above is not true, we need to understand what circumstances for each
possible returned code are, and fix / act accordingly.

P.S. Possible way like regulator framework does is to return -ENODEV.

So, basically what I'm asking here is to be sure that single error code
(for now supposed -EINVAL) in this case is _the_ error code for absent /
can't be found clock.

>  - Fix check for clock not present. __of_clk_get() returns -EINVAL
>    if it's not there. Cover case of when there is no clock name.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
