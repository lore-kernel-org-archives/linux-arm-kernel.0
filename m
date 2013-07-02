From: dsd@laptop.org (Daniel Drake)
Date: Mon, 1 Jul 2013 19:57:04 -0600
Subject: armada_drm clock selection - try 2
In-Reply-To: <51D1F921.9050608@gmail.com>
References: <20130701203009.633A8FAAD5@dev.laptop.org>
 <51D1F921.9050608@gmail.com>
Message-ID: <CAMLZHHRrdazrJwujCWrfzo_fcudtd4GUgMEEN2YScOAZeZ-4vA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 1, 2013 at 3:48 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:
> I guess "extclk0" and "extclk1" should be sufficient for clock names.
> Also, they are not dedicated as you can have CRTC0 and CRTC1 use e.g.
> extclk0 simultaneously. See below for .is_dedicated in general.

Maybe we can find better terminology, or just document it a bit
better, but having two CRTCs share the same clock falls within the
scheme designed and implemented there. "Dedicated" simply means a
clock that is dedicated to the display controller, it is not shared by
other devices.

>> +struct armada_clk_info {
>> +       struct clk *clk;
>> +
>> +       /* If this clock is dedicated to us, we can change its rate
>> without
>> +        * worrying about any other users in other parts of the system. */
>> +       bool is_dedicated;
>> +
>> +       /* However, we cannot share the same dedicated clock between two
>> CRTCs
>> +        * if each CRTC wants a different rate. Track the number of users.
>> */
>> +       int usage_count;
>
>
> You can share the same clock between two CRTCs. Just consider CRTC1
> using a mode with half pixel clock as CRTC0. Not that I think this will
> ever happen, but it is possible.

And my implementation already lets that happen - its just that I
didn't document it in enough detail.

> I prefer not to try to find the best clock (source) at all. Let the
> user pass the clock name by e.g. platform_data (or DT) and just try to
> get the requested pixclk or a integer multiple of it. You will never be
> able to find the best clock for all use cases.
>
> Just figure out, if integer division is sufficient to get requested
> pixclk and clk_set_rate otherwise. This may be useful for current mode
> running at 148.5MHz (1080p50) and new mode at 74.25MHz (1080i50, 720p).

I am not opposed to this approach, it is nice and simple, but as
Russell points out we do additionally need to distinguish between
clocks that are "ours" to play with, vs those that are shared with
other devices. It would be a bad idea to try call clk_set_rate() on
the AXI bus clock, for example, changing the clock for a whole bunch
of other devices. This is what the is_dedicated flag is about. However
such a flag could be easily added to the DT/platform data definition
that you propose.

Daniel
