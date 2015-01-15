From: hns@goldelico.com (Dr. H. Nikolaus Schaller)
Date: Thu, 15 Jan 2015 08:36:44 +0100
Subject: [PATCH 1/3] input: tsc2007: Add pre-calibration,
 flipping and rotation
In-Reply-To: <20150115005938.GB9134@dtor-ws>
References: <1412108254-19234-1-git-send-email-marek@goldelico.com>
 <1412108254-19234-2-git-send-email-marek@goldelico.com>
 <CAAfyv36bD9ZratOzr7FkeQde8k-K9XjEjH9gkntm9qewD-cH9g@mail.gmail.com>
 <20150115005938.GB9134@dtor-ws>
Message-ID: <0F9A17C1-9B01-4EE9-BE98-266B8FC02B84@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 15.01.2015 um 01:59 schrieb Dmitry Torokhov <dmitry.torokhov@gmail.com>:

> On Sat, Jan 10, 2015 at 03:15:39PM +0100, Belisko Marek wrote:
>> Ping for input maintainer. DT changes was acked. Thanks.
>> 
>> On Tue, Sep 30, 2014 at 10:17 PM, Marek Belisko <marek@goldelico.com> wrote:
>>> This patch adds new parameters that allow to address typical hardware
>>> design differences: touch screens may be wired or oriented differently
>>> (portrait or landscape). And usually the active area of the touch is a
>>> little larger than the active area of the LCD. This results in the touch
>>> coordinates that have some significant deviation from LCD coordinates.
>>> Usually this is addressed in user space by a calibration tool (e.g. tslib
>>> or xinput-calibrator) but some systems don't have these tools or require
>>> that the screen is already roughly calibrated (e.g. Replicant) to operate
>>> the device until a better calibration can be done. And, some systems
>>> react very strangely if the touch event stream reports coordinates
>>> outside of the active area.
>>> 
>>> This makes it necessry to be able to configure:
>>> 1. swapping x and y wires (coordinate values)
>>> 2. flipping of x (left - right) or y (top - bottom) or even both
>>> 3. define an active area so that an uncalibrated screen already
>>> roughly matches the LCD to be useful.
>>> 4. clip reported coordinates to the active area.
>>> 
>>> If none of the new parameters is defined (in DT) or set in a board file,
>>> the driver behaves the same as without this patch.
>>> 
>>> Author (1&2): H. Nikolaus Schaller <hns@goldelico.com>
>>> Author (3&4): Paul Kocialkowski <contact@paulk.fr>
>>> 
>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> 
> OK, I was hesitant of adding these as normally we have tslib to perform
> the conversion, but maybe it is time to allow it in the kernel and
> standardize users.

Well, tslib isn?t a good replacement for this problem any more and
pre-initializing tslib makes some deep hardware dependency visible
in user space (each board needs a different tslib config and pointercal
default - and on some user spaces tslib is broken with Xorg).

But the issue to be solved is more hardware related, i.e. if the Y- and Y+
pins of the controller are connected in a swapped way to the resistor
ends of the panel.

Hence in a DT based system, this must IMHO be described by the DT
and can not be left to some user-space functions any more.

> However, this seems like a general issue and we
> should:
> 
> 1. Perform conversion in input core rather than individual drivers. I
> think we should allocate a new bitmaps for some transformations and have
> the code do X/Y flip/clip of the coordinates.

Do you have a suggestion where this should be (I have no clue how
the input system works or is structured - we just know how to extend a
driver that uses it)?

> 
> 2. Standardize on bindings. We already have of-touchscreen.c doing
> rudimentary parsing, we shoudl look into extending it rather than
> creating myriad of driver-specific bindings.

Ok, looks reasonable.

> 
> Also, do we need swap and flip or do we simply need rotation (like the
> proposed Broadcom iproc driver has)?

Well, since the DT should describe hardware, there are 3 sets of wires which
can have a cross-over: X+ and X-, Y+ and Y-, X and Y.

So IMHO hardware has no ?rotation?, just crossover of wires. Rotation is an
interpretation of the result of these connections in combination with some
panel the touch is glued to and should therefore not be represented in the DT.

As a result we have proposed a scheme without explicit rotation. We specify what
coordinates X- and X+ should report at their ends (min, max) because the DT
programmer has to specify them anyways. Flipping is a result of defining these
coordinates in an ascending or descending way. Only swapping of the X and Y
wires can?t be implicitly defined so it has its own property. So the scheme we
have proposed tries to optimize the efforts needed to adapt new boards and write
DTs and focus the DT on hardware description.

As a bonus we also specify the min and max value to be reported for the touch
pressure (Z axis) using the same basic principle.

And it is a pure add-on on top of the existing driver so that it attempts not
to break existing device trees.

Maybe could you accept it as a first step for this specific driver (and let?s do
the big standardization work later on)?

? hns
