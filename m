From: tfiga@chromium.org (Tomasz Figa)
Date: Mon, 6 Aug 2018 23:10:40 +0900
Subject: [PATCH v6 4/8] media: platform: Add Cedrus VPU decoder driver
In-Reply-To: <dba0f9496b393c76f355398018b14ae06b2b18c9.camel@bootlin.com>
References: <20180725100256.22833-1-paul.kocialkowski@bootlin.com>
 <20180725100256.22833-5-paul.kocialkowski@bootlin.com>
 <b45a8a89-1313-7a08-206d-b93017724754@xs4all.nl>
 <dba0f9496b393c76f355398018b14ae06b2b18c9.camel@bootlin.com>
Message-ID: <CAAFQd5DgFDFupACthsz1iLpAeYRtUtEfzQC1E5XZQ6gPZAYi1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Mon, Aug 6, 2018 at 10:50 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Hi Hans and thanks for the review!
>
> On Sat, 2018-08-04 at 14:18 +0200, Hans Verkuil wrote:
> > Hi Paul,
> >
> > See below for my review comments. Mostly small fry, the main issue I found is
> > that there is no support for VIDIOC_DECODER_CMD. That's the proper way of
> > stopping a decoder. Don't rely on the deprecated allow_zero_bytesused field.
>
> Mhh, it looks like this was kept around by negligence, but we do expect
> that streamoff stops the decoder, not a zero bytesused field.
>
> Is it still required to implement the V4L2_DEC_CMD_STOP
> VIDIOC_DECODER_CMD in that case? I read in the doc that this ioctl
> should be optional.

If I understand correctly that this decoder is stateless, there should
be no need for any special flush sequence, since a 1:1 relation
between OUTPUT and CAPTURE buffers is expected, which means that
userspace can just stop queuing new OUTPUT buffers and keep dequeuing
CAPTURE buffers until it matches all OUTPUT buffers queued before.

By the way, I guess we will also need some documentation for the
stateless codec interface. Do you or Maxime (who sent the H264 part)
have any plans to work on it? We have some internal documents, which
should be convertible to rst using pandoc, but we might need some help
with updating to latest request API and further editing. Alexandre
(moved from Cc to To) is going to be looking into this.

Best regards,
Tomasz
