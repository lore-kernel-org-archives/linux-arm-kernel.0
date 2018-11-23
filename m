From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 11:35:55 +0100
Subject: [PATCH 1/2] media: v4l: Add definitions for the HEVC slice
 format and controls
In-Reply-To: <CAAFQd5An1htKNpNJmwHAzw6Oz+Z=T_MuBg+T=_yMbT7SkkokBw@mail.gmail.com>
References: <20180828080240.10982-1-paul.kocialkowski@bootlin.com>
 <20180828080240.10982-2-paul.kocialkowski@bootlin.com>
 <CAAFQd5An1htKNpNJmwHAzw6Oz+Z=T_MuBg+T=_yMbT7SkkokBw@mail.gmail.com>
Message-ID: <6faa1471b1c3c1ea80e6576b0e29950bcca47614.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2018-10-10 at 17:33 +0900, Tomasz Figa wrote:
> Hi Paul,
> 
> On Tue, Aug 28, 2018 at 5:02 PM Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> > This introduces the required definitions for HEVC decoding support with
> > stateless VPUs. The controls associated to the HEVC slice format provide
> > the required meta-data for decoding slices extracted from the bitstream.
> > 
> 
> Sorry for being late to the party. Please see my comments inline. Only
> high level, because I don't know too much about HEVC.
> 
> [snip]
> > +``V4L2_CID_MPEG_VIDEO_HEVC_SPS (struct)``
> > +    Specifies the Sequence Parameter Set fields (as extracted from the
> > +    bitstream) for the associated HEVC slice data.
> > +    The bitstream parameters are defined according to the ISO/IEC 23008-2 and
> > +    ITU-T Rec. H.265 specifications.
> > +
> > +.. c:type:: v4l2_ctrl_hevc_sps
> > +
> > +.. cssclass:: longtable
> > +
> > +.. flat-table:: struct v4l2_ctrl_hevc_sps
> > +    :header-rows:  0
> > +    :stub-columns: 0
> > +    :widths:       1 1 2
> > +
> > +    * - __u8
> > +      - ``chroma_format_idc``
> > +      - Syntax description inherited from the specification.
> 
> I wonder if it wouldn't make sense to instead document this in C code
> using kernel-doc and then have the kernel-doc included in the sphinx
> doc. It seems to be possible, according to
> https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html .
> 
> Such approach would have the advantage of the person looking through C
> cross reference being able to actually see the documentation of the
> struct in question and also making it easier to ensure the relevant C
> code and documentation are in sync. (Although this is UAPI so it would
> be unlikely to change too often or at all.)

I have somewhat mixed feelings about this. I believe we should be
keeping the video codec control structures as close as we can to the
codec specs (and in the case of H.265, most of the fields are directly
inherited from the spec). So for most of them, the documentation
wouldn't be in the kernel docs but in the spec itself. From that
perspective, it doesn't really help much to move the documentation in
the headers.

> [snip]
> > +``V4L2_CID_MPEG_VIDEO_HEVC_SLICE_PARAMS (struct)``
> > +    Specifies various slice-specific parameters, especially from the NAL unit
> > +    header, general slice segment header and weighted prediction parameter
> > +    parts of the bitstream.
> > +    The bitstream parameters are defined according to the ISO/IEC 23008-2 and
> > +    ITU-T Rec. H.265 specifications.
> 
> In the Chromium H.264 controls, we define this as an array control, so
> that we can include multiple slices in one buffer and each entry of
> the array has an offset field pointing to the part of the buffer that
> contains corresponding slice data. I've mentioned this in the
> discussion on Alex's stateless decoder interface documentation, so
> let's keep the discussion there, though.

Yes definitely. Out current proposals (for H.264 and H.265) still
require "as many macroblocks as needed for a full frame", but we should
definitely move away from that as discussed in the thread you
mentionned. I think this is something we should aim for before declaring
the API as stable.

> [snip]
> > @@ -1696,6 +1708,11 @@ static int std_validate(const struct v4l2_ctrl *ctrl, u32 idx,
> >         case V4L2_CTRL_TYPE_H264_DECODE_PARAMS:
> >                 return 0;
> > 
> > +       case V4L2_CTRL_TYPE_HEVC_SPS:
> > +       case V4L2_CTRL_TYPE_HEVC_PPS:
> > +       case V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS:
> > +               return 0;
> > +
> 
> I wonder to what extent we should be validating this. I can see 3 options:
> 1) Defer validation to drivers completely. - Potentially error prone
> and leading to a lot of code duplication?
> 2) Validate completely. - Might need solving some interesting
> problems, e.g. validating reference frame indices in DPB against
> current state of respective VB2 queue...
> 3) Validate only what we can easily do, defer more complicated
> validation to the drivers. - Potentially a good middle ground?

I definitely agree with you that option 1 is not really desirable, for
the reasons you mentionned.

I would tend to back option 3 with the following suggestion: we should
validate controls for "syntax" (that is, checking that the bitstream
fields take values permitted by the spec) when they are submitted and
leave it up to the driver to deal with requirements on other frames
(validity of the DPB). I don't think we can validate the availability of
reference frames at control submission time anyway since it would be
valid to queue and set controls for frames in reverse decoding order.

What do you think?

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181123/770a1844/attachment.sig>
