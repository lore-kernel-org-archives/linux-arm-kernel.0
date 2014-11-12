From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 12 Nov 2014 10:46:26 -0800
Subject: [PATCH 2/7] pinctrl: pinconf-generic: Infer map type from DT
 property
In-Reply-To: <CACRpkdbOLMT1vfFg=CAU_VHdjxPWn_Ybso=+8Asp=mXhmNBRSA@mail.gmail.com>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
 <1415041531-15520-3-git-send-email-soren.brinkmann@xilinx.com>
 <CACRpkdbOLMT1vfFg=CAU_VHdjxPWn_Ybso=+8Asp=mXhmNBRSA@mail.gmail.com>
Message-ID: <ce4400ac9091437aa7da16ea131c65cd@BN1BFFO11FD005.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-11-11 at 01:47PM +0100, Linus Walleij wrote:
> On Mon, Nov 3, 2014 at 8:05 PM, Soren Brinkmann
> <soren.brinkmann@xilinx.com> wrote:
> 
> > With the new 'groups' property, the DT parser can infer the map type
> > from the fact whether 'pins' or 'groups' is used to specify the pin
> > group to work on.
> > To maintain backwards compatibitliy with current usage of the DT
> > binding, this is only done when an invalid map type is passed to the
> > parsing function.
> 
> So that is this:
> 
> > +               if (type == PIN_MAP_TYPE_INVALID)
> > +                       type = PIN_MAP_TYPE_CONFIGS_GROUP;
> > +               dt_pin_specifier = "groups";
> 
> This is just kludgy. There are only two kernel-internal users of this function,
> refactor the function signature and change the other callers over instead,
> patch the drivers.

As I said in my other email. I chose to maintain current behavior to
avoid disturbing current users. If changing this the way you suggest,
works for everybody that is clearly preferred.

> 
> Take this opportunity to add some kerneldoc above the
> pinconf_generic_dt_subnode_to_map() and give the function a
> reasonable signature.

Yeah, didn't want to put too much effort into it without a confirmation
of this being on the right track.

> 
> BTW: this is just for config settings for groups right? Not for muxing
> I hope?

Yep, when 'function' is found, the pins/groups are passed to
pinctrl_utils_add_map_mux() which always uses mux group as type.

	S?ren
