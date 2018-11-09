From: nicolas@ndufresne.ca (Nicolas Dufresne)
Date: Fri, 09 Nov 2018 16:21:35 -0500
Subject: [PATCH v4 2/3] media: meson: add v4l2 m2m video decoder driver
In-Reply-To: <2f88a17d-76f8-ec70-c18f-aa0d688249be@xs4all.nl>
References: <20181106075926.19269-1-mjourdan@baylibre.com>
 <20181106075926.19269-3-mjourdan@baylibre.com>
 <2f88a17d-76f8-ec70-c18f-aa0d688249be@xs4all.nl>
Message-ID: <0841fd86ea9bf52057e2a4622a7b9719662cc484.camel@ndufresne.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le jeudi 08 novembre 2018 ? 09:42 +0100, Hans Verkuil a ?crit :
> > +static int vdec_queue_setup(struct vb2_queue *q,
> > +             unsigned int *num_buffers, unsigned int *num_planes,
> > +             unsigned int sizes[], struct device *alloc_devs[])
> > +{
> > +     struct amvdec_session *sess = vb2_get_drv_priv(q);
> > +     const struct amvdec_format *fmt_out = sess->fmt_out;
> > +     u32 output_size = amvdec_get_output_size(sess);
> > +     u32 buffers_total;
> > +
> > +     if (*num_planes) {
> 
> If you are not supporting create_bufs, then you can drop this part.
> Without create_bufs you can assume that *num_planes == 0 and
> q->num_buffers == 0.
> 
> You should add a comment here mentioning that create_bufs isn't
> supported by this driver and explain why it isn't supported.
> 
> I understand it is due to gstreamer problems, but the explanation
> in your cover letter didn't say why it is a problem with this driver
> but not other drivers (apparently).

There is problems in GStreamer with this, but it was disabled because
the firmware does not really allow adding buffers at run-time. Worst,
we would often seen kernel crash when this was enabled.

No decoder before this one implements CREATE_BUFS from what I'm aware,
which explain why I never catched the GStreamer issues before.

Nicolas
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181109/aa1c319e/attachment.sig>
