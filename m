From: net147@gmail.com (Jonathan Liu)
Date: Thu, 22 Sep 2016 08:06:29 +1000
Subject: [PATCH] drm/sun4i: rgb: Enable panel after controller
In-Reply-To: <20160921210340.GI8719@lukather>
References: <20160921130304.3486-1-net147@gmail.com>
 <20160921210340.GI8719@lukather>
Message-ID: <CANwerB2tO_1kpcW-n+mUNr4syHg7vqrFwn5nU+LJhhf+1cn9Lw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 22 September 2016 at 07:03, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Wed, Sep 21, 2016 at 11:03:04PM +1000, Jonathan Liu wrote:
>> The panel should be enabled after the controller so that the panel
>> prepare/enable delays are properly taken into account. Similarly, the
>> panel should be disabled before the controller so that the panel
>> unprepare/disable delays are properly taken into account.
>>
>> This is useful for avoiding visual glitches.
>
> This is not really taking any delays into account, especially since
> drm_panel_enable and prepare are suppose to block until their
> operation is complete.

drm_panel_prepare turns on power to the LCD using enable-gpios
property of the panel and then blocks for prepare delay. The prepare
delay for panel can be set to how long it takes between the time the
panel is powered to when it is ready to receive images. If backlight
property is specified the backlight will be off while the panel is
powered on.

drm_panel_enable blocks for enable delay and then turns on the
backlight. The enable delay can be set to how long it takes for panel
to start making the image visible after receiving the first valid
frame. For example if the panel starts off as white and the TFT takes
some time to initialize to black before it shows the image being
received.

Refer to drivers/gpu/drm/panel-panel.simple.c for details.

Regards,
Jonathan
