From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 15 Jan 2015 15:38:55 +0100
Subject: [PATCH 1/3] input: tsc2007: Add pre-calibration, flipping and
 rotation
In-Reply-To: <0F9A17C1-9B01-4EE9-BE98-266B8FC02B84@goldelico.com>
References: <1412108254-19234-1-git-send-email-marek@goldelico.com>
 <1412108254-19234-2-git-send-email-marek@goldelico.com>
 <CAAfyv36bD9ZratOzr7FkeQde8k-K9XjEjH9gkntm9qewD-cH9g@mail.gmail.com>
 <20150115005938.GB9134@dtor-ws>
 <0F9A17C1-9B01-4EE9-BE98-266B8FC02B84@goldelico.com>
Message-ID: <20150115143855.GD512@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 15, 2015 at 08:36:44AM +0100, Dr. H. Nikolaus Schaller wrote:
> > 1. Perform conversion in input core rather than individual drivers. I
> > think we should allocate a new bitmaps for some transformations and have
> > the code do X/Y flip/clip of the coordinates.
> 
> Do you have a suggestion where this should be (I have no clue how
> the input system works or is structured - we just know how to extend a
> driver that uses it)?
> 
> > 2. Standardize on bindings. We already have of-touchscreen.c doing
> > rudimentary parsing, we shoudl look into extending it rather than
> > creating myriad of driver-specific bindings.
> 
> Ok, looks reasonable.

Documentation is in 

Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt

> > Also, do we need swap and flip or do we simply need rotation (like the
> > proposed Broadcom iproc driver has)?
> 
> Well, since the DT should describe hardware, there are 3 sets of wires which
> can have a cross-over: X+ and X-, Y+ and Y-, X and Y.
>
> So IMHO hardware has no ?rotation?, just crossover of wires. Rotation is an
> interpretation of the result of these connections in combination with some
> panel the touch is glued to and should therefore not be represented in the DT.
> 
> As a result we have proposed a scheme without explicit rotation. We specify what
> coordinates X- and X+ should report at their ends (min, max) because the DT
> programmer has to specify them anyways. Flipping is a result of defining these
> coordinates in an ascending or descending way. Only swapping of the X and Y
> wires can?t be implicitly defined so it has its own property. So the scheme we
> have proposed tries to optimize the efforts needed to adapt new boards and write
> DTs and focus the DT on hardware description.
> 
> As a bonus we also specify the min and max value to be reported for the touch
> pressure (Z axis) using the same basic principle.
> 
> And it is a pure add-on on top of the existing driver so that it attempts not
> to break existing device trees.

from what I can see there are no in-tree-users using any of the
new properties.

> Maybe could you accept it as a first step for this specific driver (and let?s do
> the big standardization work later on)?

That does not work, since you create an ABI.

-- Sebastian
