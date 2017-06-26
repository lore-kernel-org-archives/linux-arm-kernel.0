From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Mon, 26 Jun 2017 18:28:39 +0200
Subject: omap3isp camera was Re: [PATCH v1 0/6] Add support of OV9655
 camera
In-Reply-To: <e725a457-5efc-22fa-ce97-bb7753185d21@st.com>
References: <1498143942-12682-1-git-send-email-hugues.fruchet@st.com>
 <385A82AC-CC23-41BD-9F57-0232F713FED9@goldelico.com>
 <1E453955-0C1A-414B-BBB2-C64B6D0EF378@goldelico.com>
 <20170625091856.GA22791@amd>
 <EDFD663F-37F9-42C2-92A9-66C2508B361E@goldelico.com>
 <20170626083927.GB9621@amd> <e725a457-5efc-22fa-ce97-bb7753185d21@st.com>
Message-ID: <E4E1E683-9CD0-4F23-AB03-080C52D0D73B@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hugues,

> Am 26.06.2017 um 15:19 schrieb Hugues FRUCHET <hugues.fruchet@st.com>:
> 
> Nikolaus,
> some comments about pixel format/resolution below:
> 
> On 06/26/2017 10:39 AM, Pavel Machek wrote:
>> On Mon 2017-06-26 08:05:04, H. Nikolaus Schaller wrote:
>>> Hi Pavel,
>>> 
>>>> Am 25.06.2017 um 11:18 schrieb Pavel Machek <pavel@ucw.cz>:
>>>> 
>>>> Hi!
>>>> 
>>>>> * unfortunately we still get no image :(
>>>>> 
>>>>> The latter is likely a setup issue of our camera interface (OMAP3 ISP = Image Signal Processor) which
>>>>> we were not yet able to solve. Oscilloscoping signals on the interface indicated that signals and
>>>>> sync are correct. But we do not know since mplayer only shows a green screen.
>>>> 
>>>> What mplayer command line do you use? How did you set up the pipeline
>>>> with media-ctl?
>>>> 
>>>> On kernel.org, I have tree called camera-fw5-6 , where camera works
>>>> for me on n900. On gitlab, there's modifed fcam-dev, which can be used
>>>> for testing.
>>> 
>>> We did have yet another (non-DT) camera driver and media-ctl working in with 3.12.37,
>>> but had no success yet to update it to work with modern kernels or drivers. It
>>> is either that the (newer) drivers missing something or the media-ctl has changed.
>>> 
>>> Here is the log of our scripts with Hugues' driver and our latest setup:
>>> 
>>> root at letux:~# ./camera-demo sxga
>>> DISPLAY=:0
>>> XAUTHORITY=tcp
>>> Camera: /dev/v4l-subdev8
>>> Setting mode sxga
>>> media-ctl -r
>>> media-ctl -l '"ov965x":0 -> "OMAP3 ISP CCDC":0[1]'
>>> media-ctl -l '"OMAP3 ISP CCDC":1 -> "OMAP3 ISP CCDC output":0[1]'
>>> media-ctl -V '"ov965x":0 [UYVY2X8 1280x1024]'
>>> media-ctl -V '"OMAP3 ISP CCDC":0 [UYVY2X8 1280x1024]'
>>> media-ctl -V '"OMAP3 ISP CCDC":1 [UYVY 1280x1024]'
>> 
>> Ok, so you are using capture, not preview.
>> 
>> You may want to try this one:
>> 
>> commit 0eae9d2a8f096f703cbc8f9a0ab155cd3cc14cef
>> Author: Pavel <pavel@ucw.cz>
>> Date:   Mon Feb 13 21:26:51 2017 +0100
>> 
>>     omap3isp: fix VP2SDR bit so capture (not preview) works
>> 
>>     This is neccessary for capture (not preview) to work properly on
>>         N900. Why is unknown.
>> 	
>> 									Pavel
>> 
>>> ### starting mplayer in sxga mode ###
>>> mplayer tv:// -vf rotate=2 -tv driver=v4l2:device=/dev/video2:outfmt=uyvy:width=1280:height=1024:fps=15 -vo x11
> 
> => "outfmt=uyvy:width=1280:height=1024"
> 
> Nikolaus,
> Be careful that only VGA/RGB565 is coded in this basic version of OV9655,
> perhaps this explain partly your troubles ?

Ah, I see. The driver should support SXGA and UYVY2X8 (because our 3.12 compatible driver did).

This very old (but working) non-DT driver for 3.12 kernels
was not based on the ov9650.c code but mt9p031.c:

	http://git.goldelico.com/?p=gta04-kernel.git;a=blob;f=drivers/media/i2c/ov9655.c;hb=refs/heads/3.12.37

We abandoned this independent driver because we felt (like you) that extending the existing
ov9650 driver is a better solution for mainline.


At least in theory. Therefore I assumed your submission supports SXGA and UYVY as well,
since your work is based on ours.

Nevertheless, VGA resolution doesn't work either.

root at letux:~# ./camera-demo vga
DISPLAY=:0
XAUTHORITY=tcp
Camera: /dev/v4l-subdev8
Setting mode vga
media-ctl -r
media-ctl -l '"ov965x":0 -> "OMAP3 ISP CCDC":0[1]'
media-ctl -l '"OMAP3 ISP CCDC":1 -> "OMAP3 ISP CCDC output":0[1]'
media-ctl -V '"ov965x":0 [UYVY2X8 640x480]'
media-ctl -V '"OMAP3 ISP CCDC":0 [UYVY2X8 640x480]'
media-ctl -V '"OMAP3 ISP CCDC":1 [UYVY 640x480]'
### starting mplayer in vga mode ###
mplayer tv:// -vf rotate=2 -tv driver=v4l2:device=/dev/video2:outfmt=uyvy:width=640:height=480:fps=30 -vo x11


A little later it reports a NULL pointer dereference in ccdc_link_validate() / ccdc_is_shiftable().

It appears as if the input format translates into a NULL pointer by
omap3isp_video_format_info(0x00001008).

This NULL pointer is not catched by ccdc_is_shiftable().

And it indicates that the camera driver is doing a format that is not
supported by omap3isp...


So how should we proceed?

It looks as if your driver supports your scenario (STM32F746G-DISCO) in VGA/RGB565
and our drivers (basically) support ours (omap3isp) in VGA/SXGA but UYVY.

We certainly need a generic driver that supports all platforms and formats. So
we somehow need to get all this stuff into a single driver.

Working on two different patch sets doesn't make sense and would be rejected
my maintainers...

Basically I could work on your basis to add what we need, but this requires your
basis to be stabilized first. Or I would spend more time rebasing my code than
fixing things.

Or you implement the missing formats / features and I test and try to pinpoint
and report issues to you for integration.

So we have to agree on some way to coordinate the work, especially who submits
patch sets for review here. Since you were faster than us to submit anything,
so you should continue with this series.

BR and thanks,
Nikolaus
