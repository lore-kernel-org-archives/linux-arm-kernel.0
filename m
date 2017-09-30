From: julian.calaby@gmail.com (Julian Calaby)
Date: Sat, 30 Sep 2017 15:35:59 +1000
Subject: [linux-sunxi] Re: [PATCH v3 04/14] drm/sun4i: tcon: Add support
 for demuxing TCON output on A31
In-Reply-To: <CAGb2v65VhtEckRCXi4X5AjmC-5CSHavATu8fKyEHOivmYqZkww@mail.gmail.com>
References: <20170929082306.16193-1-wens@csie.org>
 <20170929082306.16193-5-wens@csie.org>
 <20170929102006.2wz7wrkpplxwynoh@flea>
 <CAGb2v65VhtEckRCXi4X5AjmC-5CSHavATu8fKyEHOivmYqZkww@mail.gmail.com>
Message-ID: <CAGRGNgUmo6ZztajhG=uZrXGsC9pxySswxLd4P-gk6xdknLX-NQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On Fri, Sep 29, 2017 at 8:22 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Fri, Sep 29, 2017 at 6:20 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>> On Fri, Sep 29, 2017 at 08:22:56AM +0000, Chen-Yu Tsai wrote:
>>> On systems with 2 TCONs such as the A31, it is possible to demux the
>>> output of the TCONs to one encoder.
>>>
>>> Add support for this for the A31.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>> ---
>>>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 38 ++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 38 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>>> index 7bf51abaee97..c949309d4285 100644
>>> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>>> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>>> @@ -112,6 +112,21 @@ void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable)
>>>  }
>>>  EXPORT_SYMBOL(sun4i_tcon_enable_vblank);
>>>
>>> +static struct sun4i_tcon *sun4i_get_first_tcon(struct drm_device *drm)
>>
>> Would that make sense to make it a bit more generic, and pass the id
>> to look for as an argument?
>
> The reason to look for TCON0 explicitly is to access the muxing registers, which
> are only available in TCON0. Other than that, there's nothing else
> shared between
> the two TCONs. So there's no particular reason to look for TCON1 explicitly.

In that case: in the bizarre case where we're trying to use this mux
type and there is no TCON0, shouldn't we fail?

(Also, the code doesn't make sense if we have some TCON1 and TCON2 in
that order as it'll return TCON2)

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
