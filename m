From: tfiga@chromium.org (Tomasz Figa)
Date: Wed, 10 Oct 2018 17:33:52 +0900
Subject: [PATCH 1/2] media: v4l: Add definitions for the HEVC slice format
 and controls
In-Reply-To: <20180828080240.10982-2-paul.kocialkowski@bootlin.com>
References: <20180828080240.10982-1-paul.kocialkowski@bootlin.com>
 <20180828080240.10982-2-paul.kocialkowski@bootlin.com>
Message-ID: <CAAFQd5An1htKNpNJmwHAzw6Oz+Z=T_MuBg+T=_yMbT7SkkokBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Tue, Aug 28, 2018 at 5:02 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> This introduces the required definitions for HEVC decoding support with
> stateless VPUs. The controls associated to the HEVC slice format provide
> the required meta-data for decoding slices extracted from the bitstream.
>

Sorry for being late to the party. Please see my comments inline. Only
high level, because I don't know too much about HEVC.

[snip]
> +``V4L2_CID_MPEG_VIDEO_HEVC_SPS (struct)``
> +    Specifies the Sequence Parameter Set fields (as extracted from the
> +    bitstream) for the associated HEVC slice data.
> +    The bitstream parameters are defined according to the ISO/IEC 23008-2 and
> +    ITU-T Rec. H.265 specifications.
> +
> +.. c:type:: v4l2_ctrl_hevc_sps
> +
> +.. cssclass:: longtable
> +
> +.. flat-table:: struct v4l2_ctrl_hevc_sps
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       1 1 2
> +
> +    * - __u8
> +      - ``chroma_format_idc``
> +      - Syntax description inherited from the specification.

I wonder if it wouldn't make sense to instead document this in C code
using kernel-doc and then have the kernel-doc included in the sphinx
doc. It seems to be possible, according to
https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html .

Such approach would have the advantage of the person looking through C
cross reference being able to actually see the documentation of the
struct in question and also making it easier to ensure the relevant C
code and documentation are in sync. (Although this is UAPI so it would
be unlikely to change too often or at all.)

[snip]
> +``V4L2_CID_MPEG_VIDEO_HEVC_SLICE_PARAMS (struct)``
> +    Specifies various slice-specific parameters, especially from the NAL unit
> +    header, general slice segment header and weighted prediction parameter
> +    parts of the bitstream.
> +    The bitstream parameters are defined according to the ISO/IEC 23008-2 and
> +    ITU-T Rec. H.265 specifications.

In the Chromium H.264 controls, we define this as an array control, so
that we can include multiple slices in one buffer and each entry of
the array has an offset field pointing to the part of the buffer that
contains corresponding slice data. I've mentioned this in the
discussion on Alex's stateless decoder interface documentation, so
let's keep the discussion there, though.

[snip]
> @@ -1696,6 +1708,11 @@ static int std_validate(const struct v4l2_ctrl *ctrl, u32 idx,
>         case V4L2_CTRL_TYPE_H264_DECODE_PARAMS:
>                 return 0;
>
> +       case V4L2_CTRL_TYPE_HEVC_SPS:
> +       case V4L2_CTRL_TYPE_HEVC_PPS:
> +       case V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS:
> +               return 0;
> +

I wonder to what extent we should be validating this. I can see 3 options:
1) Defer validation to drivers completely. - Potentially error prone
and leading to a lot of code duplication?
2) Validate completely. - Might need solving some interesting
problems, e.g. validating reference frame indices in DPB against
current state of respective VB2 queue...
3) Validate only what we can easily do, defer more complicated
validation to the drivers. - Potentially a good middle ground?

Best regards,
Tomasz
