From: ykk@rock-chips.com (Yakir Yang)
Date: Tue, 19 Jan 2016 11:50:29 +0800
Subject: [PATCH v4] drm/rockchip: hdmi: add Innosilicon HDMI support
In-Reply-To: <20160118171514.GG19062@n2100.arm.linux.org.uk>
References: <1453128123-29155-1-git-send-email-ykk@rock-chips.com>
 <1453128140-29208-1-git-send-email-ykk@rock-chips.com>
 <20160118171514.GG19062@n2100.arm.linux.org.uk>
Message-ID: <569DB285.1000009@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Thanks for your comments :-D

On 01/19/2016 01:15 AM, Russell King - ARM Linux wrote:
> Hi,
>
> Some comments below...
>
> On Mon, Jan 18, 2016 at 10:42:20PM +0800, Yakir Yang wrote:
>> +static int inno_hdmi_config_video_avi(struct inno_hdmi *hdmi)
>> +{
>> +	char info[HDMI_SIZE_AVI_INFOFRAME] = {0};
>> +	int avi_color_mode;
>> +	int i;
>> +
>> +	hdmi_writeb(hdmi, HDMI_CONTROL_PACKET_BUF_INDEX, INFOFRAME_AVI);
>> +
>> +	info[0] = 0x82;
>> +	info[1] = 0x02;
>> +	info[2] = 0x0D;
>> +	info[3] = info[0] + info[1] + info[2];
>> +
>> +	if (hdmi->hdmi_data.enc_out_format == HDMI_COLORSPACE_RGB)
>> +		avi_color_mode = AVI_COLOR_MODE_RGB;
>> +	else if (hdmi->hdmi_data.enc_out_format == HDMI_COLORSPACE_YUV444)
>> +		avi_color_mode = AVI_COLOR_MODE_YCBCR444;
>> +	else if (hdmi->hdmi_data.enc_out_format == HDMI_COLORSPACE_YUV422)
>> +		avi_color_mode = AVI_COLOR_MODE_YCBCR422;
>> +	else
>> +		avi_color_mode = AVI_COLOR_MODE_RGB;
>> +
>> +	info[4] = (avi_color_mode << 5);
>> +	info[5] = (AVI_COLORIMETRY_NO_DATA << 6) |
>> +		  (AVI_CODED_FRAME_ASPECT_NO_DATA << 4) |
>> +		  ACTIVE_ASPECT_RATE_SAME_AS_CODED_FRAME;
>> +
>> +	info[6] = 0;
>> +	info[7] = hdmi->hdmi_data.vic;
>> +
>> +	if (hdmi->hdmi_data.vic == 6 || hdmi->hdmi_data.vic == 7 ||
>> +	    hdmi->hdmi_data.vic == 21 || hdmi->hdmi_data.vic == 22)
>> +		info[8] = 1;
>> +	else
>> +		info[8] = 0;
>> +
>> +	/* Calculate avi info frame checKsum */
>> +	for (i = 4; i < HDMI_SIZE_AVI_INFOFRAME; i++)
>> +		info[3] += info[i];
>> +	info[3] = 0x100 - info[3];
>> +
>> +	for (i = 0; i < HDMI_SIZE_AVI_INFOFRAME; i++)
>> +		hdmi_writeb(hdmi, HDMI_CONTROL_PACKET_ADDR + i, info[i]);
>> +
>> +	return 0;
> Is there a reason why the helpers in drivers/video/hdmi.c can't be used
> to generate this?
>
> hdmi_avi_infoframe_init / hdmi_avi_infoframe_pack and
> drm_hdmi_avi_infoframe_from_display_mode ?

Great, thanks for point out, it would make code much clean with those 
helper functions.

>> +}
>> +
>> +static int inno_hdmi_config_video_vsi(struct inno_hdmi *hdmi)
>> +{
>> +	char info[HDMI_SIZE_VSI_INFOFRAME] = {0};
>> +	int i;
>> +
>> +	hdmi_modb(hdmi, HDMI_PACKET_SEND_AUTO, m_PACKET_VSI_EN,
>> +		  v_PACKET_VSI_EN(0));
>> +
>> +	hdmi_writeb(hdmi, HDMI_CONTROL_PACKET_BUF_INDEX, INFOFRAME_VSI);
>> +
>> +	/* Header Bytes */
>> +	info[0] = 0x81;
>> +	info[1] = 0x01;
>> +
>> +	/* PB1 - PB3 contain the 24bit IEEE Registration Identifier */
>> +	info[4] = 0x03;
>> +	info[5] = 0x0c;
>> +	info[6] = 0x00;
>> +
>> +	/* PB4 - HDMI_Video_Format into bits 7:5 */
>> +	info[7] = 0;
>> +
>> +	/*
>> +	 * PB5 - Depending on the video format, this byte will contain
>> +	 * either the HDMI_VIC code in buts 7:0, OR the 3D_Structure in
>> +	 * bits 7:4.
>> +	 */
>> +	info[2] = 0x06 - 2;
>> +	info[8] = 0;
>> +	info[9] = 0;
>> +
>> +	info[3] = info[0] + info[1] + info[2];
>> +
>> +	/* Calculate info frame checKsum */
>> +	for (i = 4; i < HDMI_SIZE_VSI_INFOFRAME; i++)
>> +		info[3] += info[i];
>> +	info[3] = 0x100 - info[3];
>> +
>> +	for (i = 0; i < HDMI_SIZE_VSI_INFOFRAME; i++)
>> +		hdmi_writeb(hdmi, HDMI_CONTROL_PACKET_ADDR + i, info[i]);
>> +
>> +	hdmi_modb(hdmi, HDMI_PACKET_SEND_AUTO, m_PACKET_VSI_EN,
>> +		  v_PACKET_VSI_EN(1));
>> +
>> +	return 0;
> hdmi_vendor_infoframe_init / hdmi_vendor_infoframe_pack?
>
> You can probably use the same function to upload the control packet
> too - something like:
>
> static int inno_hdmi_upload_frame(struct inno_hdmi *hdmi, int setup_rc,
> 	union hdmi_infoframe *frame, u32 mask, u32 disable, u32 enable)
> {
> 	if (mask)
> 		hdmi_modb(hdmi, HDMI_PACKET_SEND_AUTO, mask, disable);
>
> 	if (setup_rc >= 0) {
> 		u8 packed_frame[YOUR_MAXIMUM_INFO_FRAME_SIZE];
> 		ssize_t rc, i;
>
> 		rc = hdmi_infoframe_pack(frame, packed_frame,
> 					 sizeof(packed_frame));
> 		if (rc < 0)
> 			return rc;
>
> 		for (i = 0; i < rc; i++)
> 			hdmi_writeb(hdmi, HDMI_CONTROL_PACKET_ADDR + i, buf[i]);
>
> 		if (mask)
> 			hdmi_modb(hdmi, HDMI_PACKET_SEND_AUTO, mask, enable);
> 	}
>
> 	return setup_rc;
> }
>
> static int inno_hdmi_config_video_vsi(struct inno_hdmi *hdmi)
> {
> 	union hdmi_infoframe frame;
>
> 	rc = drm_hdmi_vendor_infoframe_from_display_mode(&frame.vendor.hdmi,
> 							 the_drm_display_mode);
>
> 	return inno_hdmi_upload_frame(hdmi, rc, &frame, m_PACKET_VSI_EN,
> 				      v_PACKET_VSI_EN(0), v_PACKET_VSI_EN(1));
> }
>

Ah.... appreciate for the code,  it's great suggest, thanks.

Also I found a mistaken with previous "inno_hdmi_config_video_vsi"
function that we don't need to send the HDMI vendor infoframes if
we are not using a 4K or stereoscopic 3D mode.  :)

