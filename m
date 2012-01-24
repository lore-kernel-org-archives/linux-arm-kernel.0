From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 24 Jan 2012 15:09:19 -0800
Subject: [PATCH 1/4] pinctrl: add a driver for NVIDIA Tegra
In-Reply-To: <CACRpkdZvakueQGYX0wyTFWmpC6wiixj2g1PTuKM4CgEzqJbmig@mail.gmail.com>
References: <1327083746-31430-1-git-send-email-swarren@nvidia.com>
 <CACRpkdZvakueQGYX0wyTFWmpC6wiixj2g1PTuKM4CgEzqJbmig@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF178CB81F06@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote at Tuesday, January 24, 2012 3:34 PM:
> On Fri, Jan 20, 2012 at 7:22 PM, Stephen Warren <swarren@nvidia.com> wrote:
> 
> > This adds a driver for the Tegra pinmux, and required parameterization
> > data for Tegra20 and Tegra30.
> 
> Very appetizing - the only scary thing is the size. Some
> comments, if noone else yells after these are addressed I might
> just merge it (or I find more things to complain about...)
> 
> > +static int tegra_pinconf_reg(struct tegra_pmx *pmx,
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ?const struct tegra_pingroup *g,
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ?enum tegra_pinconf_param param,
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ?s8 *bank, s16 *reg, s8 *bit, s8 *width)
> 
> Why are the four last parameters signed?
> 
> Or, rather as it seems to be a consequence of this:

Yes, exactly...

> > +struct tegra_pingroup {
> > + ? ? ? const char *name;
> > + ? ? ? const unsigned *pins;
> > + ? ? ? unsigned npins;
> > + ? ? ? int funcs[4];
> > + ? ? ? int func_safe;
> > + ? ? ? s16 mux_reg; ? ? ? ? ? ?/* Mux register offset */
> > + ? ? ? s8 mux_bank; ? ? ? ? ? ?/* Mux register bank */
> > + ? ? ? s8 mux_bit; ? ? ? ? ? ? /* Mux register bit */
> > + ? ? ? s16 pupd_reg; ? ? ? ? ? /* Pull-up/down register offset */
> > + ? ? ? s8 pupd_bank; ? ? ? ? ? /* Pull-up/down register bank */
> > + ? ? ? s8 pupd_bit; ? ? ? ? ? ?/* Pull-up/down register bit */
> > + ? ? ? s16 tri_reg; ? ? ? ? ? ?/* Tri-state register offset */
> > + ? ? ? s8 tri_bank; ? ? ? ? ? ?/* Tri-state register bank */
> > + ? ? ? s8 tri_bit; ? ? ? ? ? ? /* Tri-state register bit */
> > + ? ? ? s16 einput_reg; ? ? ? ? /* Enable-input register offset */
> > + ? ? ? s8 einput_bank; ? ? ? ? /* Enable-input register bank */
> > + ? ? ? s8 einput_bit; ? ? ? ? ?/* Enable-input register bit */
> > + ? ? ? s16 odrain_reg; ? ? ? ? /* Open-drain register offset */
> > + ? ? ? s8 odrain_bank; ? ? ? ? /* Open-drain register bank */
> > + ? ? ? s8 odrain_bit; ? ? ? ? ?/* Open-drain register bit */
> > + ? ? ? s16 lock_reg; ? ? ? ? ? /* Lock register offset */
> > + ? ? ? s8 lock_bank; ? ? ? ? ? /* Lock register bank */
> > + ? ? ? s8 lock_bit; ? ? ? ? ? ?/* Lock register bit */
> > + ? ? ? s16 ioreset_reg; ? ? ? ?/* IO reset register offset */
> > + ? ? ? s8 ioreset_bank; ? ? ? ?/* IO reset register bank */
> > + ? ? ? s8 ioreset_bit; ? ? ? ? /* IO reset register bit */
> > + ? ? ? s16 drv_reg; ? ? ? ? ? ?/* Drive fields register offset */
> > + ? ? ? s8 drv_bank; ? ? ? ? ? ?/* Drive fields register bank */
> > + ? ? ? s8 hsm_bit; ? ? ? ? ? ? /* High Speed Mode register bit */
> > + ? ? ? s8 schmitt_bit; ? ? ? ? /* Scmitt register bit */
> > + ? ? ? s8 lpmd_bit; ? ? ? ? ? ?/* Low Power Mode register bit */
> > + ? ? ? s8 drvdn_bit; ? ? ? ? ? /* Drive Down register bit */
> > + ? ? ? s8 drvdn_width; ? ? ? ? /* Drive Down field width */
> > + ? ? ? s8 drvup_bit; ? ? ? ? ? /* Drive Up register bit */
> > + ? ? ? s8 drvup_width; ? ? ? ? /* Drive Up field width */
> > + ? ? ? s8 slwr_bit; ? ? ? ? ? ?/* Slew Rising register bit */
> > + ? ? ? s8 slwr_width; ? ? ? ? ?/* Slew Rising field width */
> > + ? ? ? s8 slwf_bit; ? ? ? ? ? ?/* Slew Falling register bit */
> > + ? ? ? s8 slwf_width; ? ? ? ? ?/* Slew Falling field width */
> > +};
> 
> Why are all of these things (reg bank bit ets) signed?

The basic issue is that all of these features are optional for any
given pin group. I used -1 to indicate an unsupported feature. More
details at the end of the email.

I guess an alternative is to add a field "u32 foo_supported:1" for each
feature, and change everything else to u32 too.

> Especially since a lot of them appear to translate into
> readl() writel() calls in the end, and these are unsigned.
> 
> Also, things named  *_bit are a bit (no pun intended) binary,
> are they containing a single bit? In that case say

They're the bit number/shift within a register. Range 0..31

> u8 foo:1
> 
> To mark that it's only one bit wide, or u8 foo:4 for four bits
> etc.

I guess I could be explicit about the max range for each value. It might
save up to about 8 bytes per pin group, perhaps less based on how well
things pack to u32 boundaries.

> func_safe doesn't look like an int either when I look at
> the code. It's something else, u8?

It's a "enum tegra_mux", which IIRC is technically an int, but unsigned
is more consistent with the rest of pinctrl.

> Second, please move out the inline comment to kerneldoc
> above the struct.

Sure.


More details on pin group features:

Tegra's pin controller supports many features for pins/groups:
* Mux function selection
* Pull-up/down
* Tri-state
* Drive strength
* ...

On Tegra20, each of these features is configured at a pin group level;
there is a single register field that affects multiple pins at once.
The groups for each feature may not exactly intersect; one register
field may set the mux function for pins A, B, C, whereas a different
register field may set the drive strength for pins C, X, Y. Some pins
may not have a mux function selector. Others may not support enabling
high speed mode or Schmitt trigger.

In order to represent this sanely, I've define a pin group for each
unique set of pins affected by some register field(s). Obviously, each
pin group supports a subset of all possible configuration parameters,
and hence the need to indicate "there is no register/bit" for this
parameter on this pin group.

Tegra30 is somewhat simpler; each pin can be mux'd separately, and
some additional parameters may be set per pin. Some of the parameters
still aren't supported on all pins though. Equally, some advanced
drive-strength-related parameters are still configured at a pin-group
level not a per-pin level, and again not all groups support every
parameter.

-- 
nvpublic
