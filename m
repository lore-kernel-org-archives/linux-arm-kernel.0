From: balbi@ti.com (Felipe Balbi)
Date: Mon, 27 Jun 2011 11:00:37 +0300
Subject: [PATCH] OMAP4: PANDA, SDP: Fix EHCI regulator supply
In-Reply-To: <BANLkTin=-cRC_ax8AakMD1UZtU+AQ0H==w@mail.gmail.com>
References: <1308926240-13888-1-git-send-email-jaswinder.singh@linaro.org>
	<BANLkTin=-cRC_ax8AakMD1UZtU+AQ0H==w@mail.gmail.com>
Message-ID: <20110627080036.GB2508@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 24, 2011 at 10:37:56PM +0530, Jaswinder Singh wrote:
> [CC'ing Liam and Mark as well]
> 
> On 24 June 2011 20:07, Jassi Brar <jaswinder.singh@linaro.org> wrote:
> > VUSB is a fixed level line and hence have no set_voltage
> > callback in regulator ops, but has apply_uV set to true.
> > As a result it fails to register with the regulator core.
> > Remove setting apply_uV.
> >
> > Also, assign name to VUSB supply, without which regulator core
> > fails to find it and assigns the default 'dummy' regulator to
> > the ehci-omap device.
> >
> > Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> > ---
> > ?arch/arm/mach-omap2/board-4430sdp.c ? ?| ? ?6 +++++-
> > ?arch/arm/mach-omap2/board-omap4panda.c | ? ?6 +++++-
> > ?2 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> > index 63de2d3..1ec60be 100644
> > --- a/arch/arm/mach-omap2/board-4430sdp.c
> > +++ b/arch/arm/mach-omap2/board-4430sdp.c
> > @@ -504,16 +504,20 @@ static struct regulator_init_data sdp4430_vdac = {
> > ? ? ? ?},
> > ?};
> >
> > +static struct regulator_consumer_supply sdp4430_vusb_supply =
> > + ? ? ? REGULATOR_SUPPLY("hsusb0", "ehci-omap.0");

this should be an array.

> > ?static struct regulator_init_data sdp4430_vusb = {
> > ? ? ? ?.constraints = {
> > ? ? ? ? ? ? ? ?.min_uV ? ? ? ? ? ? ? ? = 3300000,
> > ? ? ? ? ? ? ? ?.max_uV ? ? ? ? ? ? ? ? = 3300000,
> > - ? ? ? ? ? ? ? .apply_uV ? ? ? ? ? ? ? = true,
> > ? ? ? ? ? ? ? ?.valid_modes_mask ? ? ? = REGULATOR_MODE_NORMAL
> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| REGULATOR_MODE_STANDBY,
> > ? ? ? ? ? ? ? ?.valid_ops_mask ?= ? ? ?REGULATOR_CHANGE_MODE
> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| REGULATOR_CHANGE_STATUS,
> > ? ? ? ?},
> > + ? ? ? .num_consumer_supplies ?= 1,

ARRAY_SIZE()

> > + ? ? ? .consumer_supplies ? ? ?= &sdp4430_vusb_supply,

drop the &.

ditto to other.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110627/373e8a39/attachment-0001.sig>
