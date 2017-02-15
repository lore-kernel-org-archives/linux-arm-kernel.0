From: dianders@chromium.org (Doug Anderson)
Date: Wed, 15 Feb 2017 08:46:06 -0800
Subject: [PATCH] clk: rockchip: Set "ignore unused" for PMU M0 clocks on
 rk3399
In-Reply-To: <CABxcv=kzW9SvrWYNasqCDkV7D6Y2zq+oRuqoPFdWuaWUhPehEA@mail.gmail.com>
References: <20170214210114.5846-1-dianders@chromium.org>
 <CABxcv=kzW9SvrWYNasqCDkV7D6Y2zq+oRuqoPFdWuaWUhPehEA@mail.gmail.com>
Message-ID: <CAD=FV=WLN6r9DgRQSk2En1sJY=dQnkkWDMc1+KXVq2+JXyA0jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 15, 2017 at 7:27 AM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
> Hello Doug,
>
> On Tue, Feb 14, 2017 at 6:01 PM, Douglas Anderson <dianders@chromium.org> wrote:
>> The PMU Cortex M0 on rk3399 is intended to be used for things like
>> DDRFreq transitions, suspend/resume, and other things that are the
>> purview of ARM Trusted Firmware and not the kernel.  As such, the
>> kernel shouldn't be messing with the clocks.  Add CLK_IGNORE_UNUSED to
>> these clocks.
>>
>
> Isn't CLK_IS_CRITICAL a more suitable flag for this case?

As I understand it (AKA please correct me if I'm wrong)...

Usually CLK_IS_CRITICAL is more suitable than CLK_IGNORE_UNUSED since
lots of old code used CLK_IGNORE_UNUSED for critical clocks before
CLK_IS_CRITICAL existed.

...but in this case, I don't think it is more suitable.
CLK_IS_CRITICAL means that the kernel should be in charge of keeping
this clock on at all times.  The documentation I see says:

#define CLK_IS_CRITICAL         BIT(11) /* do not gate, ever */

In our case, as was so eloquently described in our private bug by our
firmware engineer:

  Just tell the kernel to keep its grubby hands off my clocks completely

AKA: this isn't a clock that the kernel should touch--it is entirely
managed by the firmware.  It's OK for the kernel to show it in the
clock tree, but otherwise "hands off".

-Doug
