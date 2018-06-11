From: keiichiw@google.com (Keiichi Watanabe)
Date: Mon, 11 Jun 2018 15:44:37 +0900
Subject: [PATCH v2 1/2] media: v4l2-ctrl: Add control for VP9 profile
In-Reply-To: <CAKQmDh8MnArB1jCD6STh9FgLX+H4ZsEnH+coOJe-4A=FNPGshA@mail.gmail.com>
References: <20180530071613.125768-1-keiichiw@chromium.org>
 <20180530071613.125768-2-keiichiw@chromium.org>
 <a16dca32-4198-72c1-cf22-83f18a8cfcb6@xs4all.nl>
 <bd56e330-91d2-dfde-4cfb-40b466953dad@linaro.org>
 <CAKQmDh8MnArB1jCD6STh9FgLX+H4ZsEnH+coOJe-4A=FNPGshA@mail.gmail.com>
Message-ID: <CANb2CJFXhY+mzEV7AnM5EQcvqyeAH7G=t3Bi_9_d9_+_Kce9RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Hans.
Thank you for the review.
Your idea sounds good.

However, I think that changing V4L2_CID_MPEG_VIDEO_VPX_PROFILE to an enum
breaks both of s5p-mfc and venus drivers.  This is because they call
'v4l2_ctrl_new_std' for it.  For menu controls,
'v4l2_ctrl_new_std_menu' must be used.

https://elixir.bootlin.com/linux/latest/source/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c#L2678
https://elixir.bootlin.com/linux/latest/source/drivers/media/platform/qcom/venus/vdec_ctrls.c#L133

I can fix them within the commit for adding VP8_PROFILE control, but
cannot confirm that it works on real devices since I don't have them.
What should I do?

Best regards,
Keiichi
On Fri, Jun 8, 2018 at 10:00 PM Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
>
>
>
> Le ven. 8 juin 2018 08:56, Stanimir Varbanov <stanimir.varbanov@linaro.org> a ?crit :
>>
>> Hi Hans,
>>
>> On 06/08/2018 12:29 PM, Hans Verkuil wrote:
>> > On 05/30/2018 09:16 AM, Keiichi Watanabe wrote:
>> >> Add a new control V4L2_CID_MPEG_VIDEO_VP9_PROFILE for selecting desired
>> >> profile for VP9 encoder and querying for supported profiles by VP9 encoder
>> >> or decoder.
>> >>
>> >> An existing control V4L2_CID_MPEG_VIDEO_VPX_PROFILE cannot be
>> >> used for querying since it is not a menu control but an integer
>> >> control, which cannot return an arbitrary set of supported profiles.
>> >>
>> >> The new control V4L2_CID_MPEG_VIDEO_VP9_PROFILE is a menu control as
>> >> with controls for other codec profiles. (e.g. H264)
>> >
>> > Please ignore my reply to patch 2/2. I looked at this a bit more and what you
>> > should do is to change the type of V4L2_CID_MPEG_VIDEO_VPX_PROFILE to enum.
>> >
>> > All other codec profile controls are all enums, so the fact that VPX_PROFILE
>> > isn't is a bug. Changing the type should not cause any problems since the same
>> > control value is used when you set the control.
>> >
>> > Sylwester: I see that s5p-mfc uses this control, but it is explicitly added
>> > as an integer type control, so the s5p-mfc driver should not be affected by
>> > changing the type of this control.
>> >
>> > Stanimir: this will slightly change the venus driver, but since it is a very
>> > recent driver I think we can get away with changing the core type of the
>> > VPX_PROFILE control. I think that's better than ending up with two controls
>> > that do the same thing.
>>
>> I agree. Actually the changes shouldn't be so much in venus driver.
>
>
> Also fine on userspace side, since profiles enumeration isn't implemented yet in FFMPEG, GStreamer, Chrome
>
>
>>
>> --
>> regards,
>> Stan
