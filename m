From: peda@axentia.se (Peter Rosin)
Date: Tue, 31 Jul 2018 12:43:34 +0200
Subject: [PATCH v2 0/7] tda998x: allow use with bridge based devices
In-Reply-To: <20180731092343.GH17271@n2100.armlinux.org.uk>
References: <20180730164137.GD17271@n2100.armlinux.org.uk>
 <73adc630-21cd-5b14-cb47-f1a58ee3bc83@axentia.se>
 <20180731074114.GF17271@n2100.armlinux.org.uk>
 <9d48e374-be2f-fbc0-ca92-1b7e1b68e358@axentia.se>
 <20180731092343.GH17271@n2100.armlinux.org.uk>
Message-ID: <9bf5e0e9-c1e8-5af2-7fea-40f9618d4d52@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-07-31 11:23, Russell King - ARM Linux wrote:
> On Tue, Jul 31, 2018 at 09:53:57AM +0200, Peter Rosin wrote:
>> On 2018-07-31 09:41, Russell King - ARM Linux wrote:
>>> On Tue, Jul 31, 2018 at 07:44:24AM +0200, Peter Rosin wrote:
>>>> On 2018-07-30 18:41, Russell King - ARM Linux wrote:
>>>>> Hi,
>>>>>
>>>>> This is a re-posting of the series I responded to Peter Rosin's May
>>>>> posting, with a few bugs fixed, and the bridge registered outside of
>>>>> the component helper.  This should allow Peter to use the driver
>>>>> while maintaining armada drm and tilcdc support.
>>>>>
>>>>> No comments (other than 0-day test results) were received on the
>>>>> previous posting.
>>>>
>>>> I of course meant to comment on this! I didn't because there was a rush
>>>> before vacation, then vacation, then a heap of important stuff that had
>>>> piled up. This one simply had too low priority to make a significant bleep
>>>> on the radar. Sorry for the silence...
>>>>
>>>> However, now that I do try to test, I get conflicts as I try to apply the
>>>> patches. I'm wondering what this was based on? I've tried next-20180730
>>>> drm-misc/drm-misc-next from some minutes ago.
>>>
>>> They're based on 4.17.
>>
>> Right, meanwhile I massaged the patches into a combo of some local patches,
>> next-20180730 and drm-misc-next, and tested that. The conflict was trivial
>> once I had a closer look...
>>
>> And it seems to work (with atmel-hlcdc), so you can add
>>
>> Tested-by: Peter Rosin <peda@axentia.se>
> 
> Thanks, I've added your attributation, and fixed patch 2 as you pointed
> out.
> 
> I have a four more tda998x patches if you're willing to test.  These
> follow on from this set - I've tweaked patch 2 in this follow on set to
> cater for the removal of "_mode_" in
> drm_mode_connector_update_edid_property.

Sure thing. Those patches work for me too. So, feel free to add

Tested-by: Peter Rosin <peda@axentia.se>

However, a couple of notes:

1) I never succeeded in reading the edid, so I'm using a built-in edid.

I noticed the patch adding the nxp,calib gpio and got my hopes up, but
if I just add that to the DT I get

tda998x 2-0070: found TDA19988
gpio-21 (nxp,calib): gpiod_direction_output: tried to set a GPIO tied to an IRQ as output
tda9950 2-0034: TDA9950 CEC interface, hardware version 3.3

Grepping the source, that comes from gpiod_direction_output, which
fails with -EIO after that message, so that can't be working...

(Side note on that gpio; the way I read the patch I should specify
the gpio as GPIO_ACTIVE_HIGH, but that seems backwards? Isn't the
INT pin on the tda19988 active low?)

...and if I try to evade that by commenting out the interrupt stuff
from the DT, I instead get

tda998x 2-0070: found TDA19988
tda9950 2-0034: driver requires an interrupt

Are we supposed to wire the INT pin to two different pins on the CPU, or
what?

Is edid reading know to work on 19988? The code suggests so, but maybe
it hasn't been tested? Or maybe it regressed?

2) The lowest resolution on my monitor is 800x600, so I suppose I
can't really test 4/4?

Cheers,
Peter

>  drivers/gpu/drm/i2c/tda998x_drv.c | 106 ++++++++++++++++++--------------------
>  1 file changed, 51 insertions(+), 55 deletions(-)
> 
