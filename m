From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 02 Jul 2013 09:21:14 +0200
Subject: armada_drm clock selection - try 2
In-Reply-To: <CAMLZHHRrdazrJwujCWrfzo_fcudtd4GUgMEEN2YScOAZeZ-4vA@mail.gmail.com>
References: <20130701203009.633A8FAAD5@dev.laptop.org>
 <51D1F921.9050608@gmail.com>
 <CAMLZHHRrdazrJwujCWrfzo_fcudtd4GUgMEEN2YScOAZeZ-4vA@mail.gmail.com>
Message-ID: <51D27F6A.5000503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/13 03:57, Daniel Drake wrote:
> On Mon, Jul 1, 2013 at 3:48 PM, Sebastian Hesselbarth
> <sebastian.hesselbarth@gmail.com> wrote:
>> I prefer not to try to find the best clock (source) at all. Let the
>> user pass the clock name by e.g. platform_data (or DT) and just try to
>> get the requested pixclk or a integer multiple of it. You will never be
>> able to find the best clock for all use cases.
>>
>> Just figure out, if integer division is sufficient to get requested
>> pixclk and clk_set_rate otherwise. This may be useful for current mode
>> running at 148.5MHz (1080p50) and new mode at 74.25MHz (1080i50, 720p).
>
> I am not opposed to this approach, it is nice and simple, but as
> Russell points out we do additionally need to distinguish between
> clocks that are "ours" to play with, vs those that are shared with
> other devices. It would be a bad idea to try call clk_set_rate() on
> the AXI bus clock, for example, changing the clock for a whole bunch
> of other devices. This is what the is_dedicated flag is about. However
> such a flag could be easily added to the DT/platform data definition
> that you propose.

Daniel,

now I got the idea of .is_dedicated. At least for Dove, we could still
implement AXI bus clock as fixed-rate clock, so you cannot mess with it.
I am almost sure, it will hang Dove when you change it, as there are
some devices depending on it (and the correct rate of it). Moreover,
LCDCLK is dedicated to CRTC0/1 so AXICLK is the only clock not
dedicated to LCD controllers.

But I am fine with .is_dedicated - I just think we should not try to
find the best clock source but leave that decision to the user
(=developer, DTS author; not userspace user).

Sebastian
