From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 28 Dec 2011 23:01:50 -0800
Subject: [PATCH] Input: keyboard - add device tree bindings for simple
 key matrixes
In-Reply-To: <CAOesGMiNuW3mexN_8PtunZkaVX4Uph-OgZFr5zLhaB1nih_EEw@mail.gmail.com>
References: <1325112771-31941-1-git-send-email-olof@lixom.net>
 <74CDBE0F657A3D45AFBB94109FB122FF17755DC8D2@HQMAIL01.nvidia.com>
 <CAOesGMiNuW3mexN_8PtunZkaVX4Uph-OgZFr5zLhaB1nih_EEw@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17755DC8DB@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Wednesday, December 28, 2011 11:34 PM:
> On Wed, Dec 28, 2011 at 10:16 PM, Stephen Warren <swarren@nvidia.com> wrote:
> > Olof Johansson wrote at Wednesday, December 28, 2011 3:53 PM:
> >> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >>
> >> This adds a basic device tree binding for simple key matrix data.
> >>
> >> Signed-off-by: Olof Johansson <olof@lixom.net>
> >> ---
> >>
> >> Based on email exchange this morning, this is a first cut at a shared
> >> definition and helper function to parse and fill in the keymap data.
> >>
> >> Instead of doing the direct parsing into the final keymap format, I
> >> chose to fill in the pdata-equivalent since that is how the OF pdata
> >> fillers work right now if code is to be kept common with the legacy
> >> platform_device probe interface.
> >>
> >> This is a prerequisite for a revised version of the tegra-kbc device
> >> tree support that I will repost separately once this interface is stable.
> > ...
> >> diff --git a/Documentation/devicetree/bindings/input/matrix-keymap.txt
> > ...
> >> +For simple keyboards with just a few buttons, you can specify each key
> >> +as a subnode of the keyboard controller, with the following
> >> +properties:
> >> +
> >> +- keypad,row: the row number to which the key is connected.
> >> +- keypad,column: the column number to which the key is connected.
> >> +- linux,code: the key-code to be reported when the key is pressed
> >> + ?and released.
> >> +
> >> +Example:
> >> +
> >> + ? ? key_1 {
> >> + ? ? ? ? ? ? keypad,row = <0>;
> >> + ? ? ? ? ? ? keypad,column = <3>;
> >> + ? ? ? ? ? ? linux,code = <2>;
> >> + ? ? };
> >> +
> >> +
> >> +For a more complex keyboard, such as a full laptop, a more compact
> >> +binding can be used instead, with the following property directly in
> >> +the keyboard controller node:
> >> +
> >> +- linux,keymap: an array of 3-cell entries containing the equivalent
> >> + ?of the three separate properties above: row, column and linux
> >> + ?key-code.
> >
> > Why allow two completely different bindings? Is there some deficiency
> > to the compact binding that means it isn't suitable for all cases?
> 
> The main reason is that the samsung keyboard driver already implements
> the more verbose one, and allowing that binding to coexist while also
> providing a more compact one seems like the right thing to do.

Can we deprecate the Samsung format, and only allow it for that Samsung
device (and allow both there), and require a single format for any other
keyboard?

The issue here is that U-Boot wants to stay small, and having to allow
two alternative methods to specify a keyboard is going to bloat the code;
I expect some pushback adding DT support for just one binding by the time
they see all the DT parsing code that's needed to do it all right.

-- 
nvpublic
