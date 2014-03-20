From: pullip.cho@samsung.com (Cho KyongHo)
Date: Thu, 20 Mar 2014 19:03:33 +0900
Subject: [PATCH v11 10/27] iommu/exynos: use managed device helper
 functions
In-Reply-To: <532988CA.4000008@samsung.com>
References: <20140314140542.f4ded6c50dbd8a1d937bf354@samsung.com>
 <CAK9yfHw7zYaX9EYFE+m3Mh-u8Uiyubx-cS0EwPmfW+0weLiBKw@mail.gmail.com>
 <20140318200915.7dd833ce0fddbbd6ecd8dac9@samsung.com>
 <532862ED.8040809@samsung.com>
 <20140319175927.a3feadcacbffe80eca1d3421@samsung.com>
 <CAK9yfHxxo2eFh38gPZkpYf1ueBWySWqPzgLV_tSSykzHhNzN8g@mail.gmail.com>
 <532988CA.4000008@samsung.com>
Message-ID: <20140320190333.9c3555b097e97d593faddbdd@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Mar 2014 13:08:42 +0100, Tomasz Figa wrote:
> On 19.03.2014 10:01, Sachin Kamat wrote:
> > On 19 March 2014 14:29, Cho KyongHo <pullip.cho@samsung.com> wrote:
> >> On Tue, 18 Mar 2014 16:14:53 +0100, Tomasz Figa wrote:
> >>> On 18.03.2014 12:09, Cho KyongHo wrote:
> >>>> On Fri, 14 Mar 2014 20:52:43 +0530, Sachin Kamat wrote:
> >>>>> Hi KyongHo,
> >>>>>
> >>>>> On 14 March 2014 10:35, Cho KyongHo <pullip.cho@samsung.com> wrote:
> >>>>>> This patch uses managed device helper functions in the probe().
> >>>>>>
> >>>>>> Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> >>>>>> ---
> >>>>> [snip]
> >>>>>
> >>>>>> +       data->clk = devm_clk_get(dev, "sysmmu");
> >>>>>> +       if (IS_ERR(data->clk)) {
> >>>>>> +               dev_info(dev, "No gate clock found!\n");
> >>>>>> +               data->clk = NULL;
> >>>>>> +       }
> >>>>>
> >>>>> Why aren't you returning from here upon error?
> >>>>
> >>>> It is for the case of a System MMU which does not need clock gating.
> >>>>
> >>>
> >>> Are there really such cases?
> >>>
> >>
> >> Yes.
> >> Especially in the case of initial stage of new SoC development.
> >>
> >> I have experianced some software workaround for H/W restriction
> >> needs prevention of clock gating for some devices.
> >
> > So aren't these basically some exceptions/hacks rather than the usual way
> > of functioning of the device?
> >
> 
> This actually raises a good question, whether we really need to support 
> such early development SoC versions in mainline.
> 
> Another thing is that if you need to assure that a clock is ungated, you 
> must acquire it and prepare_enable explicitly, so I don't think this 
> kind of handling is correct.
> 
On early development step of a new SoC, clock related stuffs and
some device drivers like display controller are usually developed in parallel.

In that case, -ENOENT from clk_get() must not treated as an error.
"[PATCH v11 20/17] iommu/exynos: allow having multiple System MMUs for a master H/W"
patch distinguishes -ENOENT from other error values returned by devm_clk_get().

Regards,

KyongHo
