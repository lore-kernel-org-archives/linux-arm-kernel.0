From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 12 Jul 2018 18:38:21 +0200
Subject: [PATCH 1/9] CHROMIUM: v4l: Add H264 low-level decoder API
 compound controls.
In-Reply-To: <9c80de4e-c070-1051-2089-2d53826c6fc7@xs4all.nl>
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
 <20180613140714.1686-2-maxime.ripard@bootlin.com>
 <9c80de4e-c070-1051-2089-2d53826c6fc7@xs4all.nl>
Message-ID: <20180712163821.np57u46m7akpubht@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

Thanks for your feedback, I have a few things I'm not really sure
about though.

On Fri, Jun 15, 2018 at 01:59:58PM +0200, Hans Verkuil wrote:
> > +struct v4l2_ctrl_h264_sps {
> > +	__u8 profile_idc;
> > +	__u8 constraint_set_flags;
> > +	__u8 level_idc;
> > +	__u8 seq_parameter_set_id;
> > +	__u8 chroma_format_idc;
> > +	__u8 bit_depth_luma_minus8;
> > +	__u8 bit_depth_chroma_minus8;
> > +	__u8 log2_max_frame_num_minus4;
> > +	__u8 pic_order_cnt_type;
> > +	__u8 log2_max_pic_order_cnt_lsb_minus4;
> 
> There is a hole in the struct here. Is that OK? Are there alignment
> requirements?

This structure represents an equivalent structure in the H264
bitstream, but it's not a 1:1 mapping, so I don't think there's any
alignment issues.

As of the padding, is it an issue? Isn't it defined by the ABI, and
therefore the userspace will have the same padding rules?

> 
> > +	__s32 offset_for_non_ref_pic;
> > +	__s32 offset_for_top_to_bottom_field;
> > +	__u8 num_ref_frames_in_pic_order_cnt_cycle;
> > +	__s32 offset_for_ref_frame[255];
> 
> Perhaps use a define instead of hardcoding 255? Not sure if that makes sense.
> Same for other arrays below.
> 
> > +	__u8 max_num_ref_frames;
> > +	__u16 pic_width_in_mbs_minus1;
> > +	__u16 pic_height_in_map_units_minus1;
> > +	__u8 flags;
> > +};
> 
> You have to test the struct layout for 32 bit and 64 bit systems
> (the latter for both 64 bit arm and Intel). The layout should be the
> same for all of them since the control framework does not support
> compat32 conversions for compound controls.

I'm not really sure how to test that though? Should I write a program
doing a bunch of offset_of calls to make sure it matches by hand, or
is there anything smarter?

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
