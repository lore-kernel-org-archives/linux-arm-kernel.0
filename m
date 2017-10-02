From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 2 Oct 2017 15:11:37 +0800
Subject: [linux-sunxi] Re: [PATCH v3 04/14] drm/sun4i: tcon: Add support
 for demuxing TCON output on A31
In-Reply-To: <CAGRGNgUFAmoBH4OFi+DUW6JU0tOPAZbS_9Dq7tKA+m8UT7vhnw@mail.gmail.com>
References: <20170929082306.16193-1-wens@csie.org>
 <20170929082306.16193-5-wens@csie.org>
 <20170929102006.2wz7wrkpplxwynoh@flea>
 <CAGb2v65VhtEckRCXi4X5AjmC-5CSHavATu8fKyEHOivmYqZkww@mail.gmail.com>
 <CAGRGNgUmo6ZztajhG=uZrXGsC9pxySswxLd4P-gk6xdknLX-NQ@mail.gmail.com>
 <CAGb2v66epS9OLAQthYOrn7B48E80jsfy9dhyLPHyo4NmAOTCbg@mail.gmail.com>
 <CAGRGNgUFAmoBH4OFi+DUW6JU0tOPAZbS_9Dq7tKA+m8UT7vhnw@mail.gmail.com>
Message-ID: <CAGb2v65Kas9hB4bnE7z=RC7wQ7_DvMgfm8V0aoifNsnqNfbcoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 30, 2017 at 2:26 PM, Julian Calaby <julian.calaby@gmail.com> wrote:
> Hi Chen-Yu,
>
> On Sat, Sep 30, 2017 at 3:58 PM, Chen-Yu Tsai <wens@csie.org> wrote:
>> On Sat, Sep 30, 2017 at 1:35 PM, Julian Calaby <julian.calaby@gmail.com> wrote:
>>> Hi Chen-Yu,
>>>
>>> On Fri, Sep 29, 2017 at 8:22 PM, Chen-Yu Tsai <wens@csie.org> wrote:
>>>> On Fri, Sep 29, 2017 at 6:20 PM, Maxime Ripard
>>>> <maxime.ripard@free-electrons.com> wrote:
>>>>> On Fri, Sep 29, 2017 at 08:22:56AM +0000, Chen-Yu Tsai wrote:
>>>>>> On systems with 2 TCONs such as the A31, it is possible to demux the
>>>>>> output of the TCONs to one encoder.
>>>>>>
>>>>>> Add support for this for the A31.
>>>>>>
>>>>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>>>>> ---
>>>>>>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 38 ++++++++++++++++++++++++++++++++++++++
>>>>>>  1 file changed, 38 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>>>>>> index 7bf51abaee97..c949309d4285 100644
>>>>>> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>>>>>> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>>>>>> @@ -112,6 +112,21 @@ void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable)
>>>>>>  }
>>>>>>  EXPORT_SYMBOL(sun4i_tcon_enable_vblank);
>>>>>>
>>>>>> +static struct sun4i_tcon *sun4i_get_first_tcon(struct drm_device *drm)
>>>>>
>>>>> Would that make sense to make it a bit more generic, and pass the id
>>>>> to look for as an argument?
>>>>
>>>> The reason to look for TCON0 explicitly is to access the muxing registers, which
>>>> are only available in TCON0. Other than that, there's nothing else
>>>> shared between
>>>> the two TCONs. So there's no particular reason to look for TCON1 explicitly.
>>>
>>> In that case: in the bizarre case where we're trying to use this mux
>>> type and there is no TCON0, shouldn't we fail?
>>
>> It gives out a big warning, indicating something is wrong. If TCON0 is not found
>> it is most likely your device tree is broken. There's nothing more the
>> driver can do.
>> Are you suggesting to return NULL in this case, and also do error
>> handling in the
>> callers?
>
> You're already returning -EINVAL for other failure cases, so a lack of
> TCON0 might as well do the same.
>
>>> (Also, the code doesn't make sense if we have some TCON1 and TCON2 in
>>> that order as it'll return TCON2)
>>
>> I'm guessing you want it to return NULL.
>
> I'm just pointing out the mismatch between getting the "first" TCON
> and the actual behaviour.

Makes sense. I've renamed it to "_get_tcon0" and added more comments
on it's behavior. Also made it return NULL when tcon0 is not found.

ChenYu
