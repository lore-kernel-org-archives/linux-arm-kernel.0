From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 12 Nov 2014 11:38:58 -0800
Subject: [PATCH 2/7] pinctrl: pinconf-generic: Infer map type from DT
 property
In-Reply-To: <CACRpkdbOLMT1vfFg=CAU_VHdjxPWn_Ybso=+8Asp=mXhmNBRSA@mail.gmail.com>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
 <1415041531-15520-3-git-send-email-soren.brinkmann@xilinx.com>
 <CACRpkdbOLMT1vfFg=CAU_VHdjxPWn_Ybso=+8Asp=mXhmNBRSA@mail.gmail.com>
Message-ID: <02ceb46374884cbeaf0335ac44b9ba45@BY2FFO11FD043.protection.gbl>
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

Just looking into this, one user besides those two drivers is
pinconf-generic: pinconf_generic_dt_node_to_map() which is called from
 pinconf_generic_dt_node_to_map_pin() and
 pinconf_generic_dt_node_to_map_group()

And those would be a couple of more users. That's why I chose to not
change the behavior since this adds another 4 drivers to the list of
users that might depend on certain behavior.

	S?ren
