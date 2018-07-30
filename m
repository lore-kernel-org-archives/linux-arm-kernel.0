From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Mon, 30 Jul 2018 16:38:48 +0000
Subject: [PATCH v3 1/2] clk: Add of_clk_get_by_name_optional() function
In-Reply-To: <884376f1fd82a99e5d47eeba1fd1aaa3b19bc604.camel@linux.intel.com>
References: <1532957509-14541-1-git-send-email-phil.edworthy@renesas.com>
 <1532957509-14541-2-git-send-email-phil.edworthy@renesas.com>
 <884376f1fd82a99e5d47eeba1fd1aaa3b19bc604.camel@linux.intel.com>
Message-ID: <TY1PR01MB1769B0BC7769B14EFBC0F3DEF52F0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On 30 July 2018 17:04, Andy Shevchenko wrote:
> On Mon, 2018-07-30 at 14:31 +0100, Phil Edworthy wrote:
> > Quite a few drivers get an optional clock, e.g. a clock required to
> > access peripheral's registers that is always enabled on some devices.
> >
> > This function behaves the same as of_clk_get_by_name() except that it
> > will return NULL instead of -EINVAL.
> 
> I'm puzzled a bit.
> 
> __of_clk_get() may return few error codes, and to me ENOENT sounds
> correct when clock is not found. Other error codes should be passed to the
> caller even for optional clocks.
> 
> If above is not true, we need to understand what circumstances for each
> possible returned code are, and fix / act accordingly.
>
> P.S. Possible way like regulator framework does is to return -ENODEV.
> 
> So, basically what I'm asking here is to be sure that single error code (for now
> supposed -EINVAL) in this case is _the_ error code for absent / can't be
> found clock.
of_property_match_string() can return different return values for when:
 the "clock-names" property is missing (-EINVAL),
 the specified clock name in the "clock-names" property is missing  (-ENODATA),
 or internal errors, (e.g. -EILSEQ).
However, if you then call __of_clk_get() with the failed index, you just get
the -EINVAL error.

Looking at it further, __of_clk_get() should return -ENOENT if passed a valid
index (e.g. 0 when name=NULL) and the clock is not there. However, I think
it will take a while to check all possible return values as it's not immediately
clear what they are (to me).

I think the best thing is to test the return value of of_property_match_string()
for -ENODATA, and deal with it then. Then deal with the case of name=NULL
separately.

Thanks
Phil

 >  - Fix check for clock not present. __of_clk_get() returns -EINVAL
> >    if it's not there. Cover case of when there is no clock name.
> 
> --
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
