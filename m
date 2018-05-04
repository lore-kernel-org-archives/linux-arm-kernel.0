From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 4 May 2018 13:31:52 -0300
Subject: [PATCH] ARM: dts: imx7s: Pass the 'fsl,sec-era' property
In-Reply-To: <20180504071926.GT3443@dragon>
References: <1524601519-23502-1-git-send-email-festevam@gmail.com>
 <20180504071926.GT3443@dragon>
Message-ID: <CAOMZO5AVjFCad4PC20X5PqMuKGJQ2cOSBnqbGw+ngYCODL2vmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Fri, May 4, 2018 at 4:19 AM, Shawn Guo <shawnguo@kernel.org> wrote:

> The property is documented as optional in the bindings.  Missing the
> property shouldn't cause any fatal error, I guess.

The CAAM drivers uses the era information in many places:

drivers/crypto/caam/caamalg.c:  if (ctrlpriv->era >= 6) {
drivers/crypto/caam/caamalg.c:  if (ctrlpriv->era < 3)
drivers/crypto/caam/caamalg.c:  if (priv->era >= 6 && uses_dkp)
drivers/crypto/caam/caamalg_desc.c:     if (era < 6) {
drivers/crypto/caam/caamalg_desc.c:     /* Class 2 operation */
drivers/crypto/caam/caamalg_desc.c:     if (era < 6) {
drivers/crypto/caam/caamalg_desc.c:     /* Class 2 operation */
drivers/crypto/caam/caamalg_desc.c:     if (era < 6) {

If the era information is not provided the value of -524 (-ENOTSUPP)
will be used, so all the above logic will not operate correctly.

I have sent a patch that allows the era information to be retrieved
via CAAM registers:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/crypto/caam/ctrl.c?h=next-20180424&id=654f2b937b389295581bcb4aa26011a63db7bc8f

but this will only land in 4.18.

In order to avoid i.MX7 to report the incorrect era information in
4.17 I suggest that this patch should be applied for 4.17-rc.

Also, the other i.mx SoCs pass the fsl,sec-era in their dts.

Thanks
