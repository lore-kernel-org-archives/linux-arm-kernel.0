From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 22 Jan 2015 10:29:47 -0800
Subject: [PATCH v2] ARM: qcom: Fix SCM interface for big-endian kernels
In-Reply-To: <EF8384DD-D1D4-40F8-BCD7-D6516E923120@codeaurora.org>
References: <1421868075-20471-1-git-send-email-sboyd@codeaurora.org>
 <EF8384DD-D1D4-40F8-BCD7-D6516E923120@codeaurora.org>
Message-ID: <20150122182947.GK27202@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22, Kumar Gala wrote:
> 
> On Jan 21, 2015, at 1:21 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> 
> > The secure environment only runs in little-endian mode, so any
> > buffers shared with the secure environment should have their
> > contents converted to little-endian. We also mark such elements
> > with __le32 to allow sparse to catch such problems.
> > 
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> > 
> > Changes since v1:
> > * Rebased onto Kumar's qcom/soc branch
> > 
> > drivers/soc/qcom/scm-boot.c |  8 ++++----
> > drivers/soc/qcom/scm.c      | 30 ++++++++++++++++--------------
> > 2 files changed, 20 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/soc/qcom/scm-boot.c b/drivers/soc/qcom/scm-boot.c
> > index 1822b13bbc10..af16fcc8d5cb 100644
> > --- a/drivers/soc/qcom/scm-boot.c
> > +++ b/drivers/soc/qcom/scm-boot.c
> > @@ -27,12 +27,12 @@
> > int scm_set_boot_addr(u32 addr, int flags)
> > {
> > 	struct {
> > -		unsigned int flags;
> > -		phys_addr_t  addr;
> > +		__le32 flags;
> > +		__le32 addr;
> 
> How does this work?  How can we go from phys_addr_t back to __le32 on LPAE or 64-bit systems?
> 

I guess I missed updating this in the patch titled "Clarify boot
interface". In that patch we should have updated addr to be a u32
(or __le32 as is done here). From what I can tell by looking at
the codeaurora tree this is still 32 bits wide even on 64-bit
platforms.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
