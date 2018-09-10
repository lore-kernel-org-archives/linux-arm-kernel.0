From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Mon, 10 Sep 2018 12:33:52 +0200
Subject: [PATCH v9 2/9] media: v4l: Add definitions for MPEG-2 slice
 format and metadata
In-Reply-To: <2409ba6607e85acf3dbbaed394487fa8e92d93df.camel@paulk.fr>
References: <20180906222442.14825-1-contact@paulk.fr>
 <20180906222442.14825-3-contact@paulk.fr>
 <9a7fd34d-50e3-4db6-4752-9e62bb160655@xs4all.nl>
 <2409ba6607e85acf3dbbaed394487fa8e92d93df.camel@paulk.fr>
Message-ID: <bd6dd135-1719-2e25-051b-d15b1fe52d61@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/2018 11:47 AM, Paul Kocialkowski wrote:
> Hi,
> 
> Le lundi 10 septembre 2018 ? 11:41 +0200, Hans Verkuil a ?crit :
>> On 09/07/2018 12:24 AM, Paul Kocialkowski wrote:
>>> From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>>>
>>> Stateless video decoding engines require both the MPEG-2 slices and
>>> associated metadata from the video stream in order to decode frames.
>>>
>>> This introduces definitions for a new pixel format, describing buffers
>>> with MPEG-2 slice data, as well as control structure sfor passing the
>>> frame metadata to drivers.
>>>
>>> This is based on work from both Florent Revest and Hugues Fruchet.
>>>
>>> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>>> ---
>>>  .../media/uapi/v4l/extended-controls.rst      | 176 ++++++++++++++++++
>>>  .../media/uapi/v4l/pixfmt-compressed.rst      |  16 ++
>>>  .../media/uapi/v4l/vidioc-queryctrl.rst       |  14 +-
>>>  .../media/videodev2.h.rst.exceptions          |   2 +
>>>  drivers/media/v4l2-core/v4l2-ctrls.c          |  63 +++++++
>>>  drivers/media/v4l2-core/v4l2-ioctl.c          |   1 +
>>>  include/media/v4l2-ctrls.h                    |  18 +-
>>>  include/uapi/linux/v4l2-controls.h            |  65 +++++++
>>>  include/uapi/linux/videodev2.h                |   5 +
>>>  9 files changed, 351 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/Documentation/media/uapi/v4l/extended-controls.rst b/Documentation/media/uapi/v4l/extended-controls.rst
>>> index 9f7312bf3365..f1951236266a 100644
>>> --- a/Documentation/media/uapi/v4l/extended-controls.rst
>>> +++ b/Documentation/media/uapi/v4l/extended-controls.rst
>>> @@ -1497,6 +1497,182 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type -
>>>  
>>>  
>>>  
>>> +.. _v4l2-mpeg-mpeg2:
>>> +
>>> +``V4L2_CID_MPEG_VIDEO_MPEG2_SLICE_PARAMS (struct)``
>>> +    Specifies the slice parameters (as extracted from the bitstream) for the
>>> +    associated MPEG-2 slice data. This includes the necessary parameters for
>>> +    configuring a stateless hardware decoding pipeline for MPEG-2.
>>> +    The bitstream parameters are defined according to :ref:`mpeg2part2`.
>>> +
>>> +.. c:type:: v4l2_ctrl_mpeg2_slice_params
>>> +
>>> +.. cssclass:: longtable
>>> +
>>> +.. flat-table:: struct v4l2_ctrl_mpeg2_slice_params
>>> +    :header-rows:  0
>>> +    :stub-columns: 0
>>> +    :widths:       1 1 2
>>> +
>>> +    * - __u32
>>> +      - ``bit_size``
>>> +      - Size (in bits) of the current slice data.
>>> +    * - __u32
>>> +      - ``data_bit_offset``
>>> +      - Offset (in bits) to the video data in the current slice data.
>>> +    * - struct :c:type:`v4l2_mpeg2_sequence`
>>> +      - ``sequence``
>>> +      - Structure with MPEG-2 sequence metadata, merging relevant fields from
>>> +	the sequence header and sequence extension parts of the bitstream.
>>> +    * - struct :c:type:`v4l2_mpeg2_picture`
>>> +      - ``picture``
>>> +      - Structure with MPEG-2 picture metadata, merging relevant fields from
>>> +	the picture header and picture coding extension parts of the bitstream.
>>> +    * - __u8
>>> +      - ``quantiser_scale_code``
>>> +      - Code used to determine the quantization scale to use for the IDCT.
>>> +    * - __u8
>>> +      - ``backward_ref_index``
>>> +      - Index for the V4L2 buffer to use as backward reference, used with
>>> +	B-coded and P-coded frames.
>>> +    * - __u8
>>> +      - ``forward_ref_index``
>>> +      - Index for the V4L2 buffer to use as forward reference, used with
>>> +	P-coded frames.
>>
>> Should this be "B-coded frames"?
> 
> Oops, that's right, B-coded frames.
> 
> Should I make a follow-up patch for that (maybe gathered with other
> changes if required)?

Follow-up patches, please. All on top of my last pull request that adds the
cedrus driver.

Regards,

	Hans