>> +static int inno_hdmi_i2c_wait(struct inno_hdmi *hdmi)
>> +{
>> +	struct inno_hdmi_i2c *i2c = hdmi->i2c;
>> +	int stat;
>> +
>> +	stat = wait_for_completion_timeout(&i2c->cmp, HZ / 10);
>> +	if (!stat) {
>> +		stat = wait_for_completion_timeout(&i2c->cmp, HZ / 10);
>> +		if (!stat)
>> +			return -EAGAIN;
> What's the reason for this double wait_for_completion?  This probably
> needs a comment, otherwise it looks like some weird cut-n-paste error.

Yep, you 're right, don't need double wait here.

>> +static int inno_hdmi_i2c_write(struct inno_hdmi *hdmi, struct i2c_msg *msgs)
>> +{
>> +	struct inno_hdmi_i2c *i2c = hdmi->i2c;
> You seem to have a local i2c pointer...
Ah, got it  ;)
>> +
>> +	/*
>> +	 * The DDC module only support read EDID message, so
>> +	 * we assume that each word write to this i2c adapter
>> +	 * should be the offset of EDID word address.
>> +	 */
>> +	if ((msgs->len != 1) ||
>> +	    ((msgs->addr != DDC_ADDR) && (msgs->addr != DDC_SEGMENT_ADDR)))
>> +		return -EINVAL;
>> +
>> +	reinit_completion(&i2c->cmp);
>> +
>> +	if (msgs->addr == DDC_SEGMENT_ADDR)
>> +		hdmi->i2c->segment_addr = msgs->buf[0];
>> +	if (msgs->addr == DDC_ADDR)
>> +		hdmi->i2c->ddc_addr = msgs->buf[0];
>> +
>> +	/* Set edid fifo first addr */
>> +	hdmi_writeb(hdmi, HDMI_EDID_FIFO_OFFSET, 0x00);
>> +
>> +	/* Set edid word address 0x00/0x80 */
>> +	hdmi_writeb(hdmi, HDMI_EDID_WORD_ADDR, hdmi->i2c->ddc_addr);
>> +
>> +	/* Set edid segment pointer */
>> +	hdmi_writeb(hdmi, HDMI_EDID_SEGMENT_POINTER, hdmi->i2c->segment_addr);
> but then you don't use it in the four locations above.
>
>

Thanks,
- Yakir
