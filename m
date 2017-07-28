From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Fri, 28 Jul 2017 14:37:10 +0200
Subject: [PATCH v3 0/2] media: Add Amlogic Meson AO CEC Controller support
In-Reply-To: <d9aecd99-47d7-6a72-8d07-d64e185ea60e@xs4all.nl>
References: <1501168830-5308-1-git-send-email-narmstrong@baylibre.com>
 <d9aecd99-47d7-6a72-8d07-d64e185ea60e@xs4all.nl>
Message-ID: <36cab0eb-0986-58d6-9cec-9bf4ab099495@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28/2017 02:35 PM, Hans Verkuil wrote:
> Hi Neil,
> 
> On 07/27/2017 05:20 PM, Neil Armstrong wrote:
>> The Amlogic SoC embeds a standalone CEC controller, this patch adds a driver
>> for such controller.
>> The controller does not need HPD to be active, and could support up to max
>> 5 logical addresses, but only 1 is handled since the Suspend firmware can
>> make use of this unique logical address to wake up the device.
>>
>> The Suspend firmware configuration will be added in an other patchset.
> 
> Note that to get the right module dependencies you will also need to add
> this line:
> 
> 	select CEC_CORE if CEC_NOTIFIER
> 
> to DRM_MESON_DW_HDMI in drivers/gpu/drm/meson/Kconfig.
> 
> This ensures that if DRM_MESON_DW_HDMI is 'y' but VIDEO_MESON_AO_CEC is 'm'
> the CEC_CORE config is set to 'y'.
> 
> Obviously this is a patch for dri-devel.

I was too quick sending this: I expect this line to appear in DRM_DW_HDMI,
not DRM_MESON_DW_HDMI. Sorry about the noise.

	Hans

> 
> Regards,
> 
> 	Hans
> 
>>
>> Changes since v2 at [2] :
>>  - change meson_ao_cec_read/write prototype to simplify error handling
>>
>> Changes since v1 at [1] :
>>  - add timeout to wait busy, with error return
>>  - handle busy error in all read/write operations
>>  - add CEC_CAP_PASSTHROUGH
>>  - add bindings ack
>>
>> [1] https://lkml.kernel.org/r/1499336870-24118-1-git-send-email-narmstrong at baylibre.com
>> [2] https://lkml.kernel.org/r/1499673696-21372-1-git-send-email-narmstrong at baylibre.com
>>
>> Neil Armstrong (2):
>>   platform: Add Amlogic Meson AO CEC Controller driver
>>   dt-bindings: media: Add Amlogic Meson AO-CEC bindings
>>
>>  .../devicetree/bindings/media/meson-ao-cec.txt     |  28 +
>>  drivers/media/platform/Kconfig                     |  11 +
>>  drivers/media/platform/Makefile                    |   2 +
>>  drivers/media/platform/meson/Makefile              |   1 +
>>  drivers/media/platform/meson/ao-cec.c              | 744 +++++++++++++++++++++
>>  5 files changed, 786 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/media/meson-ao-cec.txt
>>  create mode 100644 drivers/media/platform/meson/Makefile
>>  create mode 100644 drivers/media/platform/meson/ao-cec.c
>>
> 
