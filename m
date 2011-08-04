From: nm@ti.com (Menon, Nishanth)
Date: Thu, 4 Aug 2011 18:33:51 -0500
Subject: [PATCH v2 2/6] OMAP4: ID: add omap_has_feature for max freq
	supported
In-Reply-To: <1309573826-10615-3-git-send-email-rnayak@ti.com>
References: <1309573826-10615-1-git-send-email-rnayak@ti.com>
	<1309573826-10615-2-git-send-email-rnayak@ti.com>
	<1309573826-10615-3-git-send-email-rnayak@ti.com>
Message-ID: <CAOMWX4eMPfDqNBWj=ROOw_5wF0cq-v8-ske5JeCkMAyzFQu4bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 1, 2011 at 21:30, Rajendra Nayak <rnayak@ti.com> wrote:

[...]

> +static void __init omap4_check_features(void)
> +{
> + ? ? ? u32 si_type;
> +
> + ? ? ? if (cpu_is_omap443x())
> + ? ? ? ? ? ? ? omap_features |= OMAP4_HAS_MPU_1GHZ;
> +
> +
> + ? ? ? if (cpu_is_omap446x()) {
> + ? ? ? ? ? ? ? si_type =
> + ? ? ? ? ? ? ? ? ? ? ? read_tap_reg(OMAP4_CTRL_MODULE_CORE_STD_FUSE_PROD_ID_1);
> + ? ? ? ? ? ? ? switch ((si_type & (3 << 16)) >> 16) {
> + ? ? ? ? ? ? ? case 2:
> + ? ? ? ? ? ? ? ? ? ? ? /* High performance device */
> + ? ? ? ? ? ? ? ? ? ? ? omap_features |= OMAP4_HAS_MPU_1_5GHZ;
> + ? ? ? ? ? ? ? ? ? ? ? break;
I have seen http://www.mail-archive.com/linux-omap at vger.kernel.org/msg51988.html
and I disagree with this.

We are setting up a standard for all future silicon that omap_features
if it contains a higher frequency will always support all lower
frequencies in omap_feature. This may be convinent for the moment,
BUT, I disagree with the approach as we cannot guarantee that this
will be the approach for all silica in the future and approach taken
here could be considered short-sighted. if 1.2GHz will be supported
then a check for omap_has_1_2GHz should be true as well - which this
patch will fail to support. E.g. on 4460 has_1GHz should'nt return
true as it is 920MHz, but the check for 1_2GHz should be true - which
it wont as return omap_features & OMAP3_HAS_ ##flag;     will not have
BIT(9) set.


Regards,
Nishanth Menon
> + ? ? ? ? ? ? ? case 1:
> + ? ? ? ? ? ? ? default:
> + ? ? ? ? ? ? ? ? ? ? ? /* Standard device */
> + ? ? ? ? ? ? ? ? ? ? ? omap_features |= OMAP4_HAS_MPU_1_2GHZ;
> + ? ? ? ? ? ? ? ? ? ? ? break;
> + ? ? ? ? ? ? ? }
> + ? ? ? }
> +}
[...]
