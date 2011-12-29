From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 28 Dec 2011 22:58:21 -0800
Subject: [PATCH v2 2/2] Input: tegra-kbc - add default chromeos map
In-Reply-To: <CAOesGMi6CpVVjUS4EoXbtxdw=Wj8G2_+SFzvqp1DP_mpjCoNVA@mail.gmail.com>
References: <1325053170-6984-1-git-send-email-olof@lixom.net>
 <1325053170-6984-3-git-send-email-olof@lixom.net>
 <20111228065013.GB29273@core.coreip.homeip.net>
 <CAOesGMheQqYjpDRaf6TTce2YEcD4hkTzS2JTdoCe3ue6+dBhDQ@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17755DC8D0@HQMAIL01.nvidia.com>
 <CAOesGMi6CpVVjUS4EoXbtxdw=Wj8G2_+SFzvqp1DP_mpjCoNVA@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17755DC8D9@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Wednesday, December 28, 2011 11:42 PM:
> On Wed, Dec 28, 2011 at 10:06 PM, Stephen Warren <swarren@nvidia.com> wrote:
> > Olof Johansson wrote at Wednesday, December 28, 2011 12:33 AM:
> >> On Tue, Dec 27, 2011 at 10:50 PM, Dmitry Torokhov
> >> <dmitry.torokhov@gmail.com> wrote:
> >> > On Tue, Dec 27, 2011 at 10:19:30PM -0800, Olof Johansson wrote:
> >> >> This adds a simple way to specify the ChromeOS-specific keyboard map
> >> >> instead of the "standard" map that is used on other Tegra devices such
> >> >> as Harmony-with-keyboard and Seaboard.
> >> >>
> >> >> I expect the number of different keyboard layouts to be quite limited,
> >> >> and not many should be added over time. So instead of encoding the layout
> >> >> in the device tree, with all the can of worms that entails w.r.t. agreeing
> >> >> on a suitable binding, just add a property to specify that this is the
> >> >> map to be used, and include it in the driver.
> >> >>
> >> >> If, over time, the number of mappings increase, the binding can be
> >> >> updated to include a custom map as a new property, without having to
> >> >> worry about backwards compatibility on existing devices.
> >> >>
> >> >
> >> > I'd rather we did not make shortcuts and did the proper DT binding.
> >> > Samsung folks want the similar thing so making a generic DT keymap
> >> > parser and using it in the driver would be the best way.
> >>
> >> Ok, fair point. I found the last posted version of the samsung driver
> >> in my archives so I'll continue the discussion there (see separate
> >> followup there).
> >
> > I agree here. Simon Glass has posted some patches to U-Boot to add the
> > Tegra KBC driver including DT bindings. Can you please co-ordinate with
> > him to ensure the bindings you're proposing for the kernel match those
> > he's proposing for U-Boot; from memory, I don't think they are so far.
> > Also, we need to work out the issue of the kernel needing just the base
> > and function-modified keymap, but U-Boot needing a shift- and ctrl-
> > modified keymap since there's no input layer handling shift/ctrl in
> > U-Boot.
> 
> I answered this in the other email; since the modifier keymaps don't
> actually describe hardware functionality but instead software
> remappings, it should be done in u-boot, and the device tree binding
> should be focused on describing the hardware.

For function/Fn, I think representing that in DT makes sense; there's
no simple/standard mapping that any driver could implement to translate
a raw keypress to an fn-keypress; the labeling is completely board-
specific, and the Fn key is really multi-plexing two completely different
keys onto a single physical key (on my x86 laptop, I have a single key
for both Insert and Delete, differentiating by using the Fn key). PC
(PS/2 or USB) keyboards handle Fn internally to the HW, so I think this
gives precedent for considering an Fn mapping part of the HW for a matrix
Keyboard.

For shift/ctrl, I agree not having the mappings in DT makes sense. However,
Simon Glass gave me pushback on this when I requested the removal of those
properties in the U-Boot patch.

Note that my comments immediately below were more about how to modify
Simon Glass's patch to be acceptable rather than your proposal.

> > I'd prefer that the DT binding be encoded as:
> >
> > matrix -> keycode for base
> > matrix -> keycode for function-modified
> >
> > With the binding for those two defined by either the Tegra KBC binding or
> > a generic matrix KBC binding.
> >
> > keycode -> keycode for shift-modified
> > keycode -> keycode for ctrl-modified
> >
> > With the binding for those two defined by some kind of generic modifier
> > mapping binding, so it could feed into the input layer on Linux, although
> > in U-Boot, the Tegra KBC driver would have to handle it itself, since
> > there's nowhere else to handle it.
> 
> This is in my opinion unnecessarily complicated, and it's trying to
> push too much upper-layer information down into the hardware
> description. Keeping the binding to the bare minimum needed to
> describe the actual hardware configuration is the natural common
> ground not just between u-boot and linux, but also with other
> operating systems and between different hardware vendors.

-- 
nvpublic
