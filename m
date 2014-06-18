From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 18 Jun 2014 14:44:26 +0200
Subject: [PATCH v4 4/7] regulator: axp20x: reset probe data before each
 probe
In-Reply-To: <53A13BBF.7090202@free-electrons.com>
References: <1402990723-28138-1-git-send-email-boris.brezillon@free-electrons.com>
 <1402990723-28138-5-git-send-email-boris.brezillon@free-electrons.com>
 <20140617204449.GD19730@lukather>
 <53A13BBF.7090202@free-electrons.com>
Message-ID: <20140618124426.GU19730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 09:11:59AM +0200, Boris BREZILLON wrote:
> 
> On 17/06/2014 22:44, Maxime Ripard wrote:
> > On Tue, Jun 17, 2014 at 09:38:40AM +0200, Boris BREZILLON wrote:
> >> The init_data and of_node fields of the axp2xx_matches tables are filled
> >> at each device probe by the axp20x_regulator_parse_dt function (which then
> >> calls the of_regulator_match function).
> >> This means we can probe a new device and consider data initialized during
> >> the probe of another device as valid.
> >>
> >> Reset init_data and of_node field to NULL before each probe in order to
> >> avoid this kind of issue.
> >>
> >> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> >> ---
> >>  drivers/regulator/axp20x-regulator.c | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> >> index 7a30f49..d42bf6d 100644
> >> --- a/drivers/regulator/axp20x-regulator.c
> >> +++ b/drivers/regulator/axp20x-regulator.c
> >> @@ -324,6 +324,15 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
> >>  		nregulators = AXP20X_REG_ID_MAX;
> >>  	}
> >>  
> >> +	/*
> >> +	 * Reset matches table (this table might have been modified by a
> >> +	 * previous AXP2xx device probe).
> >> +	 */
> >> +	for (i = 0; i < nmatches; i++) {
> >> +		matches[i].init_data = NULL;
> >> +		matches[i].of_node = NULL;
> >> +	}
> >> +
> > That looks rather hackish, especially since we've never been in such a
> > case yet, since we have a single PMIC in our system.
> 
> Even if something is unlikely to happen, it doesn't mean it's impossible.
> I'm pretty sure there are (or will be) some systems containing several
> identical PMICs in the wild, and fixing this possible bug now prevents
> us (or other developers) from having a big headache debugging this in
> the future.
> 
> BTW, what is hackish in this code ?

Pretty what Hans was saying, either you think that there will only be
one single instance of the driver, and using a global definition is
fine, or you can have several instances of the driver, and in this
case you'll use a dynamic allocation, but you seem to be stuck in
between.

I understand that you might not want to redeclare by hand the whole
match content, so maybe you can just use memcpy from the global
definition then.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/a59d6c95/attachment.sig>
