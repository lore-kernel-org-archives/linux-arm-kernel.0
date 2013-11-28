From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 28 Nov 2013 09:30:26 +0100
Subject: [PATCH 2/3] regulator: tps6586x: add voltage table for tps658643
In-Reply-To: <93a0f4b1da2a54e58cee0756ab5f3e36@agner.ch>
References: <cover.1385508112.git.stefan@agner.ch>
 <8be2fe8560cc19f03d5be40ad3dc21d5979c8358.1385508112.git.stefan@agner.ch>
 <5296273C.1000705@wwwdotorg.org>
 <93a0f4b1da2a54e58cee0756ab5f3e36@agner.ch>
Message-ID: <20131128083025.GB26502@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 10:56:10PM +0100, Stefan Agner wrote:
> Am 2013-11-27 18:09, schrieb Stephen Warren:
> > On 11/26/2013 04:45 PM, Stefan Agner wrote:
> >> Depending on version, the voltage table might be different. Add version
> >> compatibility to the regulator information in order to select correct
> >> voltage table.
> > 
> >> diff --git a/drivers/regulator/tps6586x-regulator.c b/drivers/regulator/tps6586x-regulator.c
> > 
> >> -static const unsigned int tps6586x_ldo4_voltages[] = {
> >> +static const unsigned int tps6586x_ldo4_sm2_voltages[] = {
> > 
> >> +static const unsigned int tps658643_sm2_voltages[] = {
> > 
> > What's the logic behind the "ldo4_sm2" v.s. "sm2" naming? Does it match
> > the data sheet in some way? If not, it might be better to name this
> > something like "tps6586x_ldo4_voltages" and "tps65863_ldo4_voltages".
> > 
> 
> This table is used for the TPS6586X (e.g. TPS658621A/D, maybe others)
> variant for the LDO_4 regulator. The same table applies for TPS658623
> for the SM2 regulator as well, so this naming should reflect that fact.
> 
> I could be some more verbose, e.g. tps6586x_ldo4_tps658623_sm2_voltages.
> The other solution would be to create two independent (but identically)
> voltage tables, but takes up more space...

If you only want that name for clarity, perhaps you could just add a
#define instead of duplicating the whole array. That way you'll be able
to reference the same array by a different name (for clarity).

> >> +/* Add version specific entries before any */
> >>  static struct tps6586x_regulator tps6586x_regulator[] = {
> >>  	TPS6586X_SYS_REGULATOR(),
> >> -	TPS6586X_LDO(LDO_0, "vinldo01", ldo0, SUPPLYV1, 5, 3, ENC, 0, END, 0),
> > ...
> >> +	TPS6586X_LDO(TPS6586X_ANY, LDO_0, "vinldo01", tps6586x_ldo0, SUPPLYV1,
> >> +			5, 3, ENC, 0, END, 0),
> > 
> > Rather than changing all the macros and table entries, wouldn't it be
> > much simpler to:
> > 
> > 1) Make tps6586x_regulator[] only contain all the common regulator
> > definitions.
> > 
> > 2) Add new version-specific tables for each version of regulator, so
> > tps6586x_other_regulator[] and tps65863_regulator[].
> > 
> > 3) Have probe() walk multiple tables of regulators, selecting which
> > tables to walk based on version.
> > 
> > That would result in a much smaller and less invasive diff.
> 
> Hm, sounds easier yes. Would also remove the need for correct ordering,
> which is a bit ugly. I will try that, lets see how this works out.

I was going to propose something similar, good that I read the whole
thread at first. My idea would have been to duplicate some of the tables
for simplicity and just have a tps6586x_regulator[] array with all those
that use the "default" set of regulators and separate tables for each
variant. That's obviously suboptimal because it wastes some space, but
it keeps the code simpler, since you'll just have to select a single
array and register that.

What Stephen proposes isn't really all that complex, though, so I'd
prefer that.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131128/4f12358b/attachment.sig>
