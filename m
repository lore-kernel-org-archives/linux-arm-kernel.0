From: emil.l.velikov@gmail.com (Emil Velikov)
Date: Thu, 2 Feb 2017 12:37:21 +0000
Subject: [PATCH V7 3/4] drm/bridge: Add driver for GE B850v3 LVDS/DP++
 Bridge
In-Reply-To: <3e31-58931d80-1-221fa900@101383713>
References: <CACvgo535iyFvdOWzQHRnU++Ye0GgyZyN3R9ALSXRP7k3EPyRGA@mail.gmail.com>
 <3e31-58931d80-1-221fa900@101383713>
Message-ID: <CACvgo50bOZ=jzeJc_J4_7fpiEh9-ATKo1KOhAia2679AGA=mng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 February 2017 at 11:53, Peter Senna Tschudin
<peter.senna@collabora.co.uk> wrote:
>
> On 02 February, 2017 02:46 CET, Emil Velikov <emil.l.velikov@gmail.com> wrote:
>
>> On 1 February 2017 at 11:35, Daniel Vetter <daniel@ffwll.ch> wrote:
>> > On Wed, Feb 01, 2017 at 10:58:43AM +0000, Peter Senna Tschudin wrote:
>> >> Hi Archit,
>> >>
>> >> On 01 February, 2017 10:44 CET, Archit Taneja <architt@codeaurora.org> wrote:
>> >>
>> >> >
>> >> >
>> >> > On 01/30/2017 10:35 PM, Jani Nikula wrote:
>> >> > > On Sat, 28 Jan 2017, Peter Senna Tschudin <peter.senna@collabora.com> wrote:
>> >> > >> On Thu, Jan 05, 2017 at 01:18:47PM +0530, Archit Taneja wrote:
>> >> > >> Hi Archit,
>> >> > >>
>> >> > >> Thank you for the comments!
>> >> > >>
>> >> > >> [...]
>> >> > >>>> +      total_size = (block[EDID_EXT_BLOCK_CNT] + 1) * EDID_LENGTH;
>> >> > >>>> +      if (total_size > EDID_LENGTH) {
>> >> > >>>> +              kfree(block);
>> >> > >>>> +              block = kmalloc(total_size, GFP_KERNEL);
>> >> > >>>> +              if (!block)
>> >> > >>>> +                      return NULL;
>> >> > >>>> +
>> >> > >>>> +              /* Yes, read the entire buffer, and do not skip the first
>> >> > >>>> +               * EDID_LENGTH bytes.
>> >> > >>>> +               */
>> >> > >>>
>> >> > >>> Is this the reason why you aren't using drm_do_get_edid()?
>> >>
>> >> > >>
>> >> > >> Yes, for some hw specific reason, it is necessary to read the entire
>> >> > >> EDID buffer starting from 0, not block by block.
>> >> > >
>> >> > > Hrmh, I'm planning on moving the edid override and firmware edid
>> >> > > mechanisms at the drm_do_get_edid() level to be able to truly and
>> >> > > transparently use a different edid. Currently, they're only used for
>> >> > > modes, really, and lead to some info retrieved from overrides, some from
>> >> > > the real edid. This kind of hacks will bypass the override/firmware edid
>> >> > > mechanisms then too. :(
>> >> >
>> >> > It seems like there is a HW issue which prevents them from reading EDID
>> >> > from an offset. So, I'm not sure if it is a hack or a HW limitation.
>> >>
>> >> >
>> >> > One way around this would be to hide the HW requirement in the
>> >> > get_edid_block func pointer passed to drm_do_get_edid(). This
>> >> > would, however, result in more i2c reads (equal to # of extension
>> >> > blocks) than what the patch currently does.
>> >> >
>> >> > Peter, if you think doing extra EDID reads isn't too costly on your
>> >> > platform, you could consider using drm_do_get_edid(). If not, I guess
>> >> > you'll miss out on the additional functionality Jani is going to add
>> >>
>> >> > in the future.
>> >>
>> >> My concern is that for almost one year now, every time I fix something
>> >> one or two new requests are made. I'm happy to fix the driver, but I
>> >> want a list of the changes that are required to get it upstream, before
>> >> I make more changes. Can we agree on exactly what is preventing this
>> >> driver to get upstream? Then I'll fix it.
>> >
>> > I think addressing this edid reading question post-merge is perfectly
>> > fine. Aside, want to keep maintaing your stuff as part of the drm-misc
>> > group, with the drivers-in-misc experiment?
>>
>> Wasn't there some entry level for people ? It's not like Peter is
>> thick or anything, just that he has not reviewed or replied (afaict)
>
>> to any patches, even on ones where he was explicitly cc'd.
>> Although he's got dozens of contributions elsewhere, there's only a
>> single patch of his in DRM.
>
> "Any" is an exaggeration. See:
>
> c6c1f9bc798bee7cf
> ...
> Tested-by: Peter Senna Tschudin <peter.senna@gmail.com>
>
> Even if my involvement with drm started with my driver last year, I took my personal time to report this issue, and to test multiple iterations of the fix. Then my "single patch in DRM" involved some work to get it right, and it is something, that made imx-ldb better by adding a feature it did not support before.
>
> You made me curious. Can you point to the explicit cases where Peter "has not reviewed or replied to any patches, even on ones where he was explicitly cc'd"? And can you list case by case your take on why I should have done differently?
>
> Also it is not clear to me what the problem really is here. I'm assuming is not me, but if I was qualified from your perspective then would be no problem, right?
>
Ok seems like my wording came out, rather off.

Peter, as mentioned on IRC my messages is not aimed to be picking on
you in the slightest way. Pardon if it came as such.

It had two main points:
 - Daniel, gents - is drm-misc aimed at devs with limited (no?)
review/commit history in the area and/or the kernel in general ?
In this case, Peter have quite noticeable experience [in kernel
development] with little-to no in DRM.
Should one draw a line in the sand somewhere ?

 - You patch has been on a long [bit rocky road] for a while, with
devs giving you [what seems like] a partial reviews.
Have you considered reviewing others' patches in exchange for a [more
complete one] of this one ? According to git log people have poked you
a handful of times, but seemingly you were busy.

Note that neither of the above is supposed to belittle individuals or
the group maintainer model of drm-misc, but to point out what may not
seem obvious.

Regards,
Emil
