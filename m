From: snjw23@gmail.com (Sylwester Nawrocki)
Date: Sun, 05 Feb 2012 21:44:01 +0100
Subject: [RFC PATCH 5/7] ARM: davinci: i2c: add OF support
In-Reply-To: <20120130201307.GV28397@ponder.secretlab.ca>
References: <1327308967-8092-1-git-send-email-hs@denx.de>
 <1327308967-8092-6-git-send-email-hs@denx.de> <4F1DC480.4010603@gmail.com>
 <4F1E5B44.4090200@denx.de> <4F1E7F36.50505@samsung.com>
 <20120130201307.GV28397@ponder.secretlab.ca>
Message-ID: <4F2EEA11.9080807@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On 01/30/2012 09:13 PM, Grant Likely wrote:
> The whole 'cell-index' or 'id' thing is a BadIdea(tm).  Don't use it, and tell
> others not to do it when you see it.  There are some legacy uses in powerpc,
> but those were written before I and others knew better.
> 
> The *only* situation where cell-index is acceptable is when the driver
> absolutely must know which hardware instance it is driving because it
> needs to calculate offsets in a shared register or something, and even
> then it should not be used to set the pdev->id field. That situation
> does not look to be the case here.

Thanks a lot for the clarification. Some media device drivers use the pdev->id
field to enumerate hardware entities which are shown to user space libraries/
applications through the media device interface:
<http://linuxtv.org/downloads/v4l-dvb-apis/media-ioc-enum-entities.html>

The entity name is initialized from dev_name(&pdev->dev), which in DT case
will be rather random string AFAICS. Is using 'cell-index' property justified
in such cases ? 
 
> If you're using the DT, then let the core code dynamically assign the
> i2c adapter number.

Then it means that all uses if i2c_get_adapter() that take an I2C adapter 
number as an argument need to be converted accordingly, e.g. we need an OF
version of i2c_get_adapter() ?

The V4L core provides v4l2_i2c_new_subdev_board() function which is used
by the video bridge drivers to register its sub-devices - I2C clients 
(usually image sensors or video encoders). The I2C bus ids are usually 
provided as platform data to the bridge driver. Sounds like all this will
need to be reworked quite significantly for DT support.

---

Thanks,
Sylwester
