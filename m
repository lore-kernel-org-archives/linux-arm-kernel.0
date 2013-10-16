From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Wed, 16 Oct 2013 14:03:17 -0700
Subject: [PATCH v2 1/3] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <20131016202750.GK25034@n2100.arm.linux.org.uk>
References: <1380826287-30253-1-git-send-email-fabio.estevam@freescale.com>
 <20131003202751.GZ6192@mwanda>
 <20131015131038.GB25034@n2100.arm.linux.org.uk>
 <CAOMZO5BDEFAKue9b94+wCQSk+1V04P9Oz_yrqG5XLZ532L+VUg@mail.gmail.com>
 <20131016170341.GH25034@n2100.arm.linux.org.uk>
 <525EEB06.6080009@boundarydevices.com>
 <20131016202750.GK25034@n2100.arm.linux.org.uk>
Message-ID: <525EFF15.2010007@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16/2013 1:27 PM, Russell King - ARM Linux wrote:
> On Wed, Oct 16, 2013 at 12:37:42PM -0700, Troy Kisky wrote:
>> On 10/16/2013 10:03 AM, Russell King - ARM Linux wrote:
>>> On Tue, Oct 15, 2013 at 10:17:07AM -0300, Fabio Estevam wrote:
>>>> On Tue, Oct 15, 2013 at 10:10 AM, Russell King - ARM Linux
>>>> <linux@arm.linux.org.uk> wrote:
>>>>> Another point on patch 1.  Sorry, I don't have patch 1 to reply to, it
>>>>> seems it was deleted from linux-arm-kernel's moderation queue.
>>>>>
>>>>> drm_mode_connector_attach_encoder() is called too early, before the
>>>>> base.id field in the encoder has been initialised.  This causes the
>>>>> connectors encoder array to be empty, and userspace KMS to fail.
>>>>>
>>>>> There's also bugs in the CSC setting too - it runs off the end of the
>>>>> array and gcc warns about this.  The code was clearly wrong.
>>>>>
>>>>> You may wish to combine this patch with patch 1 to sort all that out.
>>>>> For the patch below:
>>>>>
>>>>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>>>>> Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>
>>>> Thanks, Russell.
>>>>
>>>> Will submit v3 when I am back to the office.
>>> Okay, I still have a problem with HDMI: I have a magenta vertical line
>>> down the left hand side of the frame, the displayed frame is shifted
>>> right by the width of that line and the right hand side is missing some
>>> pixels.
>>>
>>> First off, the hsync position programmed into the HDMI registers appears
>>> to be wrong.
>>>
>>> I'm at a loss why imx-hdmi is obfuscated with a conversion from a
>>> drm_display_mode structure to a fb_videomode.  This adds additional
>>> confusion and additional opportunities for bugs; this is probably
>>> exactly why the hsync position is wrong.
>>>
>>> In CEA-861-B for 720p @60Hz:
>>>
>>> DE: ^^^^__________^^^^^^^
>>> HS: _______^^^___________
>>>            ^  ^  ^
>>>            |  |  220 clocks
>>>            |  40 clocks
>>>            110 clocks
>>>
>>> The IMX6 manual says HSYINCINDELAY0 is "Hsync active edge delay.  Integer
>>> number of pixel clock cycles from de non-active edge".  So, this should be
>>> 110.  Yet it ends up being programmed as 220, leading to a magenta vertical
>>> bar down the left hand side of the display.
>>>
>>> Now, if you look at Documentation/fb/framebuffer.txt, in this case, the
>>> right margin should be 110 clocks, hsync len should be 40 and the left
>>> margin should be 220 clocks.
>>>
>>> However, this is not what your conversion to a fb_videomode does.  It
>>> reverses the left and right margin.  A similar confusion also exists
>>> in the conversion of the upper/lower margins too.
>>>
>>> The DRM model is this (for 720p @60Hz):
>>>
>>> 0                             1280         1390 1430      1650
>>> |===============================|------------|---|----------|
>>> ^                               ^            ^   ^          ^
>>> start                       hdisplay hsync_start hsync_end htotal
>>>
>>> The fb model is the same as the above but rotated:
>>>
>>> left margin            displayed            right margin hsync_len
>>> |----------|===============================|------------|---|
>>>
>>> So, the left margin is the bit between hsync_end and htotal, and the
>>> right margin is the bit between hdisplay and hsync_start.  Exactly
>>> the same analysis applies to the upper/lower margins.
>>>
>>> What I suggest is that the use of fb_videomode is entirely killed off
>>> in this driver to remove this layer of confusion and instead the DRM
>>> model is stuck to within this DRM driver.
>>>
>>> Now on to the next problem.  HSYNC/VSYNC polarity.
>>>
>>> So, this is the mode which is set:
>>>
>>>     1280x720 (0x41)   74.2MHz +HSync +VSync *current +preferred
>>>           h: width  1280 start 1390 end 1430 total 1650 skew    0 clock   45.0KHz
>>>           v: height  720 start  725 end  730 total  750           clock   60.0Hz
>>>
>>> Note the positive HSync and VSync polarity - this is correct, backed
>>> up by CEA-861-B.
>>>
>>> The IPU DI0 is configured thusly in its general control register:
>>> 0x2640000 = 0x200006, which is what is set when the requested mode
>>> has DRM_MODE_FLAG_PHSYNC and DRM_MODE_FLAG_PVSYNC flags set.
>>>
>>> However, if we look at the HDMI config: 0x121000 = 0x18.  Active low
>>> hsync/vsync.  This is quite obvious when you look at the code -
>>> convert_to_video_timing() does *nothing* at all when converting the
>>> sync polarities, which means hdmi_av_composer() doesn't program them
>>> appropriately.  And yes, poking 0x78 into this register finally fixes
>>> the problem.
>>>
>>> Yet another reason why this silly conversion from one structure form
>>> to another is a Very Bad Idea.  Until I found this, I was merely going
>>> to send a patch to sort out convert_to_video_timing(), but quite frankly
>>> I'm going to kill this thing off right now.
>>>
>>> Another thing:
>>>
>>> static int imx_hdmi_setup(struct imx_hdmi *hdmi, struct drm_display_mode *mode)
>>> {
>>>           int ret;
>>>           convert_to_video_timing(&hdmi->fb_mode, mode);
>>>
>>>           hdmi_disable_overflow_interrupts(hdmi);
>>>                    hdmi->vic = 6;
>>>
>>> It's quite wrong to force every video mode set to be CEA mode 6.  IIRC,
>>> There is a function in DRM which will tell you the CEA mode number.
>>> Again, I'll fix this in my patch rewriting this bit of the driver to
>>> be correct.
>>>
>>> I'm also suspicious of the "HDMI Initialization Step" comments, because
>>> they make no sense:
>>>
>>> /* HDMI Initialization Step B.4 */
>>> static void imx_hdmi_enable_video_path(struct imx_hdmi *hdmi)
>>> {
>>>
>>> yet:
>>>
>>>           /* HDMI Initialization Step B.3 */
>>>           imx_hdmi_enable_video_path(hdmi);
>>>
>>> One's left wondering whether Step B.3 really is to just call a function
>>> with a particular name, but B.4 is to actually do something with the
>>> hardware.  I'm quite sure that if this is a documented procedure, that
>>> it doesn't say that and these comments are wrong (and probably the code
>>> too.)
>>>
>>> Even after all this, I still haven't got rid of that magenta line - in
>>> as far as I can tell, nothing has changed as a result of any of these
>>> (although reading back the register values, they're now much better.)
>>> What I do find is if I poke 0x78 back into the INVIDCONF register
>>> (which already contains 0x78) the magenta line disappears.
>>>
>>> I'm beginning to suspect that there's some ordering dependency that
>>> isn't being satisfied - but as the i.MX6Solo/DualLite manual doesn't
>>> seem to contain any of these details, I'm running out of ideas.
>>>
>>> _______________________________________________
>>>
>> It sound to me like you hit errata "ERR004308 HDMI: 8000504668?The
>> arithmetic unit may get wrong video
>> timing values although the FC_* registers hold correct values"
>>
>>
>> Also, checkout ERR005173, it says
>> "Workarounds:
>> The programming flow should be:
>> 1. Program all the controller registers including the frame composer
>> registers.
>> 2. Assert software resets
>> 3. Write (3 or 4 times) in FC_INVIDCONF the final value (this will make
>> sure that the update
>> pulse for the fc_arithlogicunit_div that will update the
>> fc_arithlogicunit_div units is generated)
>> 4. If frame composer packet queue overflow still occurs, then repeat
>> steps 2 and 3"
> Hi Troy,
>
> I think it's implementing that - we have this code:
>
> /* Workaround to clear the overflow condition */
> static void imx_hdmi_clear_overflow(struct imx_hdmi *hdmi)
> {
>          int count;
>          u8 val;
>           
>          val = hdmi_readb(hdmi, HDMI_FC_INVIDCONF);
>          
>          for (count = 0; count < 5; count++)
>                  hdmi_writeb(hdmi, val, HDMI_FC_INVIDCONF);
>           
>          /* TMDS software reset */
>          hdmi_writeb(hdmi, (u8)~HDMI_MC_SWRSTZ_TMDSSWRST_REQ, HDMI_MC_SWRSTZ);
> }
>
>
Freescale's kernel(imx_3.0.35_4.1.0) has this code

video/mxc_hdmi.c-/* Workaround to clear the overflow condition */
video/mxc_hdmi.c-static void mxc_hdmi_clear_overflow(void)
video/mxc_hdmi.c-{
video/mxc_hdmi.c-       int count;
video/mxc_hdmi.c-       u8 val;
video/mxc_hdmi.c-
video/mxc_hdmi.c-       /* TMDS software reset */
video/mxc_hdmi.c: hdmi_writeb((u8)~HDMI_MC_SWRSTZ_TMDSSWRST_REQ, 
HDMI_MC_SWRSTZ);
video/mxc_hdmi.c-
video/mxc_hdmi.c-       val = hdmi_readb(HDMI_FC_INVIDCONF);
video/mxc_hdmi.c-
video/mxc_hdmi.c-       if (cpu_is_mx6dl()) {
video/mxc_hdmi.c-                hdmi_writeb(val, HDMI_FC_INVIDCONF);
video/mxc_hdmi.c-                return;
video/mxc_hdmi.c-       }
video/mxc_hdmi.c-
video/mxc_hdmi.c-       for (count = 0 ; count < 5 ; count++)
video/mxc_hdmi.c-               hdmi_writeb(val, HDMI_FC_INVIDCONF);
video/mxc_hdmi.c-}

So, perhaps you need to move the software reset first.

I don't know of any other documentation.

Troy
